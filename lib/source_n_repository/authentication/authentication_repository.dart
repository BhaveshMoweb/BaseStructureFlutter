import 'dart:async';

import 'package:base_structure/utils/strings.dart';

import '../../api_helper/api_result.dart';
import '../../constants/handle_api_error.dart';
import '../../model/login_request.dart';
import '../../model/login_response.dart';
import '../../utils/app_preference.dart';
import 'authentication_datasource.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

/// Repository class for authentication
class AuthenticationRepository {
  AuthenticationRepository({
    required AuthenticationDataSource authDataSource,
  }) : _authDataSource = authDataSource;

  final AuthenticationDataSource _authDataSource;

  final _controller = StreamController<AuthenticationStatus>();

  /// Method for user login
  Future<ApiResult<LoginResponse>> loginUser(
      {required LoginRequest requestData}) async {
    try {
      final result = await _authDataSource.loginUser(requestData: requestData);

      LoginResponse loginResponse = LoginResponse.fromJson(result);

      if ((result as Map).containsKey("token")) {
        await AppPreference.instance.saveLoginResponse(loginResponse);
        return ApiResult.success(data: loginResponse);
      } else {
        return const ApiResult.failure(error: Strings.somethingWentWrong);
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  void dispose() => _controller.close();
}
