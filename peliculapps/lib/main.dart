import 'package:flutter/material.dart';
import 'package:peliculapps/screens/screens.dart';
import 'package:provider/provider.dart';

import 'package:peliculapps/providers/movies_provider.dart';

/*
 * Para poder obtener la información de manera global del provider, debe ser la primera clase en ejecutarse,
 * después dentro de esta se ejecuta el MyApp dentro de un child
void main() => runApp(MyApp());

*/

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => MoviesProvider(), lazy: false,)
        //lazy en false, es para que se cree la instancia desde este momento, por default esta en true
      ],
      child: MyApp(),
      );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: "home",
      routes: {
        "home":     (context)=> HomeScreen(),
        "details":  (_)=> DetailScreen()
      },
      //Crear una "copia" del theme y aplicarlo a todos los screen
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.indigo
        ),
      )
    );
  }
}