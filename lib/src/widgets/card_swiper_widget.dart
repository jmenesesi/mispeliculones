import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mispeliculones/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas });

  @override
  Widget build(BuildContext context) {

    final _ScreenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      
      child: new Swiper(
          itemBuilder: (BuildContext context,int index){
            peliculas[index].uniqueId = "${peliculas[index].id}-tarjeta";
            return 
            Hero(
              tag: peliculas[index].uniqueId,
                          child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'pelicula', arguments: peliculas[index]),
                                  child: FadeInImage(
                    image: NetworkImage( peliculas[index].getPosterImage() ),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            );
          },
          itemCount: peliculas.length,
          itemWidth: _ScreenSize.width * 0.7,
          itemHeight: _ScreenSize.height * 0.5,
          
          layout: SwiperLayout.STACK,
        ),
    );
  }
}