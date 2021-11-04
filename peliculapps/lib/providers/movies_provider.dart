import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculapps/models/models.dart';
//Para que sea un provider valido debe extender de ChangeNotifier pero del paquete de Material

class MoviesProvider extends ChangeNotifier{

  String _apiKey   = "48f5b0d88e7e9b1bd4d9b1d9c1f035f5";
  String _baseUrl  = "api.themoviedb.org";
  String _language = "es-ES";

  MoviesProvider(){
    print('Movies Provider inicializado');

    this.getonDisplayMovies();

  }

  getonDisplayMovies() async{
    //Aquí se hacen las peticiones http
    //para la que se muestran el movie_slider
    var url = Uri.https(_baseUrl, '3/movie/now_playing',{
      "api_key"  : _apiKey,
      "language" : _language,
      "page"     : "1"
    });

    final response = await http.get(url);
   
    //final Map<String, dynamic> decodeData = json.decode(response.body); //as Map<String, dynamic>;
    final nowPlayinResponse = NowPlayinResponse.fromJson(response.body);

    print(nowPlayinResponse.results[0].title);

  }

}