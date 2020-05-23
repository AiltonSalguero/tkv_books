import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/usuario.dart';

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
  static Usuario usuarioLogeado;
  static bool vieneDeRegistro;
  static ListaLibros librosDelUsuario;
  static Libro libroLeyendoPorUsuario;

  // Dialog
  static Libro libroAgregado;

  // General
  static ListaLibros librosRegistrados;
  static ListaUsuarios usuariosRegistrados;

  // Otros perfiles
  static Usuario usuarioSeleccionado;
  static ListaLibros librosDelUsuarioSeleccionado;

  static iniciarDatos() {
    // Registro
    usuarioRegistro = Usuario("", "", "");
    contraseniaRegistro = "";

    // Usuario Logeado
    usuarioLogeado = Usuario("", "", "");
    vieneDeRegistro = false;
    librosDelUsuario = ListaLibros();
    libroLeyendoPorUsuario = Libro("", "", 0, 0);

    // Dialog
    libroAgregado = Libro("", "", 0, 0);

    // General
    librosRegistrados = ListaLibros();
    usuariosRegistrados = ListaUsuarios();

    // Otros perfiles
    usuarioSeleccionado = Usuario("", "", "");
    librosDelUsuarioSeleccionado = ListaLibros();
  }

  static reiniciarDatos() {
    iniciarDatos();
  }
}
