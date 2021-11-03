import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:20 ),
            child: Text("Populares",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),

          SizedBox(height: 5,),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context , int index){
                return _MoviePoster();
              },
            ),
          )

          ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: 130,
                  height: 190,
                  //color: Colors.green,
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Column(
                    children: [
                      
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'details',arguments: 'movie-instance'),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            placeholder: AssetImage('lib/assets/no-image.jpg'),
                            image: NetworkImage('https://via.placeholder.com/300x400'),
                            width: 130,
                            height: 190,
                            fit: BoxFit.cover,
                            ),
                        ),
                      ),

                        Text(
                          "masdjfioasjdfijasdiofjioasdjioasdfjasojdfioasdjofjsoidajfioasdjfio",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center, 
                        )

                    ],
                  ),
                );
  }
}