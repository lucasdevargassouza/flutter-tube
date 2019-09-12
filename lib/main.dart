import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/pages/home/home-bloc.dart';
import 'package:fluttertube/pages/home/home-page.dart';
import 'package:fluttertube/shared/services/apis/api-youtube.dart';

void main() {
  ApiYouTube api = ApiYouTube();

  api.search("minions");

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => HomeBloc(), singleton: false),
      ],
      child: MaterialApp(
        title: 'Flutter Tube',
        theme: ThemeData(fontFamily: "Arial"),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
