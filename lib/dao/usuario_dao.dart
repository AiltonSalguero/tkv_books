import 'package:flutter/material.dart';
import 'package:tkv_books/dao/dao.dart';
import 'package:tkv_books/model/usuario.dart';

/*
  Clase con funciones de get, post, put y delete para
  la clase Usuario
*/

class UsuarioDao {
  static Future<Usuario> getUsuarioByCod(int codUsuario) async {
    String apiUrl =
        Dao.apiUrl + "/usuarios?codUsuario=" + codUsuario.toString();
    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<ListaUsuarios> getUsuariosRegistrados() async {
    String apiUrl = Dao.apiUrl + "/usuarios";
    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    return ListaUsuarios.fromJson(decodedData);
  }

  static Future<Usuario> getUsuarioByNickname(String nickname) async {
    String apiUrl = Dao.apiUrl + "/usuarios?nickname=" + nickname;
    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<bool> existeUsuario(
      String nickname, String contrasenia, BuildContext context) async {
    String apiUrl = Dao.apiUrl +
        "/usuarios?nickname=" +
        nickname +
        "&contrasenia=" +
        contrasenia;

    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    bool existe;
    ListaUsuarios.fromJson(decodedData).lista.length != 0
        ? existe = true
        : existe = false;
    return existe;
  }

  static Future<bool> existeUsuarioByNickname(String nickname) async {
    String apiUrl = Dao.apiUrl + "/usuarios?nickname=" + nickname;
    var decodedData = await Dao.jsonDecodedHttpGet(apiUrl);
    bool existe;
    ListaUsuarios.fromJson(decodedData).lista.length != 0
        ? existe = true
        : existe = false;
    return existe;
  }

  static Future<Null> postUsuario(Usuario nuevoUsuario) async {
    String apiUrl = Dao.apiUrl + "/usuarios";
    Dao.httpPost(apiUrl, nuevoUsuario);
  }

  static Future<Null> putUsuarioSetLibroLeyendo(Usuario usuario) async {
    String apiUrl = Dao.apiUrl +
        "/usuarios?codUsuario=" +
        usuario.codUsuario.toString() +
        "&codLibroLeyendo=" +
        usuario.codLibroLeyendo.toString();
    Dao.httpPut(apiUrl);
  }

  static Future<Null> putUsuarioSetPuntajeLevel(Usuario usuario) async {
    String apiUrl = Dao.apiUrl +
        "/usuarios?codUsuario=" +
        usuario.codUsuario.toString() +
        "&puntaje=" +
        usuario.puntaje.toString() +
        "&level=" +
        usuario.nivel.toString();
    Dao.httpPut(apiUrl);
  }
}
