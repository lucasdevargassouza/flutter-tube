import 'package:flutter/material.dart';
import 'package:fluttertube/pages/home/home-bloc.dart';
import 'package:fluttertube/shared/delegates/data-search.dart';
import 'package:fluttertube/shared/models/video-model.dart';
import 'package:fluttertube/shared/widgets/video-tile.dart';

class HomePage extends StatelessWidget {
  final HomeBloc _homeBloc = HomeBloc();
  // final HomeBloc homeBloc = BlocProvider.getBloc<HomeBloc>(); Não funciona!

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

              if (result != null) _homeBloc.inSearch.add(result);
            },
          ),
        ],
      ),
      body: StreamBuilder<List<VideoModel>>(
        stream: _homeBloc.outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.length == 0) {
            return Center(
              child: Text(
                "Busque por algo e vai aparecer aqui!",
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length)
                  return VideoTile(snapshot.data[index]);
                else {
                  _homeBloc.inSearch.add(null);
                  return Container(
                    padding: EdgeInsets.all(10),
                    width: 40,
                    height: 60,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
