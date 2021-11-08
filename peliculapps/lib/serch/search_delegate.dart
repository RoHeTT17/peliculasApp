import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peliculapps/providers/movies_provider.dart';
import 'package:peliculapps/models/models.dart';

class MovieSearchDelegate extends SearchDelegate{

   @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => "Buscar";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
        IconButton(onPressed: ()=>query = "", icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
      return IconButton(onPressed: (){
        //cuando se cierre o regrese, le estamos diciendo que no regresa valor, pero puede regresar cualquier valor
        //que se requiera
          close(context, null); 
      }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text("BuildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {

      if(query.isEmpty){
        return _emptyContainer();
      }else{

        final moviesProvider = Provider.of<MoviesProvider>(context,listen: false);
        //Se va a mandar llamar cada que se toca una tecla
        moviesProvider.getSuggetionByQuery(query);

        /*return FutureBuilder(
          future: moviesProvider.searchMovies(query),*/
        return StreamBuilder(
          stream: moviesProvider.suggetionStream,          
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (!snapshot.hasData)
                return _emptyContainer();
            else{
              final movies = snapshot.data;

              return ListView.builder(
                itemCount   : movies!.length,
                itemBuilder : ( _ , int index) => _MovieItem(movies[index])
                );  
            }    
          },
        );

      }
 
  }

  Widget _emptyContainer(){
    return Container(
          child: Center(
            child: Icon(Icons.movie_creation_outlined,color: Colors.black38,size: 150,),
          ),
        );
  }
}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {

    movie.heroID = 'search-${movie.id}'; 

    return ListTile(
      leading: Hero(
        tag: movie.heroID!,
        child: FadeInImage(
          placeholder : AssetImage("lib/assets/no-image.jpg"), 
          image       : NetworkImage(movie.fullPosterImg),
          width       : 50,
          fit         : BoxFit.cover,  
          ),
      ),
      title    : Text(movie.title),
      subtitle : Text(movie.originalTitle),
      onTap: (){
        Navigator.pushNamed(context, "details", arguments: movie);
            
      },  
    );
  }
}