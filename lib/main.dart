//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

//import 'dart:async';
//import 'dart:convert';
import 'model/pokemon_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "pokedex",
      theme: ThemeData.dark(),
      //theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: PokemonList(),
    );
  }
}
