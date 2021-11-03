import 'package:flutter/material.dart';
import 'package:peliculapps/widgets/widgets.dart';

class DetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final String movie = ModalRoute.of(context)?.settings.arguments.toString()??'en caso de sin param';
    
    return Scaffold(
      body:  CustomScrollView(
        slivers: [
            _CustomAppBar(),
            SliverList(
              delegate:SliverChildListDelegate([
                _PosterAndTitle(),
                _OverView(),
                _OverView(),
                _OverView(),
                CastingCards(),
              ])
            )

        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

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
            'movie.title',
             style: TextStyle(fontSize: 16),
            ),
          
        ),
        background: FadeInImage(
          placeholder: AssetImage('lib/assets/loading.gif'), 
          image: NetworkImage("https://via.placeholder.com/500x300"),
          fit: BoxFit.cover
          ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

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
              image: NetworkImage("https://via.placeholder.com/200x300"),
              height: 150,
              ),
          ),
        
        SizedBox(width: 20,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'movie.title',
              style: textTheme.headline5,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,),
            Text(
              'movie.originalTitle',
              style: textTheme.subtitle1,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,),
            Row(children: [
              Icon(Icons.star_outline,size: 15, color: Colors.grey,),
              SizedBox(width: 5,),
              Text('moive.voreAverage',style: textTheme.caption,)
            ],)  
          ],
        )
        ],
      ),

    );
  }
}

class _OverView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Text('Laboris id Lorem ipsum velit laboris laborum incididunt irure velit est irure. Enim commodo sint eu cillum qui Lorem officia commodo non ex esse aliquip. Exercitation occaecat qui deserunt officia duis ea do. Veniam proident id do ipsum in. Adipisicing deserunt velit cillum consectetur laboris id elit.',
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,
      ),
       
    );
  }
}