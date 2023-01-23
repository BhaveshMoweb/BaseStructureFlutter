import 'dart:async';

import '../../api_helper/app_http.dart';
import '../../constants/api_end_points.dart';
import '../../model/login_request.dart';

/// Datasource class for Authentication

class AuthenticationDataSource extends HttpActions {
  /// Method for user login
  Future<dynamic> loginUser({
    required LoginRequest requestData,
  }) async {
    final response = await loginPostMethod(ApiEndPoints.loginEndPoints,
        data: requestData.toJson());
    return response;
  }
}
