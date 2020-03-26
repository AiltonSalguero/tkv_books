import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tkv_books/model/usuario.dart';

class UsuarioDao {
  static String apiUrl =
      "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";

  static Future<Usuario> getUsuarioByCod(String codUsuario) async {
    var response =
        await http.get(apiUrl + "/usuariosTKV?codUsuario=" + codUsuario);
    var decodedData = json.decode(response.body);
    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<ListaUsuarios> getUsuariosRegistrados() async {
    var response =
        await http.get(apiUrl + "/usuariosTKV");
    var decodedData = json.decode(response.body);
    return ListaUsuarios.fromJson(decodedData);
  }

  static Future<Usuario> getUsuarioByNickname(String nickname) async {
    var response = await http.get(apiUrl + "/usuariosTKV?nickname=" + nickname);
    var decodedData = json.decode(response.body);
    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<bool> existeUsuario(String nickname, String contrasenia) async {
    var response = await http.get(apiUrl +
        "/usuariosTKV?nickname=" +
        nickname +
        "&contrasenia=" +
        contrasenia);
    var decodedData = json.decode(response.body);
    print(response.body);
    bool existe;
    ListaUsuarios.fromJson(decodedData).lista.length != 0
        ? existe = true
        : existe = false;
    print(existe);
    return existe;
  }

  static Future<Null> postUsuario(Usuario usuario) async {
    http.post(apiUrl + "/usuariosTKV",
        body: jsonEncode(usuario.toJson()),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        }).then((response) {
      print(response);
      print(jsonEncode(usuario.toJson()));
    });
  }
}
