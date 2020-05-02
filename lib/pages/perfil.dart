import 'package:flutter/material.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/dialogs/agregar_libro_dialog.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/util/temaPersonlizado.dart';
import 'package:tkv_books/util/utilFunctions.dart';
import 'package:tkv_books/widgets/book_item.dart';
import 'package:tkv_books/widgets/experience_bar.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
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
        topButton: TopButton(
          nombre: "Ver todos",
          navegarA: _irAlistaTotal,
        ),
        header: Stack(
          children: <Widget>[
            Image.asset(
              "images/banner_nubes.jpg",
              fit: BoxFit.cover,
              height: Screen.height * 0.35, // Responsive
              width: double.infinity,
            ),
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
                ? _buildListaLibros()
                : Text("Aún no tienes libros agregados"),
          ],
        ),
        floatingButton: FloatingActionButton(
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.black,
            ),
          ),
          backgroundColor: ColoresTkv.cyan,
          child: Icon(
            Icons.add,
          ),
          onPressed: () => _agregarLibroDialog(),
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
      width: Screen.width * 0.98,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Sesion.librosDelUsuario.lista.length,
        itemBuilder: (BuildContext content, int index) {
          bool leyendo = Sesion.librosDelUsuario.lista[index].codLibro ==
                  Sesion.usuarioLogeado.codLibroLeyendo
              ? true
              : false;
          return BookItem(
            libro: Sesion.librosDelUsuario.lista[index],
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
                    child: titulo3Label(
                        Sesion.librosDelUsuario.lista[index].nombre),
                  ),
                ),
                Container(
                  height: 20,
                  width: Screen.width * 0.6,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: subTitulo3Label(
                        Sesion.librosDelUsuario.lista[index].autor),
                  ),
                ),
              ],
            ),
            rightButton: FlatButton(
              child: Icon(
                Icons.delete,
              ),
              onPressed: () => _abrirEliminarLibroDialog(
                  Sesion.librosDelUsuario.lista[index]),
            ),
            leftButton: FlatButton(
              child: leyendo
                  ? Icon(Icons.import_contacts)
                  : Icon(Icons.library_books),
              onPressed: () => _editarLibroLeyendoPorUsuario(
                  Sesion.librosDelUsuario.lista[index]),
            ),
          );
        },
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
    SimpleDialogTkv(
            title: "¿Eliminar libro?",
            content: "Al eliminarlo se disminuirá el puntaje ganado.",
            leftText: "No",
            rightText: "Si")
        .build(context)
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
            setState(() {});
          });
        }
      },
    );
  }

  _agregarLibroDialog() {
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
              rightText: "Comprar rai nau")
          .build(context)
          .then((val) {
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
