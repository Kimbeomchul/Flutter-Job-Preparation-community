import 'package:flutter/material.dart';

class CommentPage extends StatelessWidget {
  final dynamic document;

  CommentPage(this.document);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(document['user']),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          document['email'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(document['displayName'])
                      ],
                    ),
                  )
                ],
              ),
            ),
            Image.network(document['photoUrl']),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(document['contents']),
            ),
          ],
        ),
      ),
    );
  }
}
