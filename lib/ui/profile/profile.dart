// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/contacts';

  @override
  ProfileState createState() => new ProfileState();
}

class ProfileState extends State<Profile> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        platform: Theme.of(context).platform,
      ),
      child: new Scaffold(
        key: _scaffoldKey,
        body: new CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              expandedHeight: _appBarHeight,
              pinned: true,
              flexibleSpace: new FlexibleSpaceBar(
                title: const Text('Seamoss'),
                background: new Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new Image.network(
                      'https://cdn.pixabay.com/photo/2013/07/12/17/47/test-pattern-152459_1280.png',
                      fit: BoxFit.cover,
                      height: _appBarHeight,
                    ),
                    // This gradient ensures that the toolbar icons are distinct
                    // against the background image.
                    const DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: const LinearGradient(
                          begin: const Alignment(0.0, -1.0),
                          end: const Alignment(0.0, -0.4),
                          colors: const <Color>[const Color(0x60000000), const Color(0x00000000)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
                new Container(
                  height: 6000.0,
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}