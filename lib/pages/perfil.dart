// si es su perfil le sale el floating button de aniadir curso
import 'package:flutter/material.dart';
import 'package:tkv_books/dao/api_dao.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dialogs/agregar_libro_dialog.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/usuario.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Usuario usuarioPerfil;

  bool tieneLibros = false;
  ListaLibros librosAgregados;

  @override
  void initState() {
    // traer datos
    _actualizarListaLibros();
  }

  void _actualizarListaLibros() {
    LibroDao.getLibrosOfUsuario(Sesion.usuarioLogeado.codUsuario)
        .then((libros) {
      print(libros.lista);

      if (libros.lista.isNotEmpty) {
        tieneLibros = true;
        librosAgregados = libros;
        setState(() {
          print(tieneLibros);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${Sesion.usuarioLogeado.nickname}",
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Esta leyendo:"),
            libroProgress(),
            Text("Todos los libros"),
            tieneLibros ? _buildListaLibros() : Text("Este men no tiene libros")
          ],
        ),
        floatingActionButton:
            //usuarioPerfil.codUsuario == ApiDao.usuarioLogeado.codUsuario?
            FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () => _abrirAgregarLibroDialog(),
        ));
    //            : null);
  }

  Widget _buildListaLibros() {
    return Transform.translate(
          offset: Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
          child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(0.0),
        scrollDirection: Axis.vertical,
        primary: true,
        itemCount: librosAgregados.lista.length,
        itemBuilder: (BuildContext content, int index) {
          return _buildLibroListItem(
            librosAgregados.lista[index],
          );
        },
      ),
    );
  }

  Widget _buildLibroListItem(Libro libro) {
    return Text(
      libro.nombre,
      style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 28.0,
          fontWeight: FontWeight.bold),
    );
  }

  void _abrirAgregarLibroDialog() {
    agregarLibroDialog(context).then((libro) {
      LibroDao.postLibro(Sesion.libroAgregado);
    });
    _actualizarListaLibros();
  }

  Widget libroProgress() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Nombre / autor"),
          Text("34 / 100"),
        ],
      ),
    );
  }
}
