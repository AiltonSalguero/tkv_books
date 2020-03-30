// si es su perfil le sale el floating button de aniadir curso
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dialogs/agregar_libro_dialog.dart';
import 'package:tkv_books/dialogs/editar_libro_dialog.dart';
import 'package:tkv_books/dialogs/eliminar_libro_dialog.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/util/confirmAction.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/util/utilFunctions.dart';
import 'package:tkv_books/widgets/botonPersonalizado.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';

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
    print("actualizando...");

    LibroDao.getLibrosOfUsuario(Sesion.usuarioLogeado.codUsuario)
        .then((libros) {
      if (libros.lista.isNotEmpty) {
        tieneLibros = true;
        librosAgregados = libros;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topLeft,
        children: <Widget>[
          Image.asset(
            "images/banner_nubes.jpg",
            fit: BoxFit.cover,
            height: Screen.height * 0.35, // Responsive
            width: double.infinity,
          ),
          botonRetrocederPagina(_irAlistaTotal),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32.0),
                topLeft: Radius.circular(32.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 32.0,
                ),
              ],
              color: Color(0xfffafafa),
            ),
            margin: EdgeInsets.only(
              top: Screen.height * 0.3, // Responsive 266
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
              ),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  titulo2Label("Biblioteca"),
                  Column(
                    //mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      subTitulo1Label("Esta leyendo:"),
                      subTitulo1Label("Biblioteca"),
                      tieneLibros
                          ? _buildListaLibros()
                          : Text("Este men no tiene libros")
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:
          //usuarioPerfil.codUsuario == ApiDao.usuarioLogeado.codUsuario?
          FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _abrirAgregarLibroDialog(),
      ),
    );
    //      : null);
  }

  Widget _buildListaLibros() {
    return Container(
      height: Screen.height * 0.45,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
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
    String porcentajeTexto =
        porcentajeString(libro.paginasLeidas, libro.paginasTotales);
    double porcentaje =
        porcentajeDouble(libro.paginasLeidas, libro.paginasTotales);
    String paginas = "${libro.paginasLeidas} / ${libro.paginasTotales}";

    Color colorBarra;
    if (porcentaje == 1.00) colorBarra = Color(0xFFFFD938); // Amarillo
    if (porcentaje < 0.75) colorBarra = Color(0xFF35A8A1); // Turquesa
    if (porcentaje < 0.25) colorBarra = Color(0xFFF37D93); // Naranja
    if (porcentaje < 0.15) colorBarra = Color(0xFFEE5F35); // Rosa
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                titulo3Label(libro.nombre),
                subTitulo3Label(libro.autor),
              ],
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.end,
              //mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.edit),
                  onPressed: () => _onFavoriteButton(libro.codLibro),
                ),
                FlatButton(
                  child: Icon(
                    Icons.delete,
                  ),
                  onPressed: () => _abrirEliminarLibroDialog(libro.codLibro),
                )
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: LinearPercentIndicator(
            backgroundColor: Color(0xFFB7B7B7),
            width: Screen.width * 0.9,
            animation: true,
            lineHeight: 32.0,
            animationDuration: 2000,
            percent: porcentaje,
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(porcentajeTexto),
                Text(paginas),
              ],
            ),
            progressColor: colorBarra,
          ),
        ),
      ],
    );
  }

  _onFavoriteButton(int codLibro) {}

  _abrirEditarLibroDialog(int codLibro) {
    // mostrar dialog de alerta . then(){... if accept
    editarLibroDialog(context).then(
      (value) {
        if (value == ConfirmAction.ACCEPT) {
          LibroDao.deleteLibro(codLibro);
          _actualizarListaLibros();
        }
      },
    );
  }

  _abrirEliminarLibroDialog(int codLibro) {
    // mostrar dialog de alerta . then(){... if accept
    eliminarLibroDialog(context).then(
      (value) {
        if (value == ConfirmAction.ACCEPT) {
          LibroDao.deleteLibro(codLibro);
          _actualizarListaLibros();
        }
      },
    );
  }

  _abrirAgregarLibroDialog() {
    agregarLibroDialog(context).then((value) {
      LibroDao.postLibro(Sesion.libroAgregado);
      print(Sesion.libroAgregado);
      _actualizarListaLibros();
    });
  }

  _irAlistaTotal() {
    Navigator.of(context).pushNamed("/lista_total");
  }

  Widget testStream() {
    return StreamBuilder(
      initialData: [],
    );
  }
}
