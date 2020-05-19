import 'package:flutter/material.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/util/screen.dart';

import 'book_circular_progress.dart';

class LibraryCircularProgressTkv extends StatelessWidget {
  ListaLibros libreria;
  LibraryCircularProgressTkv({this.libreria});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Container(
        height: Screen.height * 0.55,
        // responsive
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: GridView.count(
          childAspectRatio: 24 / 29,
          crossAxisSpacing: 4.0,
          crossAxisCount: 2,
          children: libreria.lista
              .map(
                (libro) => BookCircularProgressTkv(
                  libro: libro,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
