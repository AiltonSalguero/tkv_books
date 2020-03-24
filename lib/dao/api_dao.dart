import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/usuario.dart';

// Clase que realiza la obtencion de los datos de la base de datos que esta en amazon
class ApiDao {
  static Libro listaTemas;
  static var listaAlumnos;
  static Usuario usuarioLogeado;

// iniciar la clase para que todos los datos de la base de datos se carguen a unos arreglos temporales
// cuando la app necesite los datos llamara a los arreglos.
  Future getData() async {
    var url = 'http://13.58.72.228/get.php';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data.toString());
  }

  static Future<List> getList() async {
    final response = await http.get("http://13.58.72.228/get.php");
    return json.decode(response.body);
  }

  static Future<Null> getTemas() async {
    var response = await http.get(
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test/temas");

    var decodedData = json.decode(response.body);
    listaTemas = Libro.fromJson(decodedData[0]);
    print(listaTemas);
  }
}
