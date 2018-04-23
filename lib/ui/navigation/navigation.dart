
import 'package:flutter/material.dart';
import 'package:kinoweights/ui/feed/feed.dart';
import 'package:kinoweights/ui/logs/logs.dart';
import 'package:kinoweights/ui/rankings/rankings.dart';
import 'package:kinoweights/ui/settings/settings.dart';

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
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;
  
  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.contacts),
        title: 'Community',
        color: Colors.deepPurple,
        vsync: this,
        content: new Feed(color: Colors.deepPurple)
      ),
      new NavigationIconView(
        icon: new Icon(Icons.assignment),
        title: 'Logs',
        color: Colors.deepOrange,
        vsync: this,
        content: new Logs(color: Colors.deepOrange)
      ),
      new NavigationIconView(
        icon: const Icon(const IconData(0xe99e, fontFamily: 'icomoon')),
        title: 'Personal Records',
        color: Colors.pink,
        vsync: this,
        content: new Rankings(color: Colors.pink)
      ),
      new NavigationIconView(
        icon: const Icon(Icons.settings),
        title: 'Settings',
        color: Colors.green,
        vsync: this,
        content: new Settings(color: Colors.green)
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
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: _navigationViews[_currentIndex]._color,
        title: new Text(_navigationViews[_currentIndex]._title),
        automaticallyImplyLeading: false,
        primary: true,
      ),
      body: _navigationViews[_currentIndex]._content,
      bottomNavigationBar: botNavBar,
    );
  }
}