import 'package:flutter/material.dart';
import 'package:flutter_app_3_peliculas/src/models/actors_model.dart';
import 'package:flutter_app_3_peliculas/src/models/movie_model.dart';
import 'package:flutter_app_3_peliculas/src/providers/movies_provider.dart';

class MovieDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                _titlePoster(context, movie),
                _description(movie),
                _createCasting(movie),
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
            movie.title,
            style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _titlePoster(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 150,
              ),
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis, maxLines: 2,),
                //SizedBox(height: 10,),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.subtitle, overflow: TextOverflow.ellipsis, maxLines: 2,),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.subhead)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(Movie movie) {
    return
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(movie.overview, textAlign: TextAlign.justify,),



    );
  }

  Widget _createCasting(Movie movie) {
    final moviesProvider = new MoviesProvider();
    return FutureBuilder(
      future: moviesProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return _createActorsPageView(snapshot.data);
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },);
  }

  Widget _createActorsPageView(List<Actor> actors) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        //pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
          itemBuilder: (context, i) => _actorCard(actors[i]),
        itemCount: actors.length,),
    );
  }

  Widget _actorCard(Actor actor){
    return Container(
      padding: EdgeInsets.only(right: 10),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage(
              image: NetworkImage(actor.getPhoto()),
              placeholder: AssetImage('assets/img/loading.gif'),
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5,),
          Text(actor.name, overflow: TextOverflow.ellipsis,maxLines: 2, textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
