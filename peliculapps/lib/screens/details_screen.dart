import 'package:flutter/material.dart';
import 'package:peliculapps/models/models.dart';
import 'package:peliculapps/widgets/widgets.dart';

class DetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //final String movie = ModalRoute.of(context)?.settings.arguments.toString()??'en caso de sin param';
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body:  CustomScrollView(
        slivers: [
            _CustomAppBar(movie),
            SliverList(
              delegate:SliverChildListDelegate([
                _PosterAndTitle(movie),
                _OverView(resumen: movie.overview),
                /*_OverView(),
                _OverView(),*/
                CastingCards(),
              ])
            )

        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  
  final Movie movieBar;

  const _CustomAppBar(this.movieBar);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          child:  Text(
            movieBar.title,
            //'movie.title',
             style: TextStyle(fontSize: 16),
            ),
          
        ),
        background: FadeInImage(
          placeholder: AssetImage('lib/assets/loading.gif'), 
          //image: NetworkImage("https://via.placeholder.com/500x300"),
          image: NetworkImage(movieBar.fullBackdropPathImg),
          fit: BoxFit.cover
          ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie moviePT;

  const _PosterAndTitle(this.moviePT);

  @override
  Widget build(BuildContext context) {

  final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage("lib/assets/no-image.jpg"), 
              //image: NetworkImage("https://via.placeholder.com/200x300"),
              image: NetworkImage(moviePT.fullPosterImg),
              height: 150,
              ),
          ),
        
        SizedBox(width: 20,),
      
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                moviePT.title,
                //'movie.title',
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,),
              Text(
                moviePT.originalTitle,
                //'movie.originalTitle',
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                ),
              Row(children: [
                Icon(Icons.star_outline,size: 15, color: Colors.grey,),
                SizedBox(width: 5,),
                //Text('moive.voreAverage',style: textTheme.caption,)
                Text(moviePT.voteAverage.toString(),style: textTheme.caption,)
              ],)  
            ],
          ),
        )
        ],
      ),

    );
  }
}

class _OverView extends StatelessWidget {

  final String resumen;

  const _OverView({Key? key, required this.resumen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      //child: Text('Laboris id Lorem ipsum velit laboris laborum incididunt irure velit est irure. Enim commodo sint eu cillum qui Lorem officia commodo non ex esse aliquip. Exercitation occaecat qui deserunt officia duis ea do. Veniam proident id do ipsum in. Adipisicing deserunt velit cillum consectetur laboris id elit.',
      child: Text(resumen,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,
      ),
       
    );
  }
}