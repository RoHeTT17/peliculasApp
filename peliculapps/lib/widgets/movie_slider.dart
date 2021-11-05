import 'package:flutter/material.dart';
import 'package:peliculapps/models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> moviePopulars;
  final String? titulo;  

  final Function onNextPage;

  const MovieSlider({Key? key, required this.moviePopulars,required this.onNextPage, this.titulo }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
    void initState() {
      // TODO: implement initState
      super.initState();

      scrollController.addListener(() {
        if(scrollController.position.pixels >= scrollController.position.maxScrollExtent-500){
            widget.onNextPage();
        }
      });


    }

  @override
    void dispose() {
    // TODO: implement dispose


      super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO: si no hay titulo no mostrar este Widget
          if (this.widget.titulo!=null)
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:20 ),
                child: Text(this.widget.titulo!,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
      
          SizedBox(height: 5,),

          Expanded(
            child: ListView.builder(
              controller: scrollController,  
              scrollDirection: Axis.horizontal,
              itemCount: widget.moviePopulars.length,
              itemBuilder: (context , int index){
                /*final movieP = moviePopulars[index];
                return _MoviePoster(movie:movieP);*/
                return _MoviePoster(widget.moviePopulars[index]);
              },
            ),
          )

          ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;

  //const _MoviePoster({Key? key, required this.movie}) : super(key: key);  
  const _MoviePoster( this.movie);  

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
                        //onTap: () => Navigator.pushNamed(context, 'details',arguments: 'movie-instance'),
                          onTap: () => Navigator.pushNamed(context, 'details',arguments: this.movie),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            placeholder: AssetImage('lib/assets/no-image.jpg'),
                            //image: NetworkImage('https://via.placeholder.com/300x400'),
                             image: NetworkImage(movie.fullPosterImg),
                            width: 130,
                            height: 190,
                            fit: BoxFit.cover,
                            ),
                        ),
                      ),

                        Text(movie.title,
                          //"masdjfioasjdfijasdiofjioasdjioasdfjasojdfioasdjofjsoidajfioasdjfio",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center, 
                        )

                    ],
                  ),
                );
  }
}