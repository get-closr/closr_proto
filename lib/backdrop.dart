import 'package:flutter/material.dart';
import 'models/pages.dart';
import 'utils/auth.dart';

const double _kFlingVelocity = 2.0;

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({Key key, this.onTap, this.child}) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: 40.0,
              alignment: AlignmentDirectional.centerStart,
            ),
          ),
          Expanded(
            // color: Colors.teal,
            // height: 700,
            child: child,
          )
        ],
      ),
    );
  }
}

class _BackdropTile extends AnimatedWidget {
  final Function onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTile(
      {Key key,
      Listenable listenable,
      this.onPress,
      @required this.frontTitle,
      @required this.backTitle})
      : assert(frontTitle != null),
        assert(backTitle != null),
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;

    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 72.0,
            child: IconButton(
              padding: EdgeInsets.only(right: 8.0),
              onPressed: this.onPress,
              icon: Stack(
                children: <Widget>[
                  Opacity(
                    opacity: animation.value,
                    child:
                        ImageIcon(AssetImage('asset/images/slanted_menu.png')),
                  ),
                  FractionalTranslation(
                    translation:
                        Tween<Offset>(begin: Offset.zero, end: Offset(1, 0))
                            .evaluate(animation),
                    child: ImageIcon(AssetImage('asset/images/diamond.png')),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Opacity(
                opacity: CurvedAnimation(
                        parent: ReverseAnimation(animation),
                        curve: Interval(0.5, 1.0))
                    .value,
                child: FractionalTranslation(
                  translation:
                      Tween<Offset>(begin: Offset.zero, end: Offset(0.5, 0.0))
                          .evaluate(animation),
                  child: backTitle,
                ),
              ),
              Opacity(
                opacity: CurvedAnimation(
                        parent: animation, curve: Interval(0.5, 1.0))
                    .value,
                child: FractionalTranslation(
                  translation:
                      Tween<Offset>(begin: Offset(-0.25, 0.0), end: Offset.zero)
                          .evaluate(animation),
                  child: frontTitle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Backdrop extends StatefulWidget {
  final Pages currentPage;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;
  final Auth auth;
  final VoidCallback onSignedOut;

  const Backdrop(
      {@required this.currentPage,
      @required this.frontLayer,
      @required this.backLayer,
      @required this.frontTitle,
      @required this.backTitle,
      @required this.auth,
      @required this.onSignedOut})
      : assert(currentPage != null),
        assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null),
        assert(auth != null),
        assert(onSignedOut != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  AnimationController _controller;

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 28.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, layerTop, 0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0, 0, 0, 0),
    ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
          rect: layerAnimation,
          child: _FrontLayer(
              onTap: _toggleBackdropLayerVisibility, child: widget.frontLayer),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);
    if (widget.currentPage != old.currentPage) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  IconData bluetoothStatus(int status) {
    List<IconData> iconList = [
      Icons.bluetooth_connected,
      Icons.bluetooth_disabled,
      Icons.bluetooth_searching,
      Icons.check_circle
    ];
    return iconList[status];
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      title: _BackdropTile(
        listenable: _controller.view,
        onPress: _toggleBackdropLayerVisibility,
        frontTitle: widget.frontTitle,
        backTitle: widget.backTitle,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            // Icons.bluetooth_disabled,
            bluetoothStatus(2),
            color: Colors.purple,
            semanticLabel: 'bluetooth',
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.exit_to_app, semanticLabel: 'logout'),
          onPressed: _signOut,
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
