import 'package:http/http.dart' as http;
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'dart:convert';

import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/libro_leyendose.dart';
import 'package:tkv_books/model/usuario.dart';

// Clase que realiza la obtencion de los datos de la base de datos que esta en amazon
class ApiDao {
  static Usuario usuarioLogeado;

// iniciar la clase para que todos los datos de la base de datos se carguen a unos arreglos temporales
// cuando la app necesite los datos llamara a los arreglos.
  Future getData() async {
    var url = 'http://13.58.72.228/get.php';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data.toString());
  }

  Future<ListaLibrosLeyendose> getLibrosLeyendose() async {
    ListaLibrosLeyendose listaLibrosLeyendose = ListaLibrosLeyendose();
    UsuarioDao.getUsuariosRegistrados().then((usuarios) {
      usuarios.lista.forEach((usuario) {
        LibroLeyendose libroLeyendose = LibroLeyendose();
        libroLeyendose.codUsuario = usuario.codUsuario;
        libroLeyendose.nickname = usuario.nickname;
        LibroDao.getLibroByCod(usuario.codUsuario, usuario.codLibroLeyendo)
            .then((libro) {
          libroLeyendose.codLibro = usuario.codLibroLeyendo;
          libroLeyendose.nombreLibro = libro.nombre;
          libroLeyendose.paginasLeidas = libro.paginasLeidas;
          libroLeyendose.paginasTotales = libro.paginasTotales;
        });
        listaLibrosLeyendose.lista.add(libroLeyendose);
      });
    });
    return listaLibrosLeyendose;
  }
}
