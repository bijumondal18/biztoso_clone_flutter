part of 'selected_media_for_post_cubit.dart';

class SelectedMediaForPostState extends Equatable {
  final List<AssetEntity> images;
  final List<AssetEntity> videos;

  const SelectedMediaForPostState({
    this.images = const [],
    this.videos = const [],
  });

  List<AssetEntity> get all => [...images, ...videos];

  List<String> get ids => all.map((e) => e.id).toList(growable: false);

  SelectedMediaForPostState copyWith({
    List<AssetEntity>? images,
    List<AssetEntity>? videos,
  }) => SelectedMediaForPostState(
    images: images ?? this.images,
    videos: videos ?? this.videos,
  );

  // Compare by ids only → prevents unnecessary rebuilds and flicker
  @override
  List<Object?> get props => [ids];
}
