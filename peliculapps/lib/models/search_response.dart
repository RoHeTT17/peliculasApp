// To parse this JSON data, do
//
//     final searchReponse = searchReponseFromMap(jsonString);

import 'dart:convert';

import 'package:peliculapps/models/models.dart';

class SearchReponse {
    SearchReponse({
       required this.page,
       required this.results,
       required this.totalPages,
       required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory SearchReponse.fromJson(String str) => SearchReponse.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());

    factory SearchReponse.fromMap(Map<String, dynamic> json) => SearchReponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    /*Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };*/
}

