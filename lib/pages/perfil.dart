import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:tkv_books/dao/dao.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dialogs/agregar_libro_dialog.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';
import 'package:tkv_books/util/utilFunctions.dart';
import 'package:tkv_books/widgets/center_floating_button.dart';
import 'package:tkv_books/widgets/experience_bar.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:tkv_books/widgets/library_linear_progress.dart';
import 'package:tkv_books/widgets/page_background.dart';
import 'package:tkv_books/widgets/top_button.dart';

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
    FlutterAwsAmplifyCognito.getTokens().then((Tokens tokens) {
      Dao.cognitoToken = tokens.idToken;

      print('Access Token: ${tokens.accessToken}');
      print('ID Token: ${tokens.idToken}');
      print('Refresh Token: ${tokens.refreshToken}');
      _getLibro().then((value) => print(value));
    }).catchError((error) {
      print(error);
    });

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

  Future<dynamic> _getLibro() async {
    print(Dao.cognitoToken);
    print(Dao.apiUrl + "libro");
    _getUserAttributes();
    return Dao.jsonDecodedHttpGet(Dao.apiUrl + "llibros");
  }

  _getUserAttributes() async {
    FlutterAwsAmplifyCognito.getUserAttributes().then((userDetails) {
      print('$userDetails');
    }).catchError((error) {
      print(error);
    });
    FlutterAwsAmplifyCognito.getUsername().then((username) {
      print('username is $username');
    }).catchError((error) {
      print(error);
    });

    FlutterAwsAmplifyCognito.getIdentityId().then((identityId) {
      print('Identity ID is $identityId');
    }).catchError((error) {
      print(error);
    });
  }

  _obtenerLibroLeyendosePorUsuario() {
    if (Sesion.usuarioLogeado.codLibroLeyendo != 0) {
      LibroDao.getLibroByCod(Sesion.usuarioLogeado.codLibroLeyendo).then(
        (libro) {
          Sesion.libroLeyendoPorUsuario = libro;
        },
      );
    }
  }

  _actualizarListaLibros() {
    print("_actualizarListaLibros");

    LibroDao.getLibrosOfUsuario(Sesion.usuarioLogeado.codUsuario)
        .then((libros) {
      if (libros.lista.isNotEmpty) {
        print(libros.lista.length.toString());
        Sesion.librosDelUsuario = libros;
      }
      print(Sesion.librosDelUsuario.toJson());
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
            _buildEncabezado(),
            Align(
              alignment: Alignment(0, -0.505),
              child: ExperienceBar(
                puntaje: Sesion.usuarioLogeado.puntaje,
                level: Sesion.usuarioLogeado.level,
              ),
            ),
          ],
        ),
        content: Column(
          children: <Widget>[
            titulo1Label("Biblioteca"),
            Sesion.librosDelUsuario.lista.isNotEmpty
                ? LibraryLinearProgressTkv(
                    libreria: Sesion.librosDelUsuario,
                  )
                : Text("Aún no tienes libros agregados"),
          ],
        ),
        floatingButton: CenterFloatingButtonTkv(
          icon: Icons.add,
          accion: _getUserAttributes,
        ),
      ),
    );
  }

  Widget _buildEncabezado() {
    print("_buildEncabezado");
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          titulo1Label(Sesion.usuarioLogeado.nickname),
          subTitulo2Label(Sesion.usuarioLogeado.nombreCompleto),
          titulo2Label("Lv. " + Sesion.usuarioLogeado.level.toString()),
        ],
      ),
    );
  }

  _agregarLibroDialog() {
    print("_abrirAgregarLibroDialog");
    _getLibro().then((value) => print(value));
    if (Sesion.librosDelUsuario.lista.length < 4 ||
        Sesion.usuarioLogeado.premium == 1) {
      agregarLibroDialog(context).then(
        (value) {
          if (Sesion.libroAgregado.codLibro != 0) {
            // Si dio aceptar
            Sesion.usuarioLogeado.puntaje += Sesion.libroAgregado.paginasLeidas;
            Sesion.usuarioLogeado.level =
                calcularLevelUsuario(Sesion.usuarioLogeado.puntaje);

            LibroDao.postLibro(Sesion.libroAgregado).then((val) {
              //Sesion.libroAgregado = null;
              Sesion.librosDelUsuario.lista.add(Sesion.libroAgregado);
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
