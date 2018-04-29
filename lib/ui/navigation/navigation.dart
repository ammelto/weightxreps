
import 'package:flutter/material.dart';
import 'package:kinoweights/ui/feed/feed.dart';
import 'package:kinoweights/ui/logs/logs.dart';
import 'package:kinoweights/ui/rankings/rankings.dart';
import 'package:kinoweights/ui/profile/profile.dart';
import 'package:flutter/foundation.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    String title,
    Color color,
    TickerProvider vsync,
    Widget content
  }) : _icon = icon,
        _color = color,
        _title = title,
        _content = content,
        item = new BottomNavigationBarItem(
          icon: icon,
          title: new Text(title),
          backgroundColor: color,
        ),
        controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final Widget _icon;
  final Color _color;
  final String _title;
  final Widget _content;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition(BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate(_animation),
        child: new IconTheme(
          data: new IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: new Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  static const String routeName = '/material/bottom_navigation';

  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _hideNav = false;
  List<NavigationIconView> _navigationViews;
  Animation<double> animationSize;
  Animation<double> animationFade;
  Animation<Offset> animationTransition;
  AnimationController sizeController;
  AnimationController fadeController;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    sizeController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 200));
    fadeController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 150));

    animationTransition = new Tween(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
        new CurvedAnimation(
          parent: sizeController,
          curve: Curves.ease,
    ));

    animationSize = new CurvedAnimation(parent: sizeController, curve: Curves.easeInOut);
    animationFade = new CurvedAnimation(parent: fadeController, curve: Curves.linear);

    sizeController.forward();
    fadeController.forward();
    scrollController = new ScrollController()..addListener((){
      print(scrollController.position.userScrollDirection.toString());
      if(scrollController.position.userScrollDirection.toString() == "ScrollDirection.reverse"){
        if(!_hideNav){
          setState(() {
            _hideNav = true;
            fadeController.reverse().then((_){
              sizeController.reverse();
            });
          });
        }
      }else if(scrollController.position.userScrollDirection.toString() == "ScrollDirection.forward"){
        if(_hideNav){
          setState(() {
            _hideNav = false;
            sizeController.forward().then((_){
              fadeController.forward();
            });
          });
        }
      }
    });
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.contacts),
        title: 'Community',
        color: Colors.deepPurple,
        vsync: this,
        content: new Feed(color: Colors.deepPurple, scrollController: scrollController)
      ),
      new NavigationIconView(
        icon: new Icon(Icons.assignment),
        title: 'Logs',
        color: Colors.deepOrange,
        vsync: this,
        content: new Logs()
      ),
      new NavigationIconView(
        icon: const Icon(const IconData(0xe99e, fontFamily: 'icomoon')),
        title: 'Records',
        color: Colors.pink,
        vsync: this,
        content: new Rankings(color: Colors.pink)
      ),
      new NavigationIconView(
        icon: const Icon(Icons.account_circle),
        title: 'Profile',
        color: Colors.green,
        vsync: this,
        content: new Profile()
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  @override
  Widget build(BuildContext context) {

    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      body: _navigationViews[_currentIndex]._content,
      bottomNavigationBar: new SizeTransition(
            sizeFactor: animationSize,
            child: new FadeTransition(opacity: animationFade, child: botNavBar,)
        ),
    );
  }

}