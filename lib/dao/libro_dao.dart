// Un libro solo le pertenece a un usuario
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tkv_books/model/libro.dart';

class LibroDao {
  static String apiUrl =
      "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
  static Libro libroLeyendo;
  static ListaLibros librosAgregados;

  static Future<Libro> getLibroByCod(
      int codUsuario, int codLibro) async {
    apiUrl += "/librosTKV?codUsuario=" + codUsuario.toString();
    apiUrl += "/&codLibro=" + codLibro.toString();
    var response = await http.get(apiUrl);
    var decodedData = json.decode(response.body);
    return ListaLibros.fromJson(decodedData).lista[0];
  }

  static Future<ListaLibros> getLibrosOfUsuario(int codUsuario) async {
    var response = await http
        .get(apiUrl + "/librosTKV?codUsuario=" + codUsuario.toString());
    var decodedData = json.decode(response.body);
    return ListaLibros.fromJson(decodedData);
  }

  static Future<Null> postLibro(Libro libro) async {
    http.post(apiUrl + "/librosTKV",
        body: jsonEncode(libro.toJson()),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        }).then((response) {
      print(jsonEncode(libro.toJson()));
    });
  }

  static Future<Null> deleteLibro(Libro libro) async {}
}
