// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:kinoweights/ui/login/login.dart';
import 'package:kinoweights/ui/navigation/navigation.dart';
import 'package:kinoweights/ui/splash/splash.dart';

void main() {
  new Routes();
}

class Routes {
  Routes() {
    runApp(new MaterialApp(
      title: "Kinoweights",
      theme: new ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.greenAccent,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: new Splash(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
              builder: (_) => new LoginScreen(),
              settings: settings,
            );

          case '/home':
            return new MyCustomRoute(
              builder: (_) => new BottomNavigation(),
              settings: settings,
            );
        }
      },
    ));
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}