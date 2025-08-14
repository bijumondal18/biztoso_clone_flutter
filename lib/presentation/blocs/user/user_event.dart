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

class GetConnectionsEvent extends UserEvent {}

class AllConnectionsListEvent extends UserEvent {}

class SentRequestConnectionsListEvent extends UserEvent {}

class ReceivedRequestConnectionsListEvent extends UserEvent {}

class CancelConnectionRequestEvent extends UserEvent {
  final String userId;

  const CancelConnectionRequestEvent({required this.userId});
}
