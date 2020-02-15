import 'package:flutter/material.dart';
import 'package:job_preparation_community/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TabPage extends StatefulWidget {

  final FirebaseUser user;



  TabPage(this.user);
  @override
  _TabPageState createState() => _TabPageState();

}

class _TabPageState extends State<TabPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
  int _selectedIndex =0;
  List _pages =[
    HomePage(),
    Text("Text2"),
    Text("Text3"),
    Text("Text4"),
    Text("Text5"),
    Text("Text6"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Center(child: _pages[_selectedIndex],),
      bottomNavigationBar: BottomNavigationBar(

          fixedColor: Colors.white,
        onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon:Icon(Icons.home), title:Text('홈'),backgroundColor: Colors.black),
        BottomNavigationBarItem(icon:Icon(Icons.border_color), title:Text('자소서')),
        BottomNavigationBarItem(icon:Icon(Icons.insert_emoticon), title:Text('인적성')),
        BottomNavigationBarItem(icon:Icon(Icons.face), title:Text('면접')),
        BottomNavigationBarItem(icon:Icon(Icons.group_add), title:Text('인턴')),
        BottomNavigationBarItem(icon:Icon(Icons.supervisor_account), title:Text('멘토')),
      ]),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}