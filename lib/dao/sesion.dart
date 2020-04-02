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
  static ListaLibros librosDelUsuario = ListaLibros();
  static Libro libroLeyendoPorUsuario;
  

  // Dialog
  static Libro libroAgregado = Libro();

  // General
  static ListaLibros librosLeyendoseTotales;

  // Otros perfiles
  static Usuario usuarioSeleccionado;
  static ListaLibros librosDelUsuarioSeleccionado;
  static int numeroLibrosUsuario = 0;
  // que se guarden los datos en estas variables estaticas?
}