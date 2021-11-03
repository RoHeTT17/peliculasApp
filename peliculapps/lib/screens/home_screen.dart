import 'package:flutter/material.dart';
import 'package:peliculapps/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
            onPressed: (){},
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          //TODO CardSwiper
          CardSwiper(),  
          //Listado horizontal de películas
          MovieSlider()
        ],
      ),
      )
    );
  }
}