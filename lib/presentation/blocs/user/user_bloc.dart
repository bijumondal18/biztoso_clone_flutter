import 'package:biztoso/core/api_service/dio_client.dart';
import 'package:biztoso/core/api_service/end_points.dart';
import 'package:biztoso/data/models/language.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final DioClient _dioClient;

  UserBloc(this._dioClient) : super(UserInitial()) {
    // Get Language
    on<GetLanguageEvent>((event, emit) async {
      try {
        emit(GetLanguageStateLoading());

        final response = await _dioClient.get(ApiEndPoints.getLanguageUrl);
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
  }
}
