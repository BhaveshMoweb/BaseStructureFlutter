import 'dart:async';

import 'package:base_structure/model/product_response.dart';

import '../../../api_helper/api_result.dart';
import '../../../constants/handle_api_error.dart';
import '../../../utils/strings.dart';
import 'product_list_datasource.dart';

/// Repository class for products
class ProductListRepository {
  ProductListRepository({
    required ProductListDataSource productListDataSource,
  }) : _productListSource = productListDataSource;

  final ProductListDataSource _productListSource;

  final _controller = StreamController();

  /// Method for to get products list data
  Future<ApiResult<List<ProductsResponse?>?>> getProductList() async {
    try {
      final result = await _productListSource.getProducts();
      List<ProductsResponse?>? productsResponse = [];
      for (var i in result) {
        productsResponse.add(ProductsResponse.fromJson(i));
      }

      if ((result[0] as Map).containsKey("id")) {
        return ApiResult.success(data: productsResponse);
      } else {
        return const ApiResult.failure(error: Label.somethingWentWrong);
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  void dispose() => _controller.close();
}
