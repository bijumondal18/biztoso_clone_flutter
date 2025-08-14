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

// ------------------------ All connection list ---------------------------//
final class AllConnectionListStateLoading extends UserState {}

final class AllConnectionListStateLoaded extends UserState {
  final AllConnectionResponse allConnectionResponse;

  const AllConnectionListStateLoaded({required this.allConnectionResponse});

  @override
  List<Object> get props => [allConnectionResponse];
}

final class AllConnectionListStateFailed extends UserState {
  final String error;

  const AllConnectionListStateFailed({required this.error});

  @override
  List<Object> get props => [error];
}

// ------------------------ Get Sent connection requests list ---------------------------//
final class SentConnectionRequestStateLoading extends UserState {}

final class SentConnectionRequestStateLoaded extends UserState {
  final ConnectionSentResponse connectionSentResponse;

  /// NEW: track items that are mid-action (e.g., cancel)
  final Set<String> inProgressIds;

  const SentConnectionRequestStateLoaded({
    required this.connectionSentResponse,
    this.inProgressIds = const {},
  });

  SentConnectionRequestStateLoaded copyWith({
    ConnectionSentResponse? connectionSentResponse,
    Set<String>? inProgressIds,
  }) {
    return SentConnectionRequestStateLoaded(
      connectionSentResponse:
      connectionSentResponse ?? this.connectionSentResponse,
      inProgressIds: inProgressIds ?? this.inProgressIds,
    );
  }

  @override
  List<Object> get props => [connectionSentResponse, inProgressIds];
}

final class SentConnectionRequestStateFailed extends UserState {
  final String error;

  const SentConnectionRequestStateFailed({required this.error});

  @override
  List<Object> get props => [error];
}

// ------------------------ Get Received connection requests list ---------------------------//
final class ReceivedConnectionRequestStateLoading extends UserState {}

final class ReceivedConnectionRequestStateLoaded extends UserState {
  final ConnectionReceivedResponse connectionReceivedResponse;

  const ReceivedConnectionRequestStateLoaded({
    required this.connectionReceivedResponse,
  });

  @override
  List<Object> get props => [connectionReceivedResponse];
}

final class ReceivedConnectionRequestStateFailed extends UserState {
  final String error;

  const ReceivedConnectionRequestStateFailed({required this.error});

  @override
  List<Object> get props => [error];
}

// ------------------------ Get Received connection requests list ---------------------------//
final class CancelConnectionRequestStateLoading extends UserState {}

final class CancelConnectionRequestStateLoaded extends UserState {
  final ResponseMessage message;

  const CancelConnectionRequestStateLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

final class CancelConnectionRequestStateFailed extends UserState {
  final String error;

  const CancelConnectionRequestStateFailed({required this.error});

  @override
  List<Object> get props => [error];
}
