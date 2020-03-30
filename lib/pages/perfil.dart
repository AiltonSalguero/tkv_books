// si es su perfil le sale el floating button de aniadir curso
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/dialogs/agregar_libro_dialog.dart';
import 'package:tkv_books/dialogs/editar_libro_dialog.dart';
import 'package:tkv_books/dialogs/eliminar_libro_dialog.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/util/confirmAction.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/util/temaPersonlizado.dart';
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
          _buildEncabezado(),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32.0),
                topLeft: Radius.circular(32.0),
              ),
              border: Border.all(
                color: Colors.black,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 24.0,
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
                  titulo1Label("Biblioteca"),
                  tieneLibros
                      ? _buildListaLibros()
                      : Text("Este men no tiene libros"),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:
          //usuarioPerfil.codUsuario == ApiDao.usuarioLogeado.codUsuario?
          FloatingActionButton(
        shape: CircleBorder(
            side: BorderSide(
          color: Colors.black,
        ),),
        backgroundColor: ColoresTkv.cyan,
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _abrirAgregarLibroDialog(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
    //      : null);
  }

  Widget _buildEncabezado() {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          titulo1Label(Sesion.usuarioLogeado.nickname),
          subTitulo1Label(Sesion.usuarioLogeado.nombres +
              " " +
              Sesion.usuarioLogeado.apellidos),
        ],
      ),
    );
  }

  Widget _buildListaLibros() {
    return Container(
      height: Screen.height * 0.50,
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

    Color colorBarra = colorProgressBar(porcentaje);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 4.0,
      ),
      child: Container(
        height: 90,
        width: Screen.width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
          border: Border.all(
            color: Colors.black,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 16.0,
            ),
          ],
          color: Color(0xfffafafa),
        ),
        child: Column(
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
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.edit),
                      onPressed: () => _abrirEditarLibroDialog(libro.codLibro),
                    ),
                    FlatButton(
                      child: Icon(
                        Icons.delete,
                      ),
                      onPressed: () =>
                          _abrirEliminarLibroDialog(libro.codLibro),
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
                width: Screen.width * 0.85,
                animation: true,
                lineHeight: 28.0,
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
        ),
      ),
    );
  }

  _abrirEditarLibroDialog(int codLibro) {
    // mostrar dialog de alerta . then(){... if accept
    UsuarioDao.putUsuarioSetLibroLeyendo(
            Sesion.usuarioLogeado.codUsuario, codLibro)
        .then((val) {
      Sesion.usuarioLogeado.codLibroLeyendo = codLibro;
    });

    //editarLibroDialog(context).then(
    // (value) {
    //  if (value == ConfirmAction.ACCEPT) {
    //   LibroDao.deleteLibro(codLibro);
    //  _actualizarListaLibros();
    //}
    //},
    //);
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
    Navigator.of(context).pushReplacementNamed("/lista_total");
  }

  Widget testStream() {
    return StreamBuilder(
      initialData: [],
    );
  }
}
