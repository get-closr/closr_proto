import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

const List<String> images = [
  "asset/images/bg0.jpeg",
  "asset/images/bg1.jpeg",
  "asset/images/bg2.jpeg",
  "asset/images/test.gif"
];

class ClosrSwipper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(images[index], fit: BoxFit.cover);
        },
        indicatorLayout: PageIndicatorLayout.COLOR,
        autoplay: false,
        itemCount: images.length,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }
}
