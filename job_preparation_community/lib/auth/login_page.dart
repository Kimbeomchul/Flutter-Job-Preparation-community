import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_preparation_community/background/login_back.dart';
import 'package:job_preparation_community/data/join_or_login.dart';
import 'package:job_preparation_community/tab_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'forget_pw.dart';

class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CustomPaint(
              size: size,
              painter: LoginBackground(
                  isJoin: Provider.of<JoinOrLogin>(context).isJoin),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _logo(),
                Stack(
                  children: <Widget>[
                    _inputForm(size),
                    _loginButton(size),
//                   Container(width: 200, height: 200, color: Colors.green,),
                  ],
                ),
                Container(height: size.height * 0.1),
                SignInButton(
                  Buttons.Google,
                  onPressed: () {
                    _handleSignIn().then((user) {
                      print(user);
                    });
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Consumer<JoinOrLogin>(
                    builder: (BuildContext context, JoinOrLogin JoinOrLogin,
                            Widget child) =>
                        GestureDetector(
                            onTap: () {
                              JoinOrLogin.toggle();
                            },
                            child: Text(
                              JoinOrLogin.isJoin
                                  ? "Already Have an Account?"
                                  : "Don't Have an Account? Create One",
                              style: TextStyle(
                                  color: JoinOrLogin.isJoin
                                      ? Colors.purple
                                      : Colors.indigo),
                            )),
                  ),
                ),
                Container(height: size.height * 0.05),

              ],
            ),
          ],
        ),
      ),
    );
  }
  Future <FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser  = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth =  await googleUser.authentication;
    FirebaseUser user = (await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken))).user;
    print("Signed in" + user.displayName);

    return user;

  }


  void _register(BuildContext context) async {
    final AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final FirebaseUser user = result.user;

    if (user == null) {
      final snackBar = SnackBar(content: Text("잠시후 다시 시도해주세요."));
      Scaffold.of(context).showSnackBar(snackBar);

//    Navigator.push(context,MaterialPageRoute(builder:(context)=>TabPage(email : user.email)));
    }
  }

  void _login(BuildContext context) async {
    final AuthResult result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final FirebaseUser user = result.user;

    if (user == null) {
      final snackBar = SnackBar(content: Text("잠시후 다시 시도해주세요."));
      Scaffold.of(context).showSnackBar(snackBar);

//    Navigator.push(context,MaterialPageRoute(builder:(context)=>TabPage(email : user.email)));
    }
  }

  Widget _loginButton(Size size) {
    return Positioned(
      left: size.width * 0.15,
      right: size.width * 0.15,
      bottom: 0,
      child: SizedBox(
        height: 43,
        child: Consumer<JoinOrLogin>(
          builder: (context, value, child) => RaisedButton(
              child: Text(value.isJoin ? "Signup" : "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              color: value.isJoin ? Colors.purple : Colors.indigo,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23)),
              onPressed: () {
                if (_formkey.currentState.validate()) {
                  value.isJoin ? _register(context) : _login(context);
                }
              }),
        ),
      ),
    );
  }

  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 32),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                TextFormField(
                  obscureText: true, // 암호
                  controller: _passwordController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key), labelText: "Password"),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "비밀번호를 입력해주세요.";
                    }
                    return null;
                  },
                ),
                Container(height: 10),
                Consumer<JoinOrLogin>(
                  builder: (context, value, child) => Opacity(
                      opacity: value.isJoin ? 0 : 1, //투명도
                      child: GestureDetector(
                          onTap: value.isJoin
                              ? null
                              : () {
                                  gotoForgetPw(context);
                                },
                          child: Text("Forgot Password?"))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  gotoForgetPw(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgetPassword()));
  }

  Widget _logo() {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 90, left: 40, right: 40, bottom: 40),
        child: FittedBox(
          fit: BoxFit.contain,
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/account.gif"),
          ),
        ),
      ),
    );
  }
}



