import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/shared/models/video-model.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosBloc implements BlocBase {
  Map<String, VideoModel> _favoritos = {};

  var _favController = BehaviorSubject<Map<String, VideoModel>>.seeded({});
  Stream<Map<String, VideoModel>> get outFav => _favController.stream;

  FavoritosBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favoritos")) {
        _favoritos = json.decode(prefs.getString("favoritos")).map((k, v) {
          return MapEntry(k, VideoModel.fromJson(v));
        }).cast<String, VideoModel>();

        _favController.add(_favoritos);
      }
    });
  }

  void toggleFavorito(VideoModel video) {
    if (_favoritos.containsKey(video.id))
      _favoritos.remove(video.id);
    else
      _favoritos[video.id] = video;

    _favController.sink.add(_favoritos);

    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favoritos", json.encode(_favoritos));
    });
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
