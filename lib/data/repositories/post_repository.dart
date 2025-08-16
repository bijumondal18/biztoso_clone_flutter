import 'package:dio/dio.dart';

import '../../core/api_service/dio_client.dart';
import '../../core/api_service/end_points.dart';
import '../models/post_model.dart';

class PostRepository {
  final DioClient _client;

  PostRepository({DioClient? client})
      : _client = client ?? DioClient(baseUrl: ApiEndPoints.basePost);

  Future<PostPage> fetchPage({required int page, int limit = 10}) async {
    final res = await _client.get(
      ApiEndPoints.feedListUrl,
      queryParams: {'page': page, 'limit': limit},
    );

    if (res == null || res.statusCode != 200) {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndPoints.feedListUrl),
        error: 'Failed to fetch posts (status: ${res?.statusCode})',
      );
    }

    return PostPage.fromJson(res.data as Map<String, dynamic>);
  }
}