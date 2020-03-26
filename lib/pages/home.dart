import 'package:flutter/material.dart';
import 'package:tkv_books/util/router.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trikavengers",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Trikavengers",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Icon(Icons.list),
                onPressed: () => Router.irListaTotal(context),
              ),
              FlatButton(
                child: Icon(Icons.verified_user),
                onPressed: () => Router.irLogin(context),
              ),
            ],
          )
        ],
      ),
    );
  }
}
