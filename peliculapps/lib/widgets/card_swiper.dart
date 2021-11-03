import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';

class CardSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Para obtener el tamaño e infromación relacionada al dispositivo, como la horientación, se usa
    // el MediaQuery.
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height*0.5, //se multiplica por 0.5 para que se la mitad de la pantalla
      //color: Colors.redAccent[700],
      child: Swiper(
        itemCount: 10,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (BuildContext context, int index){
            //El itemBuilder debe retornar un widget
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',arguments: 'movie-instance'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('lib/assets/no-image.jpg'), 
                  image: NetworkImage('https://via.placeholder.com/300x400'),
                  fit: BoxFit.cover,),
                  
              ),
            );

        },
      ),
    );
  }
}