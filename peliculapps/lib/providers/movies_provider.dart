import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculapps/models/models.dart';
//import 'package:peliculapps/models/popular_response.dart';
//Para que sea un provider valido debe extender de ChangeNotifier pero del paquete de Material

class MoviesProvider extends ChangeNotifier{

  String _apiKey   = "48f5b0d88e7e9b1bd4d9b1d9c1f035f5";
  String _baseUrl  = "api.themoviedb.org";
  String _language = "es-ES";

  List<Movie> onDisplayMovies=[];
  List<Movie> onPopularDisplay=[];

  int _popularPage = 0;

  MoviesProvider(){
    print('Movies Provider inicializado');

    this.getonDisplayMovies();
    this.getDisplayPopulars();

  }

  getonDisplayMovies() async{
    //Aquí se hacen las peticiones http
    //para la que se muestran el movie_slider
    /*var url = Uri.https(_baseUrl, '3/movie/now_playing',{
      "api_key"  : _apiKey,
      "language" : _language,
      "page"     : "1"
    });

    final response = await http.get(url);*/
    final response = await this._getJasonData('3/movie/now_playing');
    //final Map<String, dynamic> decodeData = json.decode(response.body); //as Map<String, dynamic>;
    final nowPlayinResponse = NowPlayinResponse.fromJson(response);

    //print(nowPlayinResponse.results[1].title);
      onDisplayMovies = nowPlayinResponse.results;
    //Como hay cambios en la data
    //Le dice a todos los listener (widget) que estén escuchando ese cambio, que 
    //hay un cambio en la Data y por lo tanto se deben redibujar.
      notifyListeners();
  }

  getDisplayPopulars() async{
    
   /* var url = Uri.https(_baseUrl, '3/movie/popular',{
      "api_key"  : _apiKey,
      "language" : _language,
      "page"     : "1"
    });

    final response = await http.get(url);*/

    //final reponsePopular = PopularResponse.fromJson(response.body);

    _popularPage++;

    final response = await _getJasonData('3/movie/popular',_popularPage);
   
    final reponsePopular = PopularResponse.fromJson(response);
    
    //onPopularDisplay = reponsePopular.results;
     /*
     Desestructurar
     Eventualmente se volverá a llamar cambiando el número de página y 
     se quiere mantener las películas que ya están.

      ...  -> Son el operador expres para separar cada una de las 
              películas 
     */
    
    onPopularDisplay =[...onPopularDisplay,...reponsePopular.results];
    //print(onPopularDisplay[0]);
    notifyListeners();

  }

  Future<String> _getJasonData(String urlEndPoint, [int page = 1]) async{
    var url = Uri.https(_baseUrl, urlEndPoint,{
      "api_key"  : _apiKey,
      "language" : _language,
      "page"     : "$page"
    });

    final response = await http.get(url);

    return response.body;

  }



}