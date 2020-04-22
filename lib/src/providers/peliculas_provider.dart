import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mispeliculones/src/models/actor_model.dart';

import 'package:mispeliculones/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '';
  String _language = 'es-MX';
  String _url = 'api.themoviedb.org';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink  => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disponseStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "3/movie/now_playing", {
      'api_key' : _apiKey,
      'language': _language
    });

    final resp = await http.get(url);
    return _procesaRespuesta(resp);
  }


  Future<List<Pelicula>> getPopulares() async {

    if(_cargando) return [];

    _cargando=true;
    _popularesPage++;

    final url = Uri.https(_url, "3/movie/popular", {
      'api_key' : _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await http.get(url);

    final respuesta = await _procesaRespuesta(resp);

    _populares.addAll(respuesta);

    popularesSink(_populares);
    _cargando=false;
    return respuesta;
  }


  Future<List<Actor>> getCast(int peliculaId) async {

    final url = Uri.https(_url, "3/movie/${peliculaId}/credits", {
      'api_key' : _apiKey,
      'language': _language,
    });

    final respuesta = await http.get(url);

    final decodedData = json.decode(respuesta.body);
    print(decodedData['cast']);

    return Cast.fromJsonList(decodedData['cast']).items;
  }


  Future<List<Pelicula>> search(String query) async {

    final url = Uri.https(_url, "3/search/movie", {
      'api_key' : _apiKey,
      'language': _language,
      'query': query
    });

    final respuesta = await http.get(url);
    return _procesaRespuesta(respuesta);
  }

  _procesaRespuesta(respuesta) {
    final decodedData = json.decode(respuesta.body);
    print(decodedData['results']);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }
}