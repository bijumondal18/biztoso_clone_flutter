import 'package:equatable/equatable.dart';

class PostPage extends Equatable {
  final List<Post> posts;
  final bool hasNextPage;
  final int? nextPage;

  const PostPage({
    required this.posts,
    required this.hasNextPage,
    required this.nextPage,
  });

  factory PostPage.fromJson(Map<String, dynamic> json) {
    final result = json['result'] ?? {};
    final docs = (result['docs'] as List? ?? [])
        .map((e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();

    return PostPage(
      posts: docs,
      hasNextPage: result['hasNextPage'] == true,
      nextPage: result['nextPage'] as int?,
    );
  }

  @override
  List<Object?> get props => [posts, hasNextPage, nextPage];
}

class Post extends Equatable {
  final String id;
  final String? description;
  final int? postType;
  final String? createdAt;
  final String? userName;
  final String? userId;
  final String? profilePic;
  final List<String> images;
  final OriginalPost? originalPost;

  const Post({
    required this.id,
    this.description,
    this.postType,
    this.createdAt,
    this.userName,
    this.userId,
    this.profilePic,
    this.images = const [],
    this.originalPost,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: (json['_id'] ?? '').toString(),
      description: json['description'] as String?,
      postType: json['postType'] as int?,
      createdAt: json['createdAt'] as String?,
      userName: (json['user_name'] ?? json['userName'])?.toString(),
      userId: json['userId']?.toString(),
      profilePic: json['profilePic']?.toString(),
      images: (json['images'] as List? ?? []).map((e) => e.toString()).toList(),
      originalPost: json['originalPost'] != null
          ? OriginalPost.fromJson(json['originalPost'])
          : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, description, postType, createdAt, userName, userId, profilePic, images, originalPost];
}

class OriginalPost extends Equatable {
  final String id;
  final OwnerDetails? ownerDetails;
  final String? originalDescription;
  final List<String> originalImages;

  const OriginalPost({
    required this.id,
    this.ownerDetails,
    this.originalDescription,
    this.originalImages = const [],
  });

  factory OriginalPost.fromJson(Map<String, dynamic> json) {
    return OriginalPost(
      id: (json['_id'] ?? '').toString(),
      ownerDetails: json['ownerDetails'] != null
          ? OwnerDetails.fromJson(json['ownerDetails'])
          : null,
      originalDescription: json['originalDescription'] as String?,
      originalImages:
      (json['originalImages'] as List? ?? []).map((e) => e.toString()).toList(),
    );
  }

  @override
  List<Object?> get props => [id, ownerDetails, originalDescription, originalImages];
}

class OwnerDetails extends Equatable {
  final String? ownerName;
  final String? ownerProfile;

  const OwnerDetails({this.ownerName, this.ownerProfile});

  factory OwnerDetails.fromJson(Map<String, dynamic> json) {
    return OwnerDetails(
      ownerName: json['ownerName']?.toString(),
      ownerProfile: json['ownerProfile']?.toString(),
    );
  }

  @override
  List<Object?> get props => [ownerName, ownerProfile];
}