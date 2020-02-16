import 'package:flutter/material.dart';
import 'package:job_preparation_community/write_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../comment_page.dart';

class JobPage extends StatefulWidget {
  final FirebaseUser user;

  JobPage(this.user);

  @override
  _JobPageState createState() => _JobPageState();
}

Widget _buildListItem(BuildContext context, document) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CommentPage(document);
      }));
    },
    child: new Card(

      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(16.0),
      ),
      color: Colors.grey,
      child: Row(


        children: <Widget>[


          Stack(
            children:<Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
          ),


          CircleAvatar(
            backgroundImage: NetworkImage(document['user']),
          ),
              Positioned(child:Text(
                document['displayName'], style: TextStyle(fontWeight: FontWeight.bold,)  ,
              ),left: 50, top:8,),


          Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Padding(padding: EdgeInsets.only(top: 60),),

              Image.network(
                document['photoUrl'],
                width: 140,
              ),
                ],
              ),
            ],

          ),
          Padding(padding: EdgeInsets.only(left: 10),),
          Text(
                  document['contents'],
                ),

           ],


//    Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: Text(document['contents']),
//    ),
      ),
    ),
  );
}

Widget _buildBody() {
  return Padding(
    padding: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: StreamBuilder(
        stream: Firestore.instance.collection('post').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var items = snapshot.data.documents ?? [];

          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildListItem(context, items[index]);
              });
        }),
  );
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreatePage(widget.user)));
        },
        child: Icon(Icons.create),
        backgroundColor: Colors.black,
      ),
    );
  }
}
