import 'package:get_it/get_it.dart';

import '../api_service/dio_client.dart';
import '../api_service/token_storage.dart';

final sl = GetIt.instance;

void serviceLocator() {
  sl.registerLazySingleton<TokenStorage>(() => SecureTokenStorage());
  sl.registerLazySingleton<DioClient>(() => DioClient());
}