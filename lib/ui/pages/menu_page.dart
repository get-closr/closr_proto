import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:closr/models/pages.dart';
import 'package:closr/ui/theme/color.dart';

class MenuPage extends StatelessWidget {
  final Pages currentPage;
  final ValueChanged<Pages> onPagesTap;
  final List<Pages> _pages = Pages.values;

  const MenuPage({
    Key key,
    @required this.currentPage,
    @required this.onPagesTap,
  })  : assert(currentPage != null),
        assert(onPagesTap != null);

  Widget _buildPage(Pages page, BuildContext context) {
    final pageString = page.toString().replaceAll('Pages.', '').toUpperCase();
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onPagesTap(page),
      child: page == currentPage
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  pageString,
                  style: theme.textTheme.body2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 14.0,
                ),
                Container(
                  width: 70.0,
                  height: 2.0,
                  color: kClosrPink400,
                )
              ],
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                pageString,
                style: Theme.of(context)
                    .textTheme
                    .body2
                    .copyWith(color: kClosrBrown900.withAlpha(153)),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.only(top: 40.0),
      color: Theme.of(context).accentColor,
      child: ListView(
          children: _pages.map((Pages p) => _buildPage(p, context)).toList()),
    ));
  }
}
