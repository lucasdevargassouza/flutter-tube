import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/shared/models/video-model.dart';

class FavoritosBloc implements BlocBase {

  Map<String, VideoModel> _favoritos = {};

  final StreamController<Map<String, VideoModel>> _favController = StreamController<Map<String, VideoModel>>.broadcast();
  Stream<Map<String, VideoModel>> get outFav => _favController.stream;



  void toggleFavorito(VideoModel video) {
    if (_favoritos.containsKey(video.id)) _favoritos.remove(video.id);
    else _favoritos[video.id] = video;

    _favController.sink.add(_favoritos);
  }

  @override
  void addListener(listener) {}

  @override
  void dispose() {
    _favController.close();
  }

  @override
  bool get hasListeners => null;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}
