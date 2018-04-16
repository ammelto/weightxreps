// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:kinoweights/ui/navigation/navigation.dart';

void main() {
  runApp(new KinoWeightsApp());
}

class KinoWeightsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'KinoWeights',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new BottomNavigation(),
    );
  }
}