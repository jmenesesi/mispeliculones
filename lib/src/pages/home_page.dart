import 'package:flutter/material.dart';
import 'package:mispeliculones/src/models/pelicula_model.dart';
import 'package:mispeliculones/src/providers/peliculas_provider.dart';
import 'package:mispeliculones/src/search/search_delegate.dart';
import 'package:mispeliculones/src/widgets/card_swiper_widget.dart';
import 'package:mispeliculones/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cine'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperTarjetas(), _footer(context)],
          ),
        ));
  }

  _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data,
          );
        } else {
          return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

Widget _footer(BuildContext context) {
  peliculasProvider.getPopulares();
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
          'Populares',
          style: Theme.of(context).textTheme.subhead,
        ),
        ),
        SizedBox(height: 15.0,),
        StreamBuilder(
          stream: peliculasProvider.popularesStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return MovieHorizontal(
                peliculas:  snapshot.data,
                nextPage: peliculasProvider.getPopulares,
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
        ),
      ],
    ),
  );
}


}