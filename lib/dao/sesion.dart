import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/usuario.dart';

import 'libro_dao.dart';

/*
  Clase donde se guardan los datos temporales traidos de la DB

  Por limpiar
  // que se guarden los datos en estas variables estaticas?
  // con cognito se puede mantener la sesion iniciada
*/

class Sesion {
  // Registro
  static Usuario usuarioRegistro;
  static String contraseniaRegistro;

  // Usuario Logeado
  static bool vieneDeRegistro;
  static Usuario usuarioLogeado;
  static ListaLibros librosUsuarioLogeado;
  static Libro libroLeyendoUsuarioLogeado;

  // Dialog
  static Libro libroAgregado;

  // General
  static ListaLibros librosRegistrados;
  static ListaUsuarios usuariosRegistrados;

  // Otros perfiles
  static Usuario usuarioSeleccionado;
  static ListaLibros librosUsuarioSeleccionado;

  static iniciarDatos() {
    // Registro
    usuarioRegistro = Usuario("", "", "");
    contraseniaRegistro = "";

    // Usuario Logeado
    vieneDeRegistro = false;
    usuarioLogeado = Usuario("", "", "");
    librosUsuarioLogeado = ListaLibros();
    libroLeyendoUsuarioLogeado = Libro("", "", 0, 0);

    // Dialog
    libroAgregado = Libro("", "", 0, 0);

    // General
    librosRegistrados = ListaLibros();
    usuariosRegistrados = ListaUsuarios();

    // Otros perfiles
    usuarioSeleccionado = Usuario("", "", "");
    librosUsuarioSeleccionado = ListaLibros();
  }

  static reiniciarDatos() {
    iniciarDatos();
  }

  static getDatosUsuarioLogeado() {
    UsuarioDao.getUsuarioByNickname(Sesion.usuarioLogeado.nickname)
        .then((usuario) {
      Sesion.usuarioLogeado = usuario;
    });
  }

  static getLibrosUsuarioLogeado() {
    print("c");
    LibroDao.getLibrosOfUsuarioByNickname(Sesion.usuarioLogeado.nickname)
        .then((libros) => Sesion.librosUsuarioLogeado = libros);
  }

  static getLibroLeyendoUsuarioLogeado() {
    print("a");
    if (Sesion.usuarioLogeado.codLibroLeyendo != 0) {
      LibroDao.getLibroByCod(Sesion.usuarioLogeado.codLibroLeyendo)
          .then((libro) => Sesion.libroLeyendoUsuarioLogeado = libro);
    }
  }

  static getLibrosRegistrados() {
    print("b");
    LibroDao.getLibrosTotales()
        .then((libros) => Sesion.librosRegistrados = libros);
  }

  static getUsuariosRegistrados() {
    UsuarioDao.getUsuariosRegistrados()
        .then((usuarios) => Sesion.usuariosRegistrados = usuarios);
  }
}
