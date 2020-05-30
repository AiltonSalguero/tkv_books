import 'package:flutter/material.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/dialogs/normal_dialog.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/util/utilFunctions.dart';
import 'package:tkv_books/widgets/labels/subtitulo_label.dart';
import 'package:tkv_books/widgets/labels/titulo_label.dart';
import 'package:tkv_books/widgets/progress/book_linear_progress.dart';

class LibraryLinearProgressTkv extends StatefulWidget {
  final ListaLibros libreria;
  LibraryLinearProgressTkv({this.libreria});

  @override
  _LibraryLinearProgressTkvState createState() =>
      _LibraryLinearProgressTkvState();
}

class _LibraryLinearProgressTkvState extends State<LibraryLinearProgressTkv> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screen.height * 0.50,
      width: Screen.width * 0.98,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.libreria.lista.length,
        itemBuilder: (BuildContext content, int index) {
          bool leyendo = widget.libreria.lista[index].codLibro ==
                  Sesion.usuarioLogeado.codLibroLeyendo
              ? true
              : false;
          return BookLinearProgressTkv(
            libro: widget.libreria.lista[index],
            boxHeight: 85,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 20,
                  width: Screen.width * 0.6,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: TituloLabel(
                      texto: Sesion.librosUsuarioLogeado.lista[index].nombre,
                      numeroTitulo: 3,
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: Screen.width * 0.6,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SubtituloLabel(
                        texto: Sesion.librosUsuarioLogeado.lista[index].autor,
                        numeroTitulo: 3,
                      )),
                ),
              ],
            ),
            rightButton: FlatButton(
              child: Icon(
                Icons.delete,
              ),
              onPressed: () => _abrirEliminarLibroDialog(
                  Sesion.librosUsuarioLogeado.lista[index]),
            ),
            leftButton: FlatButton(
              child: leyendo
                  ? Icon(Icons.import_contacts)
                  : Icon(Icons.library_books),
              onPressed: () => _editarLibroLeyendoPorUsuario(
                  Sesion.librosUsuarioLogeado.lista[index]),
            ),
          );
        },
      ),
    );
  }

  _editarLibroLeyendoPorUsuario(Libro libro) {
    print("_editarLibroLeyendoPorUsuario");
    Sesion.libroLeyendoUsuarioLogeado = libro;
    Sesion.usuarioLogeado.codLibroLeyendo = libro.codLibro;
    UsuarioDao.putUsuarioSetLibroLeyendo(Sesion.usuarioLogeado)
        .then((val) => setState(() {}));
  }

  _abrirEliminarLibroDialog(Libro libro) {
    print("_abrirEliminarLibroDialog");
    NormalDialog(
      context: context,
      title: "¿Eliminar libro?",
      content: "Al eliminarlo se disminuirá el puntaje ganado.",
      leftText: "No",
      rightText: "Si",
    ).build().then(
      (value) {
        if (value == ConfirmAction.ACCEPT) {
          Sesion.usuarioLogeado.puntaje -= libro.paginasLeidas;
          Sesion.usuarioLogeado.nivel =
              calcularLevelUsuario(Sesion.usuarioLogeado.puntaje);

          if (libro.codLibro == Sesion.usuarioLogeado.codLibroLeyendo) {
            Sesion.usuarioLogeado.codLibroLeyendo = 0;
            UsuarioDao.putUsuarioSetLibroLeyendo(Sesion.usuarioLogeado);
          }
          LibroDao.deleteLibro(libro.codLibro).then(
            (val) {
              Sesion.librosUsuarioLogeado.lista.remove(libro);
              setState(() {});
            },
          );
        }
      },
    );
  }
}
