import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube/pages/home/favoritos-bloc.dart';
import 'package:fluttertube/shared/models/video-model.dart';
import 'package:fluttertube/shared/services/apis/api-youtube.dart';

class VideoTile extends StatelessWidget {
  final VideoModel _videoModel;
  final FavoritosBloc _favoritosBloc = BlocProvider.getBloc<FavoritosBloc>();

  VideoTile(this._videoModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: InkWell(
              onTap: () => FlutterYoutube.playYoutubeVideoById(
                  apiKey: API_KEY, videoId: _videoModel.id),
              child: Image.network(_videoModel.thumb, fit: BoxFit.cover),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () => FlutterYoutube.playYoutubeVideoById(
                      apiKey: API_KEY, videoId: _videoModel.id),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          _videoModel.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          _videoModel.channel,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<Map<String, VideoModel>>(
                  stream: _favoritosBloc.outFav,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        icon: Icon(
                          snapshot.data.containsKey(_videoModel.id)
                              ? Icons.star
                              : Icons.star_border,
                        ),
                        iconSize: 30,
                        onPressed: () =>
                            _favoritosBloc.toggleFavorito(_videoModel),
                        color: Colors.white,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
