import 'package:flutter/material.dart';
import 'package:peliculapps/serch/search_delegate.dart';

import 'package:provider/provider.dart';

import 'package:peliculapps/providers/movies_provider.dart';
import 'package:peliculapps/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  //El provider siempre debe ir a este nivel porque se necesita el context  
   final moviesProviders = Provider.of<MoviesProvider>(context);  

    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text("Películas en cines"),
          alignment: Alignment.center,
        ),
        elevation: 0, //quitar la sombra
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: ()=>showSearch(context: context, delegate: MovieSearchDelegate()),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          //CardSwiper Principales
          CardSwiper(movies : moviesProviders.onDisplayMovies),  
          //Listado horizontal de películas
          //El titulo es opcional, si viene debe mostrar el Widget
          MovieSlider(moviePopulars : moviesProviders.onPopularDisplay,
           onNextPage:(){moviesProviders.getDisplayPopulars();} ,
           titulo: "Populares", )
        ],
      ),
      )
    );
  }
}