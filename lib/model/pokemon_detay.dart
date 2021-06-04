import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/model/pokedex.dart';

class PokemonDetay extends StatefulWidget {
  Pokemon pokemon;

  PokemonDetay({this.pokemon});

  @override
  _PokemonDetayState createState() => _PokemonDetayState();
}

class _PokemonDetayState extends State<PokemonDetay> {
  Color baskinRenk = Colors.deepOrangeAccent;
  PaletteGenerator paletteGenerator;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baskinRengiBul();
  }

  void baskinRengiBul() {
    Future<PaletteGenerator> fPaletGenerator = PaletteGenerator.fromImageProvider(
        //direkt olarak pokemon değişkenine gerilemediğimizden widget. diyerek çağırıyoruz
        NetworkImage(widget.pokemon.img));
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "secilen renk :" + paletteGenerator.dominantColor.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.vibrantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baskinRenk,
      appBar: AppBar(
        backgroundColor: baskinRenk,
        elevation: 0,
        title: Text(
          widget.pokemon.name,
          textAlign: TextAlign.center,
        ),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return dikeyBody(context);
        } else {
          return yatayBody(context);
        }
      }),
    );
  }

  Widget yatayBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height * (7 / 8),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: baskinRenk),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                width: 200,
                child: Image.network(widget.pokemon.img, fit: BoxFit.fill),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //SizedBox(height: 0),
                  Text(widget.pokemon.name,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Height: " + widget.pokemon.height,
                      style: TextStyle(fontSize: 20)),
                  Text("Weight: " + widget.pokemon.weight,
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 30),
                  Text("Types",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type
                        .map((e) => Chip(
                              backgroundColor: baskinRenk,
                              label: Text(e,
                                  style: TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 30),
                  Text("Pre Evolution",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.prevEvolution != null
                        ? widget.pokemon.prevEvolution
                            .map((prevo) => Chip(
                                  backgroundColor: baskinRenk,
                                  label: Text(prevo.name,
                                      style: TextStyle(color: Colors.white)),
                                ))
                            .toList()
                        : [Text("First Form", style: TextStyle(fontSize: 20))],
                  ),
                  SizedBox(height: 30),
                  Text("Next Evolution",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution
                            .map((evo) => Chip(
                                  backgroundColor: baskinRenk,
                                  label: Text(evo.name,
                                      style: TextStyle(color: Colors.white)),
                                ))
                            .toList()
                        : [
                            Text("Last Form",
                                style: TextStyle(
                                  fontSize: 20, /*color: Colors.deepOrange*/
                                ))
                          ],
                  ),
                  SizedBox(height: 30),
                  Text("Weaknesses",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses != null
                        ? widget.pokemon.weaknesses
                            .map((weak) => Chip(
                                  backgroundColor: baskinRenk,
                                  label: Text(weak,
                                      style: TextStyle(color: Colors.white)),
                                ))
                            .toList()
                        : [Text("Immune", style: TextStyle(fontSize: 20))],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stack dikeyBody(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height * (2 / 3),
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 0),
                Text(widget.pokemon.name,
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                Text("Height: " + widget.pokemon.height,
                    style: TextStyle(fontSize: 20)),
                Text("Weight: " + widget.pokemon.weight,
                    style: TextStyle(fontSize: 20)),
                Text("Types",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.type
                      .map((e) => Chip(
                            backgroundColor: baskinRenk,
                            label:
                                Text(e, style: TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                ),
                Text("Pre Evolution",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.prevEvolution != null
                      ? widget.pokemon.prevEvolution
                          .map((prevo) => Chip(
                                backgroundColor: baskinRenk,
                                label: Text(prevo.name,
                                    style: TextStyle(color: Colors.white)),
                              ))
                          .toList()
                      : [Text("First Form", style: TextStyle(fontSize: 20))],
                ),
                Text("Next Evolution",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.nextEvolution != null
                      ? widget.pokemon.nextEvolution
                          .map((evo) => Chip(
                                backgroundColor: baskinRenk,
                                label: Text(evo.name,
                                    style: TextStyle(color: Colors.white)),
                              ))
                          .toList()
                      : [
                          Text("Last Form",
                              style: TextStyle(
                                fontSize: 20, /*color: Colors.deepOrange*/
                              ))
                        ],
                ),
                Text("Weaknesses",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.weaknesses != null
                      ? widget.pokemon.weaknesses
                          .map((weak) => Chip(
                                backgroundColor: baskinRenk,
                                label: Text(weak,
                                    style: TextStyle(color: Colors.white)),
                              ))
                          .toList()
                      : [Text("Immune", style: TextStyle(fontSize: 20))],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.pokemon.img,
            child: Container(
              width: 200,
              height: 200,
              child: Image.network(widget.pokemon.img, fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}
