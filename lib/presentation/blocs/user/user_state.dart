part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class GetLanguageStateLoading extends UserState {}

final class GetLanguageStateLoaded extends UserState {
  final GetLanguage getLanguage;

  const GetLanguageStateLoaded({required this.getLanguage});

  @override
  List<Object> get props => [getLanguage];
}

final class GetLanguageStateFailed extends UserState {
  final String error;

  const GetLanguageStateFailed({required this.error});

  @override
  List<Object> get props => [error];
}
