import 'package:flutter/material.dart';
import 'package:job_preparation_community/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_preparation_community/auth/login_page.dart';
import 'package:provider/provider.dart';
import 'data/join_or_login.dart';
class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream : FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.hasData){
          return TabPage(snapshot.data);
        }
        else{
          return MaterialApp(
            home: ChangeNotifierProvider<JoinOrLogin>.value(
                value:JoinOrLogin(),
                child: LoginPage()),
          );
        }
      },

    );
  }
}
