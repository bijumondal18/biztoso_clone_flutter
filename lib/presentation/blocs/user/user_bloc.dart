import 'package:biztoso/core/api_service/app_preference.dart';
import 'package:biztoso/core/api_service/dio_client.dart';
import 'package:biztoso/core/api_service/end_points.dart';
import 'package:biztoso/data/models/all_connection_response.dart';
import 'package:biztoso/data/models/connection_received_response.dart';
import 'package:biztoso/data/models/connection_response.dart';
import 'package:biztoso/data/models/connection_sent_response.dart';
import 'package:biztoso/data/models/language.dart';
import 'package:biztoso/data/models/response_message.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart'; // optional

part 'user_event.dart';

part 'user_state.dart';

EventTransformer<T> debounce<T>(Duration d) {
  return (events, mapper) => events.debounceTime(d).switchMap(mapper);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  String _connectionsQuery = '';
  String _pymkQuery = '';

  String get connectionsQuery =>
      _connectionsQuery; // (optional) for restoring text
  String get pymkQuery => _pymkQuery;

  UserBloc() : super(UserInitial()) {
    on<SearchConnectionsChanged>((e, emit) {
      _connectionsQuery = e.query.trim();
      add(GetConnectionsEvent());
    }, transformer: debounce(const Duration(milliseconds: 300)));

    on<SearchPymkChanged>((e, emit) {
      _pymkQuery = e.query.trim();
      add(AllConnectionsListEvent()); // refetch PYMK only
    }, transformer: debounce(const Duration(milliseconds: 300)));

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

        final queryParams = <String, dynamic>{
          if (_connectionsQuery.isNotEmpty) 'search': _connectionsQuery,
        };

        final response = await DioClient(baseUrl: ApiEndPoints.baseCore).get(
          '${ApiEndPoints.getCurrentUsersConnectionList}/$userId',
          queryParams: queryParams,
        );
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

    // All Connections List
    on<AllConnectionsListEvent>((event, emit) async {
      try {
        emit(AllConnectionListStateLoading());
        final queryParams = <String, dynamic>{
          if (_pymkQuery.isNotEmpty) 'search': _pymkQuery,
        };
        final response = await DioClient(
          baseUrl: ApiEndPoints.baseCore,
        ).get(ApiEndPoints.allConnectionList, queryParams: queryParams);
        if (response?.statusCode == 200) {
          emit(
            AllConnectionListStateLoaded(
              allConnectionResponse: AllConnectionResponse.fromJson(
                response?.data,
              ),
            ),
          );
        }
      } catch (e) {
        emit(AllConnectionListStateFailed(error: e.toString()));
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

    // Cancel Connections Requests
    on<CancelConnectionRequestEvent>((event, emit) async {
      final cur = state;

      // 1) Optimistically mark as busy in the loaded state
      if (cur is SentConnectionRequestStateLoaded) {
        final updatedBusy = {...cur.inProgressIds}..add(event.userId);
        emit(cur.copyWith(inProgressIds: updatedBusy));
      }

      try {
        final response = await DioClient(
          baseUrl: ApiEndPoints.baseCore,
        ).put('${ApiEndPoints.cancelConnectionRequestList}/${event.userId}');
        if (response != null && response.statusCode == 200) {
          // 2) Refresh the sent list so the item disappears
          add(SentRequestConnectionsListEvent());
          return;
        }

        // Non-200: unmark busy + emit fail
        if (state is SentConnectionRequestStateLoaded) {
          final s = state as SentConnectionRequestStateLoaded;
          final updatedBusy = {...s.inProgressIds}..remove(event.userId);
          emit(s.copyWith(inProgressIds: updatedBusy));
        }
        emit(
          SentConnectionRequestStateFailed(
            error: 'Failed to cancel (${response?.statusCode ?? 'no status'})',
          ),
        );
      } catch (e) {
        // Error: unmark busy + emit fail
        if (state is SentConnectionRequestStateLoaded) {
          final s = state as SentConnectionRequestStateLoaded;
          final updatedBusy = {...s.inProgressIds}..remove(event.userId);
          emit(s.copyWith(inProgressIds: updatedBusy));
        }
        emit(CancelConnectionRequestStateFailed(error: e.toString()));
      }
    });
  }
}
