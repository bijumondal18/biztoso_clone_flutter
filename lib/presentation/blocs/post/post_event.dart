part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class PostFirstLoadRequested extends PostEvent {
  const PostFirstLoadRequested();
}

class PostNextPageRequested extends PostEvent {
  const PostNextPageRequested();
}

class PostRefreshed extends PostEvent {
  const PostRefreshed();
}
