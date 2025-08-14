import 'package:biztoso/core/api_service/app_preference.dart';
import 'package:biztoso/core/api_service/dio_client.dart';
import 'package:biztoso/core/api_service/end_points.dart';
import 'package:biztoso/data/models/connection_received_response.dart';
import 'package:biztoso/data/models/connection_response.dart';
import 'package:biztoso/data/models/connection_sent_response.dart';
import 'package:biztoso/data/models/language.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    // Get Language
    on<GetLanguageEvent>((event, emit) async {
      try {
        emit(GetLanguageStateLoading());

        final response = await DioClient(
          baseUrl: ApiEndPoints.baseAuth,
        ).get(ApiEndPoints.getLanguageUrl);
        if (response?.statusCode == 200) {
          emit(
            GetLanguageStateLoaded(
              getLanguage: GetLanguage.fromJson(response?.data),
            ),
          );
        }
      } catch (e) {
        emit(GetLanguageStateFailed(error: e.toString()));
      }
    });

    // Get Connections
    on<GetConnectionsEvent>((event, emit) async {
      final userId = await AppPreference.getString(AppPreference.userId);
      try {
        emit(GetConnectionsStateLoading());

        final response = await DioClient(
          baseUrl: ApiEndPoints.baseCore,
        ).get('${ApiEndPoints.getConnectionList}/$userId');
        if (response?.statusCode == 200) {
          emit(
            GetConnectionsStateLoaded(
              connectionResponse: ConnectionResponse.fromJson(response?.data),
            ),
          );
        }
      } catch (e) {
        emit(GetConnectionsStateFailed(error: e.toString()));
      }
    });

    // Sent Connections Requests
    on<SentRequestConnectionsListEvent>((event, emit) async {
      try {
        emit(SentConnectionRequestStateLoading());

        final response = await DioClient(
          baseUrl: ApiEndPoints.baseCore,
        ).get(ApiEndPoints.sentConnectionRequestList);
        if (response?.statusCode == 200) {
          emit(
            SentConnectionRequestStateLoaded(
              connectionSentResponse: ConnectionSentResponse.fromJson(
                response?.data,
              ),
            ),
          );
        }
      } catch (e) {
        emit(SentConnectionRequestStateFailed(error: e.toString()));
      }
    });

    // Received Connections Requests
    on<ReceivedRequestConnectionsListEvent>((event, emit) async {
      try {
        emit(ReceivedConnectionRequestStateLoading());

        final response = await DioClient(
          baseUrl: ApiEndPoints.baseCore,
        ).get(ApiEndPoints.receivedConnectionRequestList);
        if (response?.statusCode == 200) {
          emit(
            ReceivedConnectionRequestStateLoaded(
              connectionReceivedResponse: ConnectionReceivedResponse.fromJson(
                response?.data,
              ),
            ),
          );
        }
      } catch (e) {
        emit(ReceivedConnectionRequestStateFailed(error: e.toString()));
      }
    });
  }
}
