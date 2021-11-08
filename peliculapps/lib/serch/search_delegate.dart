import 'package:flutter/material.dart';

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
        return Container(
          child: Center(
            child: Icon(Icons.movie_creation_outlined,color: Colors.black38,size: 150,),
          ),
        );
      }

      return Container();
  }

}