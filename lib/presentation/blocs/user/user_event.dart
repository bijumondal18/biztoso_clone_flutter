part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SearchConnectionsChanged extends UserEvent {
  final String query;

  const SearchConnectionsChanged({required this.query});
}

class SearchPymkChanged extends UserEvent {
  final String query;

  const SearchPymkChanged({required this.query});
}

class GetLanguageEvent extends UserEvent {}

class GetConnectionsEvent extends UserEvent {
  final String? userId;

  const GetConnectionsEvent({this.userId});

  @override
  List<Object> get props => [userId ?? ''];
}

class AllConnectionsListEvent extends UserEvent {}

class SentRequestConnectionsListEvent extends UserEvent {}

class ReceivedRequestConnectionsListEvent extends UserEvent {}

class CancelConnectionRequestEvent extends UserEvent {
  final String userId;

  const CancelConnectionRequestEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class SendConnectionRequestEvent extends UserEvent {
  final String userId;

  const SendConnectionRequestEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class AcceptReceivedInvitationEvent extends UserEvent {
  final String userId;

  const AcceptReceivedInvitationEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class DeclineReceivedInvitationEvent extends UserEvent {
  final String userId;

  const DeclineReceivedInvitationEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class GetChatListEvent extends UserEvent {}

class SearchChatsChanged extends UserEvent {
  final String query;

  const SearchChatsChanged(this.query);

  @override
  List<Object> get props => [query];
}

class FetchProfileDetailsEvent extends UserEvent {
  final String? userId;

  const FetchProfileDetailsEvent({this.userId});

  @override
  List<Object> get props => [userId ?? ''];
}
