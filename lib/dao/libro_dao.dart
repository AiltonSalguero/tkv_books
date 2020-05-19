/*
  Clase con funciones de get, post, put y delete para
  la clase Libro
*/
import 'package:tkv_books/dao/dao.dart';
import 'package:tkv_books/model/libro.dart';

class LibroDao {
  static Future<ListaLibros> getLibrosTotales() async {
    String apiUrl = Dao.apiUrl + "/libro";
    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    return ListaLibros.fromJson(decodedData);
  }

  static Future<Libro> getLibroByCod(int codLibro) async {
    String apiUrl = Dao.apiUrl + "/libro?codLibro=" + codLibro.toString();
    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    return ListaLibros.fromJson(decodedData).lista[0];
  }

  static Future<ListaLibros> getLibrosOfUsuario(int codUsuario) async {
    String apiUrl =
        Dao.apiUrl + "/libro?codUsuario=" + codUsuario.toString();
    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    return ListaLibros.fromJson(decodedData);
  }

  static Future<Null> postLibro(Libro nuevoLibro) async {
    String apiUrl = Dao.apiUrl + "/libro";
    Dao.httpPost(apiUrl, nuevoLibro);
  }

  static Future<Null> putLibroSetPaginasLeidas(Libro actualizacionLibro) async {
    String apiUrl = Dao.apiUrl +
        "/libro?codLibro=" +
        actualizacionLibro.codLibro.toString() +
        "&paginasLeidas=" +
        actualizacionLibro.paginasLeidas.toString();
    Dao.httpPut(apiUrl);
  }

  static Future<Null> deleteLibro(int codLibro) async {
    String apiUrl = Dao.apiUrl + "/libro?codLibro=" + codLibro.toString();
    Dao.httpDelete(apiUrl);
  }
}
