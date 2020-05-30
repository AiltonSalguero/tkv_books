import 'package:flutter/material.dart';
import 'package:tkv_books/cognito/sesion_cognito.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dialogs/agregar_libro_dialog.dart';
import 'package:tkv_books/dialogs/normal_dialog.dart';
import 'package:tkv_books/util/utilFunctions.dart';
import 'package:tkv_books/widgets/buttons/center_floating_button.dart';
import 'package:tkv_books/widgets/buttons/top_button.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:tkv_books/widgets/labels/subtitulo_label.dart';
import 'package:tkv_books/widgets/labels/titulo_label.dart';
import 'package:tkv_books/widgets/page_background.dart';
import 'package:tkv_books/widgets/progress/experience_bar.dart';
import 'package:tkv_books/widgets/progress/library_linear_progress.dart';

/*


  si es su perfil le sale el floating button de aniadir curso
*/

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  void initState() {
    print("initState");

    // if (!Sesion.vieneDeRegistro) {
    // UsuarioDao.getUsuarioByNickname(Sesion.usuarioLogeado.nickname)
    //   .then((user) {
    //Sesion.usuarioLogeado.codUsuario = user.codUsuario;

    //Sesion.vieneDeRegistro = false;
    //});
    //}
    //_obtenerLibroLeyendosePorUsuario();
    //_actualizarListaLibros();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    Sesion.contextActual = context;
    return WillPopScope(
      onWillPop: _cerrarSesionDialog,
      child: PageBackground(
        backgroundImagePath: "images/banner_nubes.jpg",
        topButton: TopButtonTkv(
          nombre: "Ver todos",
          navegarA: _irAlistaTotal,
        ),
        header: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  TituloLabel(
                    texto: Sesion.usuarioLogeado.nickname,
                    numeroTitulo: 1,
                  ),
                  SubtituloLabel(
                    texto: Sesion.usuarioLogeado.nombreCompleto,
                    numeroTitulo: 2,
                  ),
                  TituloLabel(
                    texto: "Lv. " + Sesion.usuarioLogeado.nivel.toString(),
                    numeroTitulo: 1,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0, -0.505),
              child: ExperienceBar(
                puntaje: Sesion.usuarioLogeado.puntaje,
                level: Sesion.usuarioLogeado.nivel,
              ),
            ),
          ],
        ),
        content: Column(
          children: <Widget>[
            TituloLabel(
              texto: "Biblioteca",
              numeroTitulo: 1,
            ),
            Sesion.librosUsuarioLogeado.lista.isNotEmpty
                ? LibraryLinearProgressTkv(
                    libreria: Sesion.librosUsuarioLogeado,
                  )
                : Text("Aún no tienes libros agregados"),
          ],
        ),
        floatingButton: CenterFloatingButtonTkv(
          icon: Icons.add,
          accion: _agregarLibroDialog,
        ),
      ),
    );
  }

  _actualizarListaLibros() {
    print("_actualizarListaLibros");

    LibroDao.getLibrosOfUsuario(Sesion.usuarioLogeado.codUsuario)
        .then((libros) {
      if (libros.lista.isNotEmpty) {
        print(libros.lista.length.toString());
        Sesion.librosUsuarioLogeado = libros;
      }
      print(Sesion.librosUsuarioLogeado.toJson());
      setState(() {});
    });
  }

  Future<bool> _cerrarSesionDialog() {
    print("_abrirCerrarSesionDialog");
    return NormalDialog(
            context: context,
            title: "Cerrar sesión",
            content: "Quieres salir de tu cuenta?",
            rightText: "Si",
            leftText: "No")
        .build()
        .then(
      (value) {
        if (value == ConfirmAction.ACCEPT) {
          SesionCognito.cerrarSesion();
          _irAhome();
        }
      },
    );
  }

  _sePuedeAgregar() {
    return Sesion.librosUsuarioLogeado.lista.length < 4 ||
        Sesion.usuarioLogeado.premium == 1;
  }

  _agregarLibroDialog() {
    if (_sePuedeAgregar()) {
      AgregarLibroDialog(
        context: context,
      ).build().then(
        (value) {
          if (Sesion.libroAgregado.codLibro != 0) {
            // Si dio aceptar
            _agregarLibro();
          }
        },
      );
    } else {
      NormalDialog(
        context: context,
        title: "Limite superado",
        content:
            "Adquiera la versión premium por 5 soles para agregar más libros",
        leftText: ":(",
        rightText: "Comprar rai nau",
      ).build().then((val) {
        if (val == ConfirmAction.ACCEPT) {
          FlutterOpenWhatsapp.sendSingleMessage("51960762446",
              "Buenas :D, deseo adquirir la version premium de Trikavengers.");
        }
      });
    }
  }

  _irAlistaTotal() {
    print("_irAlistaTotal");
    Navigator.of(context).pushNamed("/lista_total");
  }

  _agregarLibro() {
    Sesion.usuarioLogeado.puntaje += Sesion.libroAgregado.paginasLeidas;
    Sesion.usuarioLogeado.nivel =
        calcularLevelUsuario(Sesion.usuarioLogeado.puntaje);

    LibroDao.postLibro(Sesion.libroAgregado).then((val) {
      //Sesion.libroAgregado = null;
      Sesion.librosUsuarioLogeado.lista.add(Sesion.libroAgregado);
      Sesion.libroAgregado.codLibro = 0;
      setState(() {});
    });
  }

  _irAhome() {
    print("_irAhome");
    Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
  }
}
