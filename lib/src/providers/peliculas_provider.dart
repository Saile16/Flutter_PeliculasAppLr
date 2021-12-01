import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{

  String _apykey='39d261ac58802dce7bc35053d809e528';
  String _url = 'api.themoviedb.org';
  String _language='es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    ///recordar importar librerias tanto de http y de convert
    final respuesta= await http.get(url);
    final decodedData=json.decode(respuesta.body);

    //aqui llamamos y creamos a instancia
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    // print(peliculas.items[10].title);

    // print(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing',{

      'api_key' : _apykey,
      'language': _language,
    });
    
    return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async{

    final url = Uri.https(_url, '3/movie/popular',{

      'api_key' : _apykey,
      'language': _language,
    });
    
    return await _procesarRespuesta(url);
  }
}