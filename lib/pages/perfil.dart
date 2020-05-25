import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:tkv_books/dao/dao.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dialogs/agregar_libro_dialog.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/util/utilFunctions.dart';
import 'package:tkv_books/widgets/buttons/center_floating_button.dart';
import 'package:tkv_books/widgets/buttons/top_button.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:tkv_books/widgets/labels/labelPerzonalizado.dart';
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
                  titulo1Label(Sesion.usuarioLogeado.nickname),
                  subTitulo2Label(Sesion.usuarioLogeado.nombreCompleto),
                  titulo2Label("Lv. " + Sesion.usuarioLogeado.nivel.toString()),
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
            titulo1Label("Biblioteca"),
            Sesion.librosUsuarioLogeado.lista.isNotEmpty
                ? LibraryLinearProgressTkv(
                    libreria: Sesion.librosUsuarioLogeado,
                  )
                : Text("Aún no tienes libros agregados"),
          ],
        ),
        floatingButton: CenterFloatingButtonTkv(
          icon: Icons.add,
          accion: Sesion.getDatosUsuarioLogeado(),
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
    return SimpleDialogTkv(
            title: "Cerrar sesión",
            content: "Quieres salir de tu cuenta?",
            rightText: "Si",
            leftText: "No")
        .build(context)
        .then(
      (value) {
        if (value == ConfirmAction.ACCEPT) {
          Sesion.reiniciarDatos();
          _irAhome();
        }
      },
    );
  }

  _agregarLibroDialog() {
    print("_abrirAgregarLibroDialog");
    if (Sesion.librosUsuarioLogeado.lista.length < 4 ||
        Sesion.usuarioLogeado.premium == 1) {
      agregarLibroDialog(context).then(
        (value) {
          if (Sesion.libroAgregado.codLibro != 0) {
            // Si dio aceptar
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
        },
      );
    } else {
      SimpleDialogTkv(
        title: "Limite superado",
        content:
            "Adquiera la versión premium por 5 soles para agregar más libros",
        leftText: ":(",
        rightText: "Comprar rai nau",
      ).build(context).limiteSuperadoDialog(context).then((val) {
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

  _irAhome() {
    print("_irAhome");
    Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
  }
}
