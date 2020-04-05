/*
   Un libro solo le pertenece a un usuario
   
   Por limpiar
*/

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tkv_books/model/libro.dart';

class LibroDao {
  static Future<ListaLibros> getLibrosTotales() async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    apiUrl += "/librosTKV";
    var response = await http.get(
      apiUrl,
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
      },
    );
    var decodedData = json.decode(response.body);
    return ListaLibros.fromJson(decodedData);
  }

  static Future<Libro> getLibroByCod(int codLibro) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];

    apiUrl += "/librosTKV?codLibro=" + codLibro.toString();
    var response = await http.get(
      apiUrl,
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
      },
    );
    var decodedData = json.decode(response.body);
    return ListaLibros.fromJson(decodedData).lista[0];
  }

  static Future<ListaLibros> getLibrosOfUsuario(int codUsuario) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    var response = await http.get(
      apiUrl + "/librosTKV?codUsuario=" + codUsuario.toString(),
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
      },
    );
    var decodedData = json.decode(response.body);
    return ListaLibros.fromJson(decodedData);
  }

  static Future<Null> postLibro(Libro nuevoLibro) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    apiUrl += "/librosTKV";
    http.post(
      apiUrl,
      body: jsonEncode(nuevoLibro.toJson()),
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }

  static Future<Null> putLibro(Libro actualizacionLibro) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    http.put(
      apiUrl + "/librosTKV?codLibro=" + actualizacionLibro.codLibro.toString(),
      body: jsonEncode(actualizacionLibro.toJson()),
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }

  static Future<Null> putLibroSetPaginasLeidas(
      int codLibro, int paginas) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    http.put(
      apiUrl + "/librosTKV?codLibro=" + codLibro.toString(),
      body: jsonEncode({"paginasLeidas": paginas}),
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }

  static Future<Null> deleteLibro(int codLibro) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    apiUrl += "/librosTKV?codLibro=" + codLibro.toString();
    http.delete(
      apiUrl,
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
      },
    );
  }
}
