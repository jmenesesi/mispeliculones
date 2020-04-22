import 'package:flutter/material.dart';
import 'package:mispeliculones/src/models/pelicula_model.dart';
import 'package:mispeliculones/src/providers/peliculas_provider.dart';
import 'package:mispeliculones/src/widgets/actor_horizontal.dart';

class PeliculaDetallePage extends StatelessWidget {

  final PeliculasProvider provider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                FutureBuilder(
                  future: provider.getCast(pelicula.id),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return ActorHorizontal(actores: snapshot.data);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ]
            )
          )
        ],
      ),
    );
  }
}

Widget _descripcion(Pelicula pelicula) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    child: Text(pelicula.overview,
      textAlign: TextAlign.justify,
    ),
  );
}

_posterTitulo(BuildContext context, Pelicula pelicula) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: <Widget>[
        Hero(
          tag: pelicula.uniqueId,
          
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
                    child: Image(
              image: NetworkImage(pelicula.getPosterImage()),
              height: 150.0,
            ),
          ),
        ),
        SizedBox(width: 20.0,),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(pelicula.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis,),
              Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis,),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis,)
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          overflow: TextOverflow.ellipsis
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackdropPathmage()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
          //fadeInDuration: Duration(microseconds: 150),
        ),
      ),
    );
}