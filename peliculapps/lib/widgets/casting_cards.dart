import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculapps/models/models.dart';
import 'package:peliculapps/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;

  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {

      //listen en false, por si hay un cambio no vuelva a redibujar
    final moviesProvider = Provider.of<MoviesProvider>(context,listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast( movieId),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
         
          //Si no tiene Data (información), debe mostrar un loading
        if(!snapshot.hasData){
            return Container(
              constraints: BoxConstraints(maxWidth: 100),
              height: 180,
              child: CupertinoActivityIndicator(),
            );
        }

        final cast = snapshot.data!;  

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 190,
          //color: Colors.red,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) => _CastCard(cast[index]),
          ),
      
    );

      },
    ); 

  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container( 
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      //color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('lib/assets/no-image.jpg'), 
              //image: NetworkImage('https://via.placeholder.com/150x300'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
              ),
          ),
          SizedBox(height: 5,),  
          //Text('actor.name',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)
          Text(actor.name,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}