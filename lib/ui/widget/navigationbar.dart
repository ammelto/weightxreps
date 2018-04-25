import 'package:flutter/material.dart';

class NavigationBar extends BottomNavigationBar {
  NavigationBar({Key key, this.currentIndex}): super(
    items: _navigationViews
        .map((NavigationIconView navigationView) => navigationView.item)
        .toList(),
    currentIndex: currentIndex,
    type: BottomNavigationBarType.shifting,
    onTap: (int index) {

    },
  );

  final int currentIndex;
  
}