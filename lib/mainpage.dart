import 'package:flutter/material.dart';
import 'package:kuismobile/detailpage.dart';
import 'package:kuismobile/pokemon_data.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Pokedex'),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: listPokemon.length,
        itemBuilder: (context, index) {
          final PokemonData place = listPokemon[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailPage(jenis: place, place: place);
              }));
            },
            child: Card(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Image.network(place.image),
                  ),
                  SizedBox(width: 20),
                  Text(place.name)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
