import 'package:dio/dio.dart';

import '../../core/api_service/dio_client.dart';
import '../../core/api_service/end_points.dart';
import '../models/blog_response.dart';

class BlogRepository {
  final DioClient _client;

  BlogRepository({DioClient? client})
      : _client = client ?? DioClient(baseUrl: ApiEndPoints.baseAuth);

  Future<BlogResponse> fetchBlogs() async {
    final res = await _client.get(
      ApiEndPoints.fetchBlogList,
    );

    if (res == null || res.statusCode != 200) {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndPoints.feedListUrl),
        error: 'Failed to fetch posts (status: ${res?.statusCode})',
      );
    }

    return BlogResponse.fromJson(res.data as Map<String, dynamic>);
  }

}