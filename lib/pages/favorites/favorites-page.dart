import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/pages/home/favoritos-bloc.dart';
import 'package:fluttertube/shared/models/video-model.dart';
import 'package:fluttertube/shared/widgets/video-tile.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _favoritosBloc = BlocProvider.getBloc<FavoritosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, VideoModel>>(
        stream: _favoritosBloc.outFav,
        builder: (context, snapshot) {
          if (snapshot.data.values.length == 0) {
            return Container(
              padding: EdgeInsets.all(50),
              child: Text("Nenhum vídeo ainda!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
            );
          } else {
            return ListView(
              children: snapshot.data.values.map((v) {
                return VideoTile(v);
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
