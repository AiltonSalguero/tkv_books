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

Widget botonTercero(String texto, Function accion) {
  return Align(
    alignment: Alignment(
      -0.95,
      0.7,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
        ), // responsive
        GestureDetector(
          onTap: accion,
          child: Container(
            height: 36,
            width: 90,
            decoration: BoxDecoration(
              color: Color(0xFF35A8A1),
              borderRadius: BorderRadius.circular(
                20.0,
              ),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Center(
              child: Text(
                texto,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: "Product_Sans_Bold",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget botonRetrocederPagina(Function retrocederPage) {
  return Padding(
    padding: EdgeInsets.only(
      top: 32.0,
      left: 8.0,
    ),
    child: InkWell(
      onTap: retrocederPage,
      child: Container(
        height: 40,
        width: 40,
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
          onPressed: retrocederPage,
        ),
      ),
    ),
  );
}
