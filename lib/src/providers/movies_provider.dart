import 'dart:async';

import 'package:flutter_app_3_peliculas/src/models/actors_model.dart';
import 'package:flutter_app_3_peliculas/src/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesProvider{
  String _apiKey = 'bfb512509d3d45a4e4282d35f0f4ef5d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams(){
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _processResponse(String movieFilter, int page) async{
    final url = Uri.https(_url, '3/movie/$movieFilter',{
      'api_key' : _apiKey,
      'language' : _language,
      'page' : page.toString()
    });

    final res = await http.get(url);
    final decodedData = json.decode(res.body);

    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getInTheaters() async{
    return await _processResponse('now_playing',1);
  }


  Future<List<Movie>> getPopulars() async{
    if(_loading) return [];
    _loading = true;
    _popularsPage++;
    final res = await _processResponse('popular',_popularsPage);
    _populars.addAll(res);
    popularsSink(_populars);
    _loading = false;
    return res;
  }

  Future<List<Actor>> getCast(String movieId) async{
    final url = Uri.https(_url, '3/movie/$movieId/credits',{
      'api_key' : _apiKey,
      'language' : _language
    });

    final res = await http.get(url);
    final decodedData = json.decode(res.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actors;
  }

}

