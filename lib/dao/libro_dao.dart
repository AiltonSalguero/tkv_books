// Un libro solo le pertenece a un usuario
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tkv_books/model/libro.dart';

class LibroDao {
  //static Libro libroLeyendo;
  //static ListaLibros librosAgregados;
  // que se guarden los datos en estas variables estaticas?

  static Future<ListaLibros> getLibrosTotales() async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    apiUrl += "/librosTKV";
    var response = await http.get(apiUrl);
    var decodedData = json.decode(response.body);
    return ListaLibros.fromJson(decodedData);
  }

  static Future<Libro> getLibroByCod(int codUsuario, int codLibro) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    apiUrl += "/librosTKV?codUsuario=" + codUsuario.toString();
    apiUrl += "&codLibro=" + codLibro.toString();
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

  static Future<Null> postLibro(Libro libro) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    http.post(apiUrl + "/librosTKV",
        body: jsonEncode(libro.toJson()),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        }).then((response) {
      print(jsonEncode(libro.toJson()));
    });
  }

  static Future<Null> deleteLibro(int codLibro) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    apiUrl += "/librosTKV?codLibro=" + codLibro.toString();
    print(apiUrl);
    http.delete(apiUrl);
  }
}
