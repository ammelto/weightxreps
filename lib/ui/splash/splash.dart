import 'package:flutter/material.dart';
import 'package:kinoweights/data/entities/user.dart';
import 'package:kinoweights/data/providers/userprovider.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  Splash({Key key, this.color}) : super(key: key);
  final Color color;
  @override
  _Logs createState() => new _Logs();
}

class _Logs extends State<Splash> with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    getUser().then((user){
      if(user.name == null){
        setState(() {
          Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
        });
      }else{
        Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(

      )
    );
  }

  Future<User> getUser() async{
    UserProvider userProvider = new UserProvider();
    User user;
    await userProvider.open();
    user = await userProvider.query(UserProvider.columnId, "0");
    await userProvider.close();
    if(user == null) user = User();
    return user;
  }
}