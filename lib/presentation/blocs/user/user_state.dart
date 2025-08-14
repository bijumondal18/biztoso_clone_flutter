part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

// ------------------------ Get language list ---------------------------//
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

// ------------------------ Get connections list ---------------------------//
final class GetConnectionsStateLoading extends UserState {}

final class GetConnectionsStateLoaded extends UserState {
  final ConnectionResponse connectionResponse;

  const GetConnectionsStateLoaded({required this.connectionResponse});

  @override
  List<Object> get props => [connectionResponse];
}

final class GetConnectionsStateFailed extends UserState {
  final String error;

  const GetConnectionsStateFailed({required this.error});

  @override
  List<Object> get props => [error];
}

// ------------------------ Get connections list ---------------------------//
final class SentConnectionRequestStateLoading extends UserState {}

final class SentConnectionRequestStateLoaded extends UserState {
  final ConnectionSentResponse connectionSentResponse;

  const SentConnectionRequestStateLoaded({required this.connectionSentResponse});

  @override
  List<Object> get props => [connectionSentResponse];
}

final class SentConnectionRequestStateFailed extends UserState {
  final String error;

  const SentConnectionRequestStateFailed({required this.error});

  @override
  List<Object> get props => [error];
}