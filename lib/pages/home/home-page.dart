import 'package:flutter/material.dart';
import 'package:fluttertube/shared/delegates/data-search.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: (){},
          ),
          IconButton(
            tooltip: "Buscar vídeo",
            icon: Icon(Icons.search),
            onPressed: () async {
              String query = await showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
