import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/pokedex.dart';
import 'package:pokedex/model/pokemon_detay.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Pokedex pokedex;
  Future<Pokedex> veri;

  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(url);
    var decodedJson = json.decode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex;
  }

  @override
  void initState() {
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Pokedex")),
      ),
      body: OrientationBuilder(
        // ignore: missing_return
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return FutureBuilder(
                future: veri,
                // ignore: missing_return
                builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                  //or hasdata
                  if (gelenPokedex.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (gelenPokedex.connectionState ==
                      ConnectionState.done) {
                    // return GridView.builder(
                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2),
                    //     itemBuilder: (context, index) {
                    //       return Text(gelenPokedex.data.pokemon[index].name);
                    //     });
                    /*or*/
                    return GridView.count(
                      crossAxisCount: 2,
                      children: gelenPokedex.data.pokemon.map((poki) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetay(pokemon: poki),
                            ));
                          },
                          child: Hero(
                            tag: poki.img,
                            child: Card(
                              elevation: 6,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 200,
                                    height: 150,
                                    child: FadeInImage.assetNetwork(
                                        placeholder: "assets/loading.gif",
                                        image: poki.img,
                                        fit: BoxFit.contain),
                                  ),
                                  Text(
                                    poki.name,
                                    style: TextStyle(
                                        fontSize: 22,
                                        //color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                });
          } else {
            return FutureBuilder(
                future: veri,
                // ignore: missing_return
                builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                  //or hasdata
                  if (gelenPokedex.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (gelenPokedex.connectionState ==
                      ConnectionState.done) {
                    // return GridView.builder(
                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2),
                    //     itemBuilder: (context, index) {
                    //       return Text(gelenPokedex.data.pokemon[index].name);
                    //     });
                    /*or*/
                    return GridView.extent(
                      maxCrossAxisExtent: 300,
                      children: gelenPokedex.data.pokemon.map((poki) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetay(pokemon: poki),
                            ));
                          },
                          child: Hero(
                            tag: poki.img,
                            child: Card(
                              elevation: 6,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Container(
                                      //width: 200,
                                      height: 150,
                                      child: FadeInImage.assetNetwork(
                                          placeholder: "assets/loading.gif",
                                          image: poki.img,
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  Text(
                                    poki.name,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                });
          }
        },
      ),
    );
  }
}
