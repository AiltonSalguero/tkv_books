/*
  Clase donde se guardan los datos temporales traidos de la DB

  Por limpiar
*/

import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/usuario.dart';

class Sesion{
  // con sqflutter se puede mantener la sesion iniciada
  
  // Usuario
  static Usuario usuarioLogeado;
  static ListaLibros librosDelUsuario;
  static Libro libroLeyendoPorUsuario;

  // Dialog
  static Libro libroAgregado = Libro();

  // General
  static ListaLibros librosLeyendoseTotales;
  // que se guarden los datos en estas variables estaticas?
}