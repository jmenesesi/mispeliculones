import 'package:flutter/material.dart';
import 'package:mispeliculones/src/models/pelicula_model.dart';
import 'package:mispeliculones/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

  final provider = PeliculasProvider();

  final peliculas = [
    'Civil War',
    'El hoyo',
    'Avengers End Game',
    'Avengers Infinity War',
    'Bad Boys III',
    'Jumangi',
    'Shazam!',
    'Iron Man 3'
  ];

  final peliculasRecientes = [
    'Civil War',
    'El hoyo'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Van a ser las acciones de nuestro appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          print("Limpiando");
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        print("Leading icon");
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Las sugerencias que aparecen cuando la persona escribe
    /*
    final listaSugerida = (query.isEmpty 
      ? peliculasRecientes : 
        peliculas.where((p) => p.toLowerCase().startsWith(query.toLowerCase().trim()))
      ).toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: () {},
        );
      }
    );
    */

    if(query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: provider.search(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              final pelicula = snapshot.data[i];
              pelicula.uniqueId = "${pelicula.id}-search";
              return ListTile(
                leading: Hero(
                    tag: pelicula.uniqueId,
                                  child: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImage()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, 'pelicula', arguments: pelicula);
                },
              );
            }
          );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

}