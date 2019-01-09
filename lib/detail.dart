import 'package:flutter/material.dart';
import 'model.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetail({this.pokemon});

  bodyWidget(BuildContext context) => Stack(
    children: <Widget>[
      Positioned(
        top: MediaQuery.of(context).size.height * 0.1,
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width - 20,
        left: 10.0,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 50.0,),
              Text(pokemon.name, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
              Text('升高:${pokemon.height}'),
              Text('体重:${pokemon.weight}'),
              Text('属性', style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.type.map((t) => FilterChip(
                  label: Text(t),
                  onSelected: (selected) {},
                  backgroundColor: Colors.amber,
                )).toList(),
              ),
              Text('弱点', style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.weaknesses.map((w) => FilterChip(
                  label: Text(w, style: TextStyle(color: Colors.white),),
                  onSelected: (selected) {},
                  backgroundColor: Colors.red,
                )).toList(),
              ),
              Text('进化', style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.nextEvolution.map((evo) => FilterChip(
                  label: Text(evo.name),
                  onSelected: (selected) {},
                  backgroundColor: Colors.green,
                )).toList(),
              )
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(tag: pokemon.img, child: Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(pokemon.img),
            ),
          ),
        )),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(pokemon.name),
      ),
      body: bodyWidget(context),
    );
  }
}