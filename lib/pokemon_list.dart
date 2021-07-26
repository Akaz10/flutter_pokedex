import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/pokemon_detail.dart';
import 'model/pokedex.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  Pokedex? pokedex;

  Future pokemonlariGetir() async {
    var response = await http.get(Uri.https('raw.githubusercontent.com',
        'Biuni/PokemonGo-Pokedex/master/pokedex.json'));
    var decodedJson = json.decode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    debugPrint("uzunluk ${pokedex!.pokemon!.length.toString()}");
    return pokedex;
  }

  @override
  void initState() {
    // TODO: implement initState
    pokemonlariGetir().then((value) {
      pokedex = value;
      setState(() {});
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pokedex"),
        ),
        body: OrientationBuilder(
          builder: (context, orientation){

            if(orientation==Orientation.portrait){
              return pokedex != null ?  GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PokemonDetail(pokemon: pokedex!.pokemon![index],)));
                      },
                      child: Hero(tag: pokedex!.pokemon![index].img!, child: Card(
                        elevation: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 170,
                              width: 120,
                              child: FadeInImage.assetNetwork(placeholder: "assets/loading.gif", image: pokedex!.pokemon![index].img!,fit: BoxFit.contain,),
                            ),
                            Text(pokedex!.pokemon![index].name!, style: TextStyle(fontSize: 22, color: Colors.black,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      )),
                    );
                  }) : Container(
                child: Center(
                  child: Text("Loading"),
                ),
              );

            }
            else{
              return pokedex != null ?  GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PokemonDetail(pokemon: pokedex!.pokemon![index],)));
                      },
                      child: Hero(tag: pokedex!.pokemon![index].img!, child: Card(
                        elevation: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 170,
                              width: 120,
                              child: FadeInImage.assetNetwork(placeholder: "assets/loading.gif", image: pokedex!.pokemon![index].img!,fit: BoxFit.contain,),
                            ),
                            Text(pokedex!.pokemon![index].name!, style: TextStyle(fontSize: 22, color: Colors.black,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      )),
                    );
                  }) : Container(
                child: Center(
                  child: Text("Loading"),
                ),
              );

            }
          },
        ),
    );
  }
}
