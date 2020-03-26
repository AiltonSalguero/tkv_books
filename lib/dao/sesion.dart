import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/usuario.dart';

class Sesion{
  // con sqflutter se puede mantener la sesion iniciada
  static Usuario usuarioLogeado;
  static Libro libroAgregado = Libro();
}