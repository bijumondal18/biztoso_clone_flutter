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

class AllConnectionListStateLoaded extends UserState {
  final AllConnectionResponse allConnectionResponse;

  /// ids currently performing an action (show spinner)
  final Set<String> inProgressIds;

  /// ids for which a request has been sent (show "Cancel Request")
  final Set<String> requestedIds;

  const AllConnectionListStateLoaded({
    required this.allConnectionResponse,
    this.inProgressIds = const {},
    this.requestedIds = const {},
  });

  AllConnectionListStateLoaded copyWith({
    AllConnectionResponse? allConnectionResponse,
    Set<String>? inProgressIds,
    Set<String>? requestedIds,
  }) {
    return AllConnectionListStateLoaded(
      allConnectionResponse:
          allConnectionResponse ?? this.allConnectionResponse,
      inProgressIds: inProgressIds ?? this.inProgressIds,
      requestedIds: requestedIds ?? this.requestedIds,
    );
  }

  @override
  List<Object> get props => [
    allConnectionResponse,
    inProgressIds,
    requestedIds,
  ];
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

class ReceivedConnectionRequestStateLoaded extends UserState {
  final ConnectionReceivedResponse connectionReceivedResponse;

  /// NEW: ids currently performing accept/decline (to show spinner)
  final Set<String> inProgressIds;

  const ReceivedConnectionRequestStateLoaded({
    required this.connectionReceivedResponse,
    this.inProgressIds = const {},
  });

  ReceivedConnectionRequestStateLoaded copyWith({
    ConnectionReceivedResponse? connectionReceivedResponse,
    Set<String>? inProgressIds,
  }) {
    return ReceivedConnectionRequestStateLoaded(
      connectionReceivedResponse:
          connectionReceivedResponse ?? this.connectionReceivedResponse,
      inProgressIds: inProgressIds ?? this.inProgressIds,
    );
  }

  @override
  List<Object> get props => [connectionReceivedResponse, inProgressIds];
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

// ------------------------ Get Chat list ---------------------------//
final class ChatListStateLoading extends UserState {}

class ChatListStateLoaded extends UserState {
  final ChatListResponse chatListResponse;

  const ChatListStateLoaded({required this.chatListResponse});

  @override
  List<Object> get props => [chatListResponse];
}

final class ChatListStateFailed extends UserState {
  final String error;

  const ChatListStateFailed({required this.error});

  @override
  List<Object> get props => [error];
}

// ------------------------ Get Current User Profile Details ---------------------------//
final class FetchUserProfileStateLoading extends UserState {}

class FetchUserProfileStateLoaded extends UserState {
  final ProfileResponse profileResponse;

  const FetchUserProfileStateLoaded({required this.profileResponse});

  @override
  List<Object> get props => [profileResponse];
}

final class FetchUserProfileStateFailed extends UserState {
  final String error;

  const FetchUserProfileStateFailed({required this.error});

  @override
  List<Object> get props => [error];
}

// ------------------------ Fetch Current User Profile Analytics ---------------------------//
final class FetchUserProfileAnalyticsStateLoading extends UserState {}

class FetchUserProfileAnalyticsStateLoaded extends UserState {
  final ProfileAnalyticsResponse profileAnalyticsResponse;

  const FetchUserProfileAnalyticsStateLoaded({
    required this.profileAnalyticsResponse,
  });

  @override
  List<Object> get props => [profileAnalyticsResponse];
}

final class FetchUserProfileAnalyticsStateFailed extends UserState {
  final String error;

  const FetchUserProfileAnalyticsStateFailed({required this.error});

  @override
  List<Object> get props => [error];
}
