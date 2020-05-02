/*
  Clase con funciones de get, post, put y delete para
  la clase Usuario
*/
import 'package:flutter/widgets.dart';
import 'package:tkv_books/dao/dao.dart';
import 'package:tkv_books/dialogs/eliminar_libro_dialog.dart';
import 'package:tkv_books/model/usuario.dart';

class UsuarioDao {
  static Future<Usuario> getUsuarioByCod(int codUsuario) async {
    String apiUrl =
        Dao.apiUrl + "/usuariosTKV?codUsuario=" + codUsuario.toString();
    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<ListaUsuarios> getUsuariosRegistrados() async {
    String apiUrl = Dao.apiUrl + "/usuariosTKV";
    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    return ListaUsuarios.fromJson(decodedData);
  }

  static Future<Usuario> getUsuarioByNickname(String nickname) async {
    String apiUrl = Dao.apiUrl + "/usuariosTKV?nickname=" + nickname;
    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<bool> existeUsuario(
      String nickname, String contrasenia, BuildContext context) async {
    String apiUrl = Dao.apiUrl +
        "/usuariosTKV?nickname=" +
        nickname +
        "&contrasenia=" +
        contrasenia;
    try {
      var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
      bool existe;
      ListaUsuarios.fromJson(decodedData).lista.length != 0
          ? existe = true
          : existe = false;
      return existe;
    } catch (e) {
      print(e);
      alertaDialog(
          context, "Sin internet", "No esta conectado a internet.", "", "Ok");
    }
  }

  static Future<bool> existeUsuarioByNickname(String nickname) async {
    String apiUrl = Dao.apiUrl + "/usuariosTKV?nickname=" + nickname;
    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    bool existe;
    ListaUsuarios.fromJson(decodedData).lista.length != 0
        ? existe = true
        : existe = false;
    return existe;
  }

  static Future<Null> postUsuario(Usuario nuevoUsuario) async {
    String apiUrl = Dao.apiUrl + "/usuariosTKV";
    Dao.httpPost(apiUrl, nuevoUsuario);
  }

  static Future<Null> putUsuarioSetLibroLeyendo(Usuario usuario) async {
    String apiUrl = Dao.apiUrl +
        "/usuariosTKV?codUsuario=" +
        usuario.codUsuario.toString() +
        "&codLibroLeyendo=" +
        usuario.codLibroLeyendo.toString();
    Dao.httpPut(apiUrl);
  }

  static Future<Null> putUsuarioSetPuntajeLevel(Usuario usuario) async {
    String apiUrl = Dao.apiUrl +
        "/usuariosTKV?codUsuario=" +
        usuario.codUsuario.toString() +
        "&puntaje=" +
        usuario.puntaje.toString() +
        "&level=" +
        usuario.level.toString();
    Dao.httpPut(apiUrl);
  }
}
