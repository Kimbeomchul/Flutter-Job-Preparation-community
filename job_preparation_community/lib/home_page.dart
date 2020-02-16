import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  FirebaseUser user;
  HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _mainwidget = <Widget>[
    Container(
      color: Colors.grey,
      child: Text(
        'Index 0 ',
        style: optionStyle,

      ),
    ),
    Container(
      color: Colors.blue,
      child: Text(
        'Index 1 ',
        style: optionStyle,
      ),
    ),
    Container(
      color: Colors.green,
      child: Text(
        'Index 2 ',
        style: optionStyle,
      ),
    ),
    Container(
      color: Colors.purple,
      child: Text(
        'Index 3 ',
        style: optionStyle,
      ),
    ),
    Container(
      color: Colors.red,
      child: Text(
        'Index 4 ',
        style: optionStyle,
      ),
    ),

  ];

  Widget _buildAppbar() {

    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app), onPressed: () {
          FirebaseAuth.instance.signOut();
          _googleSignIn.signOut();
        },
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: _buildAppbar(),
      body: Column(
        children: <Widget>[

          Expanded(
            child: PageView(
              children: _mainwidget,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 350),
          ),
        ],
      ),
    );
  }
}
