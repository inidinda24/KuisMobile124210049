import 'package:flutter/material.dart';
import 'package:kuismobile/pokemon_data.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final PokemonData jenis;

  const DetailPage({Key? key, required this.jenis, required PokemonData place})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String status = "tidak suka";
  bool suka = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.jenis.name),
        ),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: Icon((suka) ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              String text = "";
              setState(() {
                if (status == "tidak suka") {
                  text = "Berhasil menambahkan ke favorit";
                  status = "suka";
                  suka = true;
                } else if (status == "suka") {
                  text = "Berhasil menghapus dari favorit";
                  status = "tidak suka";
                  suka = false;
                }
              });

              var snackBar = SnackBar(
                content: Text(text),
                backgroundColor: (suka) ? Colors.green : Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 3,
            child: Image.network(widget.jenis.image),
          ),
          Text(
            textAlign: TextAlign.center,
            widget.jenis.name,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            "Type",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(textAlign: TextAlign.center, widget.jenis.type[0]),
          SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            "Weakness",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(textAlign: TextAlign.center, widget.jenis.weakness[0]),
          SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            "Previous Evolution",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          if (widget.jenis.prevEvolution.isNotEmpty)
            Text(textAlign: TextAlign.center, widget.jenis.prevEvolution[0]),
          SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            "Next Evolution",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          if (widget.jenis.nextEvolution.isNotEmpty)
            Text(textAlign: TextAlign.center, widget.jenis.nextEvolution[0]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launcher('${widget.jenis.wikiUrl}');
        },
        child: Icon(Icons.manage_search),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _launcher(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception("Gagal membuka url : $_url");
    }
  }

}
