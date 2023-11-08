import 'package:flutter/material.dart';
import 'package:flutter_app_3_peliculas/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;

  final Function nextPage;

  MovieHorizontal({required this.movies, required this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent -200){
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height*0.4,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _cards(context),
        itemCount: movies.length,
        itemBuilder: (context, i){
          return _card(context, movies[i]);
        },
      ),
    );

  }

  Widget _card(BuildContext context,Movie movie){

    movie.uniqueId = '${movie.id}-poster';

    final card = Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/loading.gif'),
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              movie.title!,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,),
          )
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: (){
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );


  }

  /*
  List<Widget> _cards(BuildContext context) {
    return movies.map((movie){
      return _card(context, movie);
    }).toList();
  }*/


}
