import 'dart:async';

import '../../api_helper/app_http.dart';
import '../../constants/api_end_points.dart';

/// Datasource class for Products

class ProductListDataSource extends HttpActions {
  /// Method to get products
  Future<dynamic> getProducts() async {
    final response = await getMethod(ApiEndPoints.productsListApi);
    return response;
  }
}
