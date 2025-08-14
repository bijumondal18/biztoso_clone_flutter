import 'package:get_it/get_it.dart';

import '../api_service/dio_client.dart';
import '../api_service/end_points.dart';

final sl = GetIt.instance;

void serviceLocator() {
  sl.registerLazySingleton<DioClient>(
        () => DioClient(baseUrl: ApiEndPoints.baseCore),
    instanceName: 'core',
  );

  sl.registerLazySingleton<DioClient>(
        () => DioClient(baseUrl: ApiEndPoints.baseAuth),
    instanceName: 'auth',
  );
}