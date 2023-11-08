import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_3_peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  CardSwiper({required this.movies});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 30),

      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context,int index){
          movies[index].uniqueId = '${movies[index].id}-card';


          return Hero(
            tag: movies[index].uniqueId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'detail', arguments: movies[index]);
                },
                child: FadeInImage(
                  image: NetworkImage(movies[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/loading.gif'),
                  fit: BoxFit.cover,
                ),
              )
              //child: Text(movies[index].toString()),
            ),
          );

        },
        itemCount: movies.length,
      ),
      //pagination: new SwiperPagination(),
      //control: new SwiperControl(),),
    );
  }
}
