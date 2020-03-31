/*
   Un libro solo le pertenece a un usuario
   
   Por limpiar
*/

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tkv_books/model/libro.dart';

class LibroDao {
  static Future<ListaLibros> getLibrosTotales() async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    apiUrl += "/librosTKV";
    var response = await http.get(apiUrl);
    var decodedData = json.decode(response.body);
    return ListaLibros.fromJson(decodedData);
  }

  static Future<Libro> getLibroByCod(int codLibro) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    apiUrl += "/librosTKV?codLibro=" + codLibro.toString();
    var response = await http.get(apiUrl);
    var decodedData = json.decode(response.body);
    return ListaLibros.fromJson(decodedData).lista[0];
  }

  static Future<ListaLibros> getLibrosOfUsuario(int codUsuario) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    var response = await http
        .get(apiUrl + "/librosTKV?codUsuario=" + codUsuario.toString());
    var decodedData = json.decode(response.body);
    return ListaLibros.fromJson(decodedData);
  }

  static Future<Null> postLibro(Libro nuevoLibro) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    apiUrl += "/librosTKV";
    http.post(
      apiUrl,
      body: jsonEncode(nuevoLibro.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
  }

  static Future<Null> putLibro(Libro actualizacionLibro) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    http.put(
      apiUrl + "/librosTKV?codLibro=" + actualizacionLibro.codLibro.toString(),
      body: jsonEncode(actualizacionLibro.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
  }

  static Future<Null> putLibroSetPaginasLeidas(
      int codLibro, int paginas) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    http.put(
      apiUrl + "/librosTKV?codLibro=" + codLibro.toString(),
      body: jsonEncode({"paginasLeidas": paginas}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
  }

  static Future<Null> deleteLibro(int codLibro) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    apiUrl += "/librosTKV?codLibro=" + codLibro.toString();
    http.delete(apiUrl);
  }
}
