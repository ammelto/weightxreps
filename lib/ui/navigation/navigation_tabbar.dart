
import 'package:flutter/material.dart';
import 'package:kinoweights/ui/feed/feed.dart';
import 'package:kinoweights/ui/logs/logs.dart';
import 'package:kinoweights/ui/rankings/rankings.dart';
import 'package:kinoweights/ui/settings/settings.dart';
import 'package:kinoweights/ui/widget/nonexistentappbar_tabbar.dart';

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
  List<NavigationIconView> _navigationViews;
  Color _currentColor = Colors.deepPurple;
  Tab _currentTab;

  final List<Tab> tabs = [
    new Tab(icon: const Icon(Icons.contacts), text: 'Community'),
    new Tab(icon: const Icon(Icons.assignment), text: 'Logs'),
    new Tab(icon: const Icon(const IconData(0xe99e, fontFamily: 'icomoon')), text: 'Records'),
    new Tab(icon: const Icon(Icons.settings), text: 'Settings')
  ];
  final List<Color> colors = [Colors.deepPurple, Colors.deepOrange, Colors.pink, Colors.green];
  TabController _controller;
  TabBar _tabBar;


  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: tabs.length, vsync: this);
    _currentTab = tabs[0];

    _controller.addListener((){
      setState(() {
        _currentColor = colors[_controller.index];
        _currentTab = tabs[_controller.index];
      });
    });

    _tabBar = new TabBar(
      tabs: tabs,
      controller: _controller,
      indicatorColor: Colors.transparent,
    );

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

    return new Scaffold(
        appBar: new NonexistentAppBar(bottom: _tabBar, color: _currentColor),
        body:  new Container(
          child: getCurrentTab(),
        )
    );
  }

  Widget getCurrentTab(){
    switch(_currentTab.text){
      case 'Community':
        return new Feed(color: Colors.deepPurple);
      case 'Logs':
        return new Logs(color: Colors.deepOrange);
      case 'Records':
        return new Rankings(color: Colors.pink);
      case 'Settings':
        return new Settings(color: Colors.green);
    }
    return new Feed(color: Colors.deepPurple);
  }

}