import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../utils/app_preference.dart';
import '../utils/cm_file.dart';
import '../utils/strings.dart';

class HttpActions {
  String baseUrl = dotenv.env['BASE_URL']!;
  String secondaryUrl = dotenv.env['SECONDARY_URL']!;

  /// Method for post data
  Future<dynamic> postMethod(String url,
      {dynamic data,
      Map<String, String>? headers,
      bool passRawData = false}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {}, passRawData: passRawData);
      http.Response response = await http.post(Uri.parse(baseUrl + url),
          body: data, headers: headers);

      log(utf8.decode(response.bodyBytes));
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(Strings.noInternet);
    }
  }

  /// Method for Login
  Future<dynamic> loginPostMethod(String url,
      {dynamic data,
      Map<String, String>? headers,
      bool passRawData = false}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {}, passRawData: passRawData);
      http.Response response = await http.post(Uri.parse(baseUrl + url),
          body: data, headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(Strings.noInternet);
    }
  }

  /// Method for get data
  Future<dynamic> getMethod(String url,
      {Map<String, String>? headers, String? secondaryBaseUrl}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
      http.Response response;
      if (secondaryBaseUrl != null && secondaryBaseUrl.isNotEmpty) {
        response =
            await http.get(Uri.parse(secondaryUrl + url), headers: headers);
      } else {
        response = await http.get(Uri.parse(baseUrl + url), headers: headers);
      }
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(Strings.noInternet);
    }
  }

  /// Method for download Document data
  Future<Uint8List> downloadMethod(String url,
      {Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
      http.Response response =
          await http.get(Uri.parse(baseUrl + url), headers: headers);
      return response.bodyBytes;
    } else {
      return Future.error(Strings.noInternet);
    }
  }

  Future<dynamic> patchMethod(String url,
      {dynamic data, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
      http.Response response = await http.patch(Uri.parse(baseUrl + url),
          body: data, headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(Strings.noInternet);
    }
  }

  Future<dynamic> putMethod(String url,
      {dynamic data,
      Map<String, String>? headers,
      bool passRawData = false}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {}, passRawData: passRawData);
      http.Response response = await http.put(Uri.parse(baseUrl + url),
          body: data, headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(Strings.noInternet);
    }
  }

  /// Method for delete data
  Future<dynamic> deleteMethod(String url,
      {dynamic data, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
      http.Response response = await http.delete(Uri.parse(baseUrl + url),
          body: data, headers: headers);
      return jsonDecode("${response.statusCode}");
    } else {
      Future.error(Strings.noInternet);
    }
  }

  //Method for set header for api calling
  Future<Map<String, String>> getSessionData(Map<String, String> headers,
      {bool passRawData = false, bool isMultiPart = false}) async {
    final accessToken = await AppPreference.instance.getAccessToken();
    log("Token $accessToken");

    if (passRawData) {
      headers["Content-Type"] = "application/json";
    } else if (isMultiPart) {
      headers["Content-Type"] = "multipart/form-data";
    } else {
      headers["Content-Type"] = "application/x-www-form-urlencoded";
    }
    if (accessToken.isNotEmpty == true) {
      headers["authorization"] = "Bearer $accessToken";
    }
    return headers;
  }

  /// Method for checking internet connectivity
  Future<ConnectivityResult> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult;
  }

  /// Multipart Method for uploading document
  Future<HttpClientResponse> fileUploadMultipartWithProcess(
      String url, Map<String, dynamic> body, List<String> filePaths,
      {Function(int sentBytes, int totalBytes)?
          onUploadProgressCallback}) async {
    final httpClient = HttpClient();
    final request = await httpClient.postUrl(Uri.parse(baseUrl + url));
    int byteCount = 0;

    List<http.MultipartFile> newImageList = <http.MultipartFile>[];
    for (int i = 0; i < filePaths.length; i++) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        "file",
        filePaths[i].toString(),
      );
      newImageList.add(multipartFile);
    }
    var requestMultipart =
        http.MultipartRequest("POST", Uri.parse(baseUrl + url));
    requestMultipart.files.addAll(newImageList);
    for (var entry in body.entries) {
      requestMultipart.fields[entry.key] = entry.value.toString();
    }
    Map<String, String> header = await getSessionData({}, isMultiPart: true);
    requestMultipart.headers.addAll(header);

    var msStream = requestMultipart.finalize();
    var totalByteLength = requestMultipart.contentLength;
    request.contentLength = totalByteLength;
    request.headers.set(HttpHeaders.contentTypeHeader,
        requestMultipart.headers[HttpHeaders.contentTypeHeader] ?? "");
    request.headers.set(
        HttpHeaders.authorizationHeader.toLowerCase(),
        requestMultipart
                .headers[HttpHeaders.authorizationHeader.toLowerCase()] ??
            "");
    Stream<List<int>> streamUpload = msStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;
          if (onUploadProgressCallback != null) {
            onUploadProgressCallback(byteCount, totalByteLength);
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();

          /// UPLOAD DONE;
        },
      ),
    );

    await request.addStream(streamUpload).timeout(const Duration(hours: 1),
        onTimeout: () {
      // ignore: null_argument_to_non_null_type
      return Future<HttpClientResponse>.value(null);
    });
    final httpResponse =
        await request.close().timeout(const Duration(hours: 1), onTimeout: () {
      // ignore: null_argument_to_non_null_type
      return Future<HttpClientResponse>.value(null);
    });
    var statusCode = httpResponse.statusCode;

    if (statusCode ~/ 100 != 2) {
      CM.hideProgressDialog();
      throw Exception(
          '${Strings.somethingWentWrong} : ${httpResponse.statusCode}');
    } else {
      return httpResponse;
    }
  }

  Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }

  Future<Response?> getAPICallWithHeaderDownloadIndicator(
      String url, Map<String, String> headers,
      {Map<String, String>? params,
      Function(List<int> bytes)? onDone,
      Function(int total, int received)? onUpdateProgress}) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: (received, total) {
          if (onUpdateProgress != null) {
            onUpdateProgress(total, received);
          }
        },
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            headers: headers,
            validateStatus: (status) {
              return (status ?? 0) < 500;
            }),
      ).timeout(const Duration(hours: 2), onTimeout: () {
        // ignore: null_argument_to_non_null_type
        return Future<Response>.value(null);
      });
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
