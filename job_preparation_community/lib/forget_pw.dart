import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Forget Password"),

      ),
      body: Form(
    key : _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  icon: Icon(Icons.account_circle), labelText: "Email"),
              validator: (String value) {
                if (value.isEmpty) {
                  return "아이디를 입력해주세요.";
                }
                return null;
              },
            ),
            FlatButton(
              onPressed: () async{
                await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                final snackBar = SnackBar(content: Text("비밀번호 초기화창이 이메일로 전송되었습니다."));
                Scaffold.of(_formkey.currentContext).showSnackBar(snackBar);

              },
              child: Padding(padding:
                 const EdgeInsets.only(top: 25),
              child: Text("초기화 이메일 보내기",style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 15))),
            ),
          ],
        ),
      ),
    );
  }
}
