import 'package:flutter/material.dart';
import 'package:flutter_app_3_peliculas/src/delegates/search_delegate.dart';
import 'package:flutter_app_3_peliculas/src/models/movie_model.dart';
import 'package:flutter_app_3_peliculas/src/providers/movies_provider.dart';
import 'package:flutter_app_3_peliculas/src/widgets/card_swiper_widget.dart';
import 'package:flutter_app_3_peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final MoviesProvider moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cine'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _cardSwiper(),
              _footer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardSwiper() {

    return FutureBuilder(
      future: moviesProvider.getInTheaters(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return CardSwiper(
            movies: snapshot.data as List<Movie>,
          );
        // ignore: missing_return
        }else{
          return CircularProgressIndicator();
        }

      },
    );

  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Text("Populares", style: Theme.of(context).textTheme.titleMedium)),
          StreamBuilder(
            stream: moviesProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                    movies: snapshot.data as List<Movie>,
                  nextPage: moviesProvider.getPopulars);
              }else{
                return Center(
                    child: CircularProgressIndicator());
              }
            },)
        ],

      ),
    );
  }
}
