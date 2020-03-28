import 'package:flutter/material.dart';

Widget botonPrincipal(Function accion, String texto) {
  return Container(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: RaisedButton(
        color: Color(0xFF35A8A1),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            texto,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontFamily: "Product_Sans_Bold",
            ),
          ),
        ),
        onPressed: accion,
      ),
    ),
  );
}

Widget botonSecundario(Function accion, String texto) {
  return Container(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            texto,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontFamily: "Product_Sans_Bold",
            ),
          ),
        ),
        onPressed: accion,
      ),
    ),
  );
}

Widget botonRetrocederPagina(Function retrocederPage) {
  return InkWell(
    onTap: retrocederPage,
    child: Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            24.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 2.0,
            offset: Offset(
              5.0, // horizontal, move right 10
              5.0, // vertical, move down 10
            ),
          ),
        ],
        color: Colors.black45,
      ),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 24.0,
        ),
        onPressed: () {},
      ),
    ),
  );
}
