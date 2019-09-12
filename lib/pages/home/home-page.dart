import 'package:flutter/material.dart';
import 'package:fluttertube/pages/home/home-bloc.dart';
import 'package:fluttertube/shared/delegates/data-search.dart';
import 'package:fluttertube/shared/models/video-model.dart';
import 'package:fluttertube/shared/widgets/video-tile.dart';

class HomePage extends StatelessWidget {
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          height: 80,
          child: Image.asset("lib/assets/imgs/you_tube.png"),
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
        actions: <Widget>[
          Align(
            child: Text("0"),
          ),
          IconButton(
            tooltip: "Favoritos",
            icon: Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "Buscar vídeo",
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());

              if (result != null) homeBloc.inSearch.add(result);
            },
          ),
        ],
      ),
      body: StreamBuilder<List<VideoModel>>(
        stream: homeBloc.outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Busque por algo e vai aparecer aqui!"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return VideoTile(snapshot.data[index]);
              },
            );
          }
        },
      ),
    );
  }
}
