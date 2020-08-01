import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';

class RousseauAnimatedScreen extends StatefulWidget {
  const RousseauAnimatedScreen(
      {@required this.appBar,
      @required this.extendedAppBar,
      @required this.body,
      this.backgroundColor,
      this.floatingActionButton});

  final Widget extendedAppBar;
  final Widget appBar;
  final Widget body;
  final Widget floatingActionButton;
  final Color backgroundColor;

  @override
  _RousseauAnimatedScreenState createState() => _RousseauAnimatedScreenState();
}

class _RousseauAnimatedScreenState extends State<RousseauAnimatedScreen> {
  static const double APP_BAR_HEIGHT = 100;
  static const double FADE_IN_THREHOLD = 150;

  final ScrollController _scrollController = ScrollController();
  Color appBarBackground;
  double topPosition;

  @override
  void initState() {
    topPosition = -APP_BAR_HEIGHT;
    appBarBackground = Colors.transparent;
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  double _getOpacity() {
    double op = (topPosition + APP_BAR_HEIGHT) / APP_BAR_HEIGHT;
    return op > 1 || op < 0 ? 1 : op;
  }

  void _onScroll() {
    if (_scrollController.offset > 50) {
      if (topPosition < 0) {
        setState(() {
          topPosition = -FADE_IN_THREHOLD + _scrollController.offset;
          if (_scrollController.offset > FADE_IN_THREHOLD) {
            topPosition = 0;
          }
        });
      }
    } else {
      if (topPosition > -APP_BAR_HEIGHT) {
        setState(() {
          topPosition--;
          if (_scrollController.offset <= 0) {
            topPosition = -APP_BAR_HEIGHT;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: widget.backgroundColor,
        floatingActionButton: widget.floatingActionButton,
    body: Stack(
      children: <Widget>[
         Container(
              height: APP_BAR_HEIGHT,
              color: PRIMARY_RED,
            ),
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          controller: _scrollController,
          children: <Widget>[
            Container(
              color: PRIMARY_RED,
              child: widget.extendedAppBar,
            ),
            const VerticalSpace(25),
            widget.body,
          ],
        ),
        Positioned(
          top: topPosition,
          left: 0,
          right: 0,
          child: Container(
            height: APP_BAR_HEIGHT,
            padding: const EdgeInsets.only(left: 20, top: 25.0, right: 20.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PRIMARY_RED.withOpacity(_getOpacity()),
            ),
            child: widget.appBar,
          ),
        ),
        SizedBox(
          height: APP_BAR_HEIGHT,
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    ));
  }
}
