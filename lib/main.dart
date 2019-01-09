import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'model.dart';
import 'detail.dart';


var dio = Dio();

void main() => runApp(MaterialApp(
  title: '宝可梦APP',
  home: HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final url =  'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  PokemonModel pokeModel;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await dio.get(url);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      var decodedJson = jsonDecode(response.data.toString());
      pokeModel = PokemonModel.fromJson(decodedJson);
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('宝可梦APP'),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButton: FloatingActionButton(onPressed: null, child: Icon(Icons.refresh)),
      body: pokeModel == null ? Center(
        child: CircularProgressIndicator(),
      ) : GridView.count(
          crossAxisCount: 2,
          children: pokeModel.pokemon.map((poke) => Padding(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetail(pokemon: poke)));
              },
              child: Hero(
                tag: poke.img,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(poke.img)),
                        ),
                      ),
                      Text(
                        poke.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )).toList(),
      ),
    );
  }
}
