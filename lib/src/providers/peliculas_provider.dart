import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{

  String _apikey='39d261ac58802dce7bc35053d809e528';
  String _url = 'api.themoviedb.org';
  String _language='es-ES';

  int _popularesPage=0;

  bool _cargando = false;

  List<Pelicula> _populares= [];
  
  //el stream controller no tienes que importar dart:async
  //usaremos el broadcast podemos tner muchos lugares escuchando la emisión del stream
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  //ya tenemos la manera de emitir las peliculas
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  //ahora necesitamos escuchar esas peliculas
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController.close();
  }

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

      'api_key' : _apikey,
      'language': _language,
    });
    
    return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async{
    
    //potimizamos para que la peticion no sea a cada momento
    if(_cargando)return [];

    _cargando=true;
    //esto es para el infinite scroll
    _popularesPage++;
    
    
    final url = Uri.https(_url, '3/movie/popular',{

      'api_key' : _apikey,
      'language': _language,
      'page'    :_popularesPage.toString(),
    });
    
    final resp= await _procesarRespuesta(url);

    _populares.addAll(resp);
    //agregamos las peliculas al sink
    popularesSink(_populares);

    _cargando=false;

    return resp;

    // return await _procesarRespuesta(url);
  }
}