import 'package:biztoso/core/api_service/dio_client.dart';
import 'package:biztoso/core/api_service/end_points.dart';
import 'package:biztoso/core/api_service/token_storage.dart';
import 'package:biztoso/data/models/login_response.dart';
import 'package:biztoso/utils/app_utils.dart';
import 'package:biztoso/utils/device_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../app/main.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DioClient _dioClient;

  AuthBloc(this._dioClient) : super(AuthInitial()) {
    // Check user is logged in or not
    on<CheckAuthStatusEvent>((event, emit) async {
      try {
        emit(CheckAuthStatusLoading());
        final token = await SecureTokenStorage().readToken();
        if (token != null && token.isNotEmpty) {
          emit(CheckAuthStatusLoaded());
        } else {
          emit(CheckAuthStatusFailed());
        }
      } catch (e) {
        emit(CheckAuthStatusFailed());
      }
    });

    // Email Login
    on<LoginWithEmailEvent>((event, emit) async {
      try {
        emit(LoginLoading());

        Map<String, dynamic> request = {
          'email': event.email,
          'password': event.password,
          'signupType': "3", // 3 -> email login
          'remember_me': true,
          'deviceName': deviceName,
          'deviceId': deviceId,
        };

        final response = await _dioClient.post(
          ApiEndPoints.loginWithEmailUrl,
          data: request,
        );
        if (response?.statusCode == 200) {
          final token = response?.data['token'];
          SecureTokenStorage().saveToken(token);
          emit(
            LoginLoaded(loginResponse: LoginResponse.fromJson(response?.data)),
          );
        } else {
          emit(LoginFailed(error: "Invalid Credentials"));
        }
      } catch (e) {
        emit(LoginFailed(error: e.toString()));
      }
    });
  }
}
