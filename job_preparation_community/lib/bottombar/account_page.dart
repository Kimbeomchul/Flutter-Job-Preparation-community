import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AccountPage extends StatefulWidget {
  final FirebaseUser user;
  AccountPage(this.user);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  _buildAppbar(),
      body: _buildbody(),
    );
  }

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

 Widget _imageUrl (){
    if (widget.user.photoUrl == null){
      var notnull = widget.user.photoUrl ?? [];
      return notnull;
    }
  }


  Widget _buildbody() {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                      width:80.0,
                      height:80.0,
                      child:CircleAvatar(
                         backgroundImage: NetworkImage(widget.user.photoUrl),
                      ),
                    ),
                    Container(
                      width:80.0,
                      height:80.0,
                      alignment: Alignment.bottomRight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          SizedBox(
                            width:28.0,
                            height:28.0,
                            child: FloatingActionButton(onPressed: null,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width:25.0,
                            height:25.0,
                            child: FloatingActionButton(onPressed: null,
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.all(8.0)),

              ],
            ),
            Text(widget.user.email,
                style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),

          ],
        )
    );
  }
}
