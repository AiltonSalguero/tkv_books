import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/usuario.dart';

class UsuarioDao {
  static String api_url =
      "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
  static ListaLibros librosLeyendo;

  static Future<Usuario> getUsuarioByCod(String codUsuario) async {
    var response =
        await http.get(api_url + "/usuariosTKV?codUsuario=" + codUsuario);
    var decodedData = json.decode(response.body);
    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<Usuario> getUsuarioByNickname(String nickname) async {
    var response =
        await http.get(api_url + "/usuariosTKV?nickname=" + nickname);
    var decodedData = json.decode(response.body);
    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<Null> getLibrosOfUsuario(String codUsuario) async {
    // TO DO , trabajar con la tabla CursosUsuario
    var response = await http.get(api_url + "/librosTKV");
    var decodedData = json.decode(response.body);
    librosLeyendo = ListaLibros.fromJson(decodedData);
  }

  static Future<bool> existeUsuario(String nickname, String contrasenia) async {
    var response = await http.get(api_url + "/usuariosTKV?nickname="+nickname+"&contrasenia="+contrasenia);
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
    http.post(api_url+"/usuariosTKV", body: jsonEncode(usuario.toJson()), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    }).then((response) {
      print("inserted");
    });
  }
}
