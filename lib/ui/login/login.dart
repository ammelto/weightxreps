import 'package:flutter/material.dart';
import 'styles.dart';
import 'loginAnimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'form.dart';
import 'signinbutton.dart';
import 'signuplink.dart';
import 'logo.dart';
import 'title.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:kinoweights/data/api/weightxreps.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  var animationStatus = 0;
  final TextEditingController userController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  var communityApi = new CommunityApi();
  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Are you sure?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, "/home"),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
    false;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    _loginButtonController.addStatusListener((status){
      print("Status = $status");
      if(status == AnimationStatus.dismissed){
        setState(() {
          animationStatus = 0;
        });
      }
    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          resizeToAvoidBottomPadding: false,
          body: new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('res/images/weight_background.jpg'),
                  fit: BoxFit.cover
                ),
              ),
              child: new Container(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        colors: <Color>[
                          const Color.fromRGBO(162, 146, 199, 0.8),
                          const Color.fromRGBO(51, 51, 63, 0.9),
                        ],
                        stops: [0.2, 1.0],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                      )),
                  child: new ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: <Widget>[
                      new Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Logo(
                                  image: new DecorationImage(
                                      image: new AssetImage('res/images/wxr.png'),
                                      fit: BoxFit.contain
                                  )
                              ),
                              new WxrTitle(
                                  image: new DecorationImage(
                                      image: new AssetImage('res/images/title.png'),
                                      fit: BoxFit.contain
                                  )
                              ),
                              new FormContainer(usernameController: userController, passwordController: passController),
                              new SignUp()
                            ],
                          ),
                          animationStatus == 0
                              ? new Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: new InkWell(
                                onTap: () {
                                  setState(() {
                                    animationStatus = 1;
                                    print(userController.text + " " + passController.text);
                                  });
                                },
                                child: new SignIn()),
                          )
                              : new StaggerAnimation(
                                user: userController.text,
                                pass: passController.text,
                                buttonController:
                                _loginButtonController.view,
                          ),
                        ],
                      ),
                    ],
                  ))),
        )));
  }
}