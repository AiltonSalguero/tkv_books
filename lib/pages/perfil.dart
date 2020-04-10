/*


  si es su perfil le sale el floating button de aniadir curso
*/
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/dialogs/agregar_libro_dialog.dart';
import 'package:tkv_books/dialogs/eliminar_libro_dialog.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/util/confirmAction.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/util/temaPersonlizado.dart';
import 'package:tkv_books/util/utilFunctions.dart';
import 'package:tkv_books/widgets/botonPersonalizado.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  void initState() {
    print("initState");
    if (!Sesion.vieneDeRegistro) {
      UsuarioDao.getUsuarioByNickname(Sesion.usuarioLogeado.nickname)
          .then((user) {
        Sesion.usuarioLogeado.codUsuario = user.codUsuario;

        Sesion.vieneDeRegistro = false;
      });
    }
    _obtenerLibroLeyendosePorUsuario();
    _actualizarListaLibros();
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

  Future<bool> _abrirCerrarSesionDialog() {
    print("_abrirCerrarSesionDialog");
    alertaDialog(context, "Cerrar sesión", "Quieres salir de tu cuenta?", "No",
                "Si")
            .then(
          (value) {
            if (value == ConfirmAction.ACCEPT) {
              Sesion.usuarioLogeado = Usuario("", "", "", "");
              Sesion.librosDelUsuario.lista = [];
              Sesion.libroLeyendoPorUsuario = Libro("", "", 0, 0);
              _irAhome();
              return true;
            }
            return false;
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    return WillPopScope(
      onWillPop: _abrirCerrarSesionDialog,
      child: Scaffold(
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
            botonTercero("Ver todos", _irAlistaTotal),
            _buildEncabezado(),
            _buildExperiencia(
                Sesion.usuarioLogeado.puntaje, Sesion.usuarioLogeado.level),
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
                padding: EdgeInsets.only(
                  top: 16.0,
                ),
                child: Column(
                  children: <Widget>[
                    titulo1Label("Biblioteca"),
                    Sesion.librosDelUsuario.lista.isNotEmpty
                        ? _buildListaLibros()
                        : Text("Aún no tienes libros agregados"),
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
            ),
          ),
          backgroundColor: ColoresTkv.cyan,
          child: Icon(
            Icons.add,
          ),
          onPressed: () => _abrirAgregarLibroDialog(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
    //      : null);
  }

  Widget _buildExperiencia(int puntaje, int level) {
    print("_buildExperiencia");
    int puntajeDelNivel = puntaje - calcularExperienciaRequeridaTotal(level);
    double porcentajeExperiencia = porcentajeDouble(
        puntajeDelNivel, calcularExperienciaRequerida(level + 1));
    String expRequerida = calcularExperienciaRequerida(level + 1).toString();
    String progresoLevel = "${puntajeDelNivel.toString()} / $expRequerida";
    return Align(
      alignment: Alignment(0, -0.55),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Screen.width * 0.15),
        child: LinearPercentIndicator(
          width: Screen.width * 0.7,
          lineHeight: 8.0,
          percent: porcentajeExperiencia,
          progressColor: ColoresTkv.amarillo,
          center: Text(
            progresoLevel,
            style: TextStyle(
              fontSize: 8.0,
            ),
          ),
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
          subTitulo2Label(Sesion.usuarioLogeado.nombres +
              " " +
              Sesion.usuarioLogeado.apellidos),
          titulo2Label("Lv. " + Sesion.usuarioLogeado.level.toString()),
        ],
      ),
    );
  }

  Widget _buildListaLibros() {
    print("_buildListaLibros");
    return Container(
      height: Screen.height * 0.50,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Sesion.librosDelUsuario.lista.length,
        itemBuilder: (BuildContext content, int index) {
          return _buildLibroListItem(
            Sesion.librosDelUsuario.lista[index],
          );
        },
      ),
    );
  }

  Widget _buildLibroListItem(Libro libro) {
    print("_buildLibroListItem");
    String porcentajeTexto =
        porcentajeString(libro.paginasLeidas, libro.paginasTotales);
    double porcentaje =
        porcentajeDouble(libro.paginasLeidas, libro.paginasTotales);
    String paginas = "${libro.paginasLeidas} / ${libro.paginasTotales}";

    Color colorBarra = colorProgressBar(porcentaje);

    bool leyendo = false;
    libro.codLibro == Sesion.usuarioLogeado.codLibroLeyendo
        ? leyendo = true
        : leyendo = false;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 4.0,
      ),
      child: Container(
        height: 90,
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
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Screen.width * 0.05,
                  vertical: 8.0,
                ),
                child: LinearPercentIndicator(
                  backgroundColor: Color(0xFFB7B7B7),
                  width: Screen.width * 0.86,
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
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 20,
                      width: Screen.width * 0.6,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: titulo3Label(libro.nombre),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: Screen.width * 0.6,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: subTitulo3Label(libro.autor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                child: Icon(
                  Icons.delete,
                ),
                onPressed: () => _abrirEliminarLibroDialog(libro),
              ),
            ),
            Align(
              alignment: Alignment(
                0.6,
                -1,
              ),
              child: FlatButton(
                child: leyendo
                    ? Icon(Icons.import_contacts)
                    : Icon(Icons.library_books),
                onPressed: () => _editarLibroLeyendoPorUsuario(libro),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _editarLibroLeyendoPorUsuario(Libro libro) {
    print("_editarLibroLeyendoPorUsuario");
    Sesion.libroLeyendoPorUsuario = libro;
    Sesion.usuarioLogeado.codLibroLeyendo = libro.codLibro;
    UsuarioDao.putUsuarioSetLibroLeyendo(Sesion.usuarioLogeado)
        .then((val) => setState(() {}));
  }

  _abrirEliminarLibroDialog(Libro libro) {
    print("_abrirEliminarLibroDialog");
    alertaDialog(context, "Eliminar libro?",
            "Al eliminarlo se disminuirá el puntaje ganado.", "No", "Si")
        .then(
      (value) {
        if (value == ConfirmAction.ACCEPT) {
          Sesion.usuarioLogeado.puntaje -= libro.paginasLeidas;
          Sesion.usuarioLogeado.level =
              calcularLevelUsuario(Sesion.usuarioLogeado.puntaje);

          if (libro.codLibro == Sesion.usuarioLogeado.codLibroLeyendo) {
            Sesion.usuarioLogeado.codLibroLeyendo = 0;
            UsuarioDao.putUsuarioSetLibroLeyendo(Sesion.usuarioLogeado);
          }

          LibroDao.deleteLibro(libro.codLibro).then((val) {
            Sesion.librosDelUsuario.lista.remove(libro);
            UsuarioDao.putUsuarioSetPuntajeLevel(Sesion.usuarioLogeado)
                .then((val) {
              //_actualizarListaLibros();
              setState(() {});
            });
          });
        }
      },
    );
  }

  _abrirAgregarLibroDialog() {
    print("_abrirAgregarLibroDialog");
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
              print("a0" + Sesion.librosDelUsuario.lista.length.toString());
              Sesion.librosDelUsuario.lista.add(Sesion.libroAgregado);
              print("a" + Sesion.librosDelUsuario.lista.length.toString());
              print("afds");
              UsuarioDao.putUsuarioSetPuntajeLevel(Sesion.usuarioLogeado)
                  .then((val) {
                //_actualizarListaLibros();
                setState(() {
                  Sesion.libroAgregado.codLibro = 0;
                });
              });
            });
          }
          print("b" + Sesion.librosDelUsuario.lista.length.toString());
        },
      );
    } else {
      alertaDialog(
              context,
              "Limite superado",
              "Adquiera la versión premium por 5 soles para agregar más libros.",
              "Okay :(",
              "Comprar rai nau")
          .then((val) {
        if (val == ConfirmAction.ACCEPT) {
          FlutterOpenWhatsapp.sendSingleMessage("51960762446",
              "Buenas, deseo adquirir la version premium de Trikavengers.");
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
