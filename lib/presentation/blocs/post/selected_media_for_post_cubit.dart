import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'selected_media_for_post_state.dart';

class SelectedMediaForPostCubit extends Cubit<SelectedMediaForPostState> {
  SelectedMediaForPostCubit() : super(const SelectedMediaForPostState());

  static const int kMax = 5;

  void setImagesFromPicker(List<AssetEntity> picked) {
    final imgs = picked.where((e) => e.type == AssetType.image).toList();
    final allow = (kMax - state.videos.length).clamp(0, kMax);
    emit(state.copyWith(images: imgs.take(allow).toList()));
  }

  void setVideosFromPicker(List<AssetEntity> picked) {
    final vids = picked.where((e) => e.type == AssetType.video).toList();
    final allow = (kMax - state.images.length).clamp(0, kMax);
    emit(state.copyWith(videos: vids.take(allow).toList()));
  }

  void removeById(String id) {
    emit(
      state.copyWith(
        images: state.images.where((a) => a.id != id).toList(),
        videos: state.videos.where((a) => a.id != id).toList(),
      ),
    );
  }
}
