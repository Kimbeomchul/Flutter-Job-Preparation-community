import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
class FreePage extends StatefulWidget {
  @override
  _FreePageState createState() => _FreePageState();
}

class _FreePageState extends State<FreePage> {
  @override
  Widget build(BuildContext context) {
    return new Swiper(
        itemBuilder: (BuildContext context, int index) {
      return new Image.network(
        "https://mblogthumb-phinf.pstatic.net/20151017_146/hayandoud_1445057522227ckQvF_JPEG/20151017_124409.jpg?type=w2",
        fit: BoxFit.fill,
      );
    },
    itemCount: 10,
    viewportFraction: 0.8,
    scale: 0.9,
    );
  }
}
