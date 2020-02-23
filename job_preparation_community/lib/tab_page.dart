import 'package:flutter/material.dart';
import 'package:job_preparation_community/bottombar/account_page.dart';
import 'package:job_preparation_community/bottombar/free_page.dart';
import 'package:job_preparation_community/bottombar/job_page.dart';
import 'package:job_preparation_community/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'write_page.dart';

class TabPage extends StatefulWidget {

  final FirebaseUser user;
  TabPage(this.user);

  @override
  _TabPageState createState() => _TabPageState();

}

class _TabPageState extends State<TabPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  int _selectedIndex =0;
  List _pages ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages =[
    HomePage(widget.user),
    JobPage(widget.user),
    FreePage(widget.user),
    Text("Text4"),
    AccountPage(widget.user),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_selectedIndex],),
      bottomNavigationBar: BottomNavigationBar(

          fixedColor: Colors.white,
        onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[

        BottomNavigationBarItem(icon:Icon(Icons.home), title:Text('Home'),backgroundColor: Colors.black),
        BottomNavigationBarItem(icon:Icon(Icons.border_color), title:Text('Job'),backgroundColor: Colors.black),
        BottomNavigationBarItem(icon:Icon(Icons.insert_emoticon), title:Text('Board'),backgroundColor: Colors.black),
        BottomNavigationBarItem(icon:Icon(Icons.face), title:Text('QnA'),backgroundColor: Colors.black),
        BottomNavigationBarItem(icon:Icon(Icons.account_circle), title:Text('Account'),backgroundColor: Colors.black),
      ]),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}