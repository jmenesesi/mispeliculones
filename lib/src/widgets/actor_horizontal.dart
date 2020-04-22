import 'package:flutter/material.dart';
import 'package:mispeliculones/src/models/actor_model.dart';

class ActorHorizontal extends StatelessWidget {

final List<Actor> actores;

ActorHorizontal({ @required this.actores });

final _pageController = new PageController(
  initialPage: 1,
  viewportFraction: 0.3
);
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {
      
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        itemCount: actores.length,
        itemBuilder: (context, i) => _tarjeta(context, actores[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Actor pelicula) {
    
      final tarjeta = Container(
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getProfileImage()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0,),
            Text(pelicula.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

      return GestureDetector(
        child: tarjeta,
        onTap: () {},
      );
  }
}