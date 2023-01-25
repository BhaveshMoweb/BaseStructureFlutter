import 'dart:async';

import '../../../api_helper/app_http.dart';
import '../../../constants/api_end_points.dart';

/// Datasource class for Authentication

class PostListDataSource extends HttpActions {
  /// Method for get posts
  Future<dynamic> getPosts(String currentPage, String limit) async {
    final response = await getMethod(
        ApiEndPoints.postsListApi + "?_page=$currentPage&_limit=$limit",
        secondaryBaseUrl: "https://jsonplaceholder.typicode.com/");
    return response;
  }
}
