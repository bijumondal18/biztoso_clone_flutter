import 'package:dio/dio.dart';

import '../../core/api_service/dio_client.dart';
import '../../core/api_service/end_points.dart';
import '../models/login_response.dart';

class AuthRepository{
  final DioClient _client;

  AuthRepository({DioClient? client})
      : _client = client ?? DioClient(baseUrl: ApiEndPoints.baseAuth);

  Future<LoginResponse> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final res = await _client.get(
      ApiEndPoints.loginWithEmailUrl,
    );

    if (res == null || res.statusCode != 200) {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndPoints.feedListUrl),
        error: 'Failed to fetch posts (status: ${res?.statusCode})',
      );
    }

    return LoginResponse.fromJson(res.data as Map<String, dynamic>);
  }
}