import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tkv_books/pages/home.dart';
import 'package:tkv_books/pages/lista_total.dart';
import 'package:tkv_books/pages/login.dart';
import 'package:tkv_books/pages/perfil.dart';
import 'package:tkv_books/pages/registro.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trikavengers',
      debugShowCheckedModeBanner: false,
      locale: Locale('es'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/registro': (context) => RegistroPage(),
        '/perfil': (context) => PerfilPage(),
        '/lista_total': (context) => ListaTotalPage(),
      },
      initialRoute: '/',
      localizationsDelegates: [
        // ... delegado[s] de localización específicos de la app aquí
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // Inglés
        const Locale('es'), // Español
      ],
    );
  }
}
