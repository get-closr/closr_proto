import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoContent extends StatelessWidget {
  const NoContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Hang on, it\'s not here yet! '),
          SvgPicture.asset(
            'asset/images/undraw_true_friends_c94g.svg',
            height: 300.0,
          ),
          Text('We are working on getting Closr to you'),
        ],
      ),
    );
  }
}
