import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculapps/helpers/debouncer.dart';
import 'package:peliculapps/models/models.dart';
import 'package:peliculapps/models/search_response.dart';
//import 'package:peliculapps/models/popular_response.dart';
//Para que sea un provider valido debe extender de ChangeNotifier pero del paquete de Material

class MoviesProvider extends ChangeNotifier{

  String _apiKey   = "48f5b0d88e7e9b1bd4d9b1d9c1f035f5";
  String _baseUrl  = "api.themoviedb.org";
  String _language = "es-ES";

  List<Movie> onDisplayMovies=[];
  List<Movie> onPopularDisplay=[];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggetionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggetionStream => this._suggetionStreamController.stream;

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

  Future<List<Cast>> getMovieCast(int movieID) async{

    //Para guardar la data en memoria y no tener que hacer una petición cada vez
    if(movieCast.containsKey(movieID))
      return movieCast[movieID]!;
    //else
    final jsonData= await this._getJasonData('3/movie/$movieID/credits');
    final creditsReponse = CreditsReponse.fromJson(jsonData);

    movieCast[movieID] = creditsReponse.cast;


    return creditsReponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async{
    final url = Uri.https(_baseUrl, "3/search/movie",{
      "api_key"  : _apiKey,
      "language" : _language,
      "query"    : query 

    });

    final response = await http.get(url);  
    final searchResponse = SearchReponse.fromJson(response.body);

    return searchResponse.results;

  }
   
 //Se va a mandar llamar cada que se toca una tecla
  void getSuggetionByQuery (String query){
    //inicializar valor  
    debouncer.value="";

    //El método que se va a llamar cuando pase el Duration
    debouncer.onValue = (valueEmitido) async{
        //cuando el debouncer emita un valor
        final results = await this.searchMovies(valueEmitido);
        this._suggetionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
        debouncer.value = query;
     });

    /*
      Al terminar el timepo del timer, el valor de debouncer.value será lo que
      tenga el query (lo escribe el usuario).
      Y cuando se cambio el valor del debouncer se dispara el debouncer.value  
     */  

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
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