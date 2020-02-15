import 'package:flutter/material.dart';

class LoginBackground extends CustomPainter{
  LoginBackground({@required this.isJoin}); // 꼭받아야하는값  옵션값 {}
  final bool isJoin;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color= isJoin?Colors.purple:Colors.indigo;
    canvas.drawCircle(Offset(size.height*0.267,size.width*0.2),size.height*0.6,paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}