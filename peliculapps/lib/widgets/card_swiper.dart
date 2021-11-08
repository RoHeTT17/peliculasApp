import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:peliculapps/models/models.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    //Para obtener el tamaño e infromación relacionada al dispositivo, como la horientación, se usa
    // el MediaQuery.
    final size = MediaQuery.of(context).size;

    if(this.movies.length == 0){
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    //Cuando el notificate listener se dispara, entra a esta opción porque el length es mayor a 0  
    return Container(
      width: double.infinity,
      height: size.height*0.5, //se multiplica por 0.5 para que se la mitad de la pantalla
      //color: Colors.redAccent[700],
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (BuildContext context, int index){
            //El itemBuilder debe retornar un widget

            final movie =movies[index];

            movie.heroID = 'swiper-${movie.id}';

            return GestureDetector(
              //onTap: () => Navigator.pushNamed(context, 'details',arguments: 'movie-instance'),
              onTap: () => Navigator.pushNamed(context, 'details',arguments: movie),
              child: Hero(
                //tag: movie.id,
                tag: movie.heroID!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: AssetImage('lib/assets/no-image.jpg'), 
                    //image: NetworkImage('https://via.placeholder.com/300x400'),
                    image: NetworkImage(movie.fullPosterImg),
                    fit: BoxFit.cover,),
                    
                ),
              ),
            );

        },
      ),
    );
  }
}