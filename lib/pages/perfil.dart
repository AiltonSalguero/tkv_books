// si es su perfil le sale el floating button de aniadir curso
import 'package:flutter/material.dart';
import 'package:tkv_books/dao/api_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/model/usuario.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Usuario usuarioPerfil;

  @override
  void initState() {
    // traer datos
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Esta leyendo:"),
            LibroProgress(),
            Text("Todos los libros"),
            Text("Este men no tiene libros agregados"),
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

  void _abrirAgregarLibroDialog() {}
  Widget LibroProgress() {
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
