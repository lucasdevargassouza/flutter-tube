import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/pages/home/favoritos-bloc.dart';
import 'package:fluttertube/pages/home/home-bloc.dart';
import 'package:fluttertube/pages/home/home-page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => HomeBloc()),
        Bloc((i) => FavoritosBloc()),
      ],
      child: BlocProvider(
        blocs: [
          Bloc((i) => FavoritosBloc()),
          Bloc((i) => HomeBloc()),
        ],
        child: MaterialApp(
          title: 'Flutter Tube',
          theme: ThemeData(fontFamily: "Arial"),
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      ),
    );
  }
}
