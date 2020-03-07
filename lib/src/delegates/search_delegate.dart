import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  String selection;

  final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    "Ironman",
    'Capitan America'
  ];

  final recentMovies = [
    'Spider Man',
    'Capitan América'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions - Acciones
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading - Icono izquierda appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults - Resultados
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions - Sugerencias

    final suggestedList = (query.isEmpty)
        ? recentMovies
        : movies.where(
                (p)=> p.toLowerCase().startsWith(query.toLowerCase())
        ).toList();


    return ListView.builder(
        itemCount: suggestedList.length,
        itemBuilder: (context, i){
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(suggestedList[i]),
            onTap: (){
              selection = suggestedList[i];
              showResults(context);
            },
          );
        });
  }

}