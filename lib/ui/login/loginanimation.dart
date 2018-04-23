import 'package:flutter/material.dart';
import 'package:kinoweights/data/api/weightxreps.dart';
import 'dart:async';

class StaggerAnimation extends StatelessWidget {
  final communityApi = new CommunityApi();
  StaggerAnimation({Key key, this.buttonController, this.user, this.pass})
      : buttonSqueezeanimation = new Tween(
    begin: 320.0,
    end: 70.0,
  )
      .animate(
    new CurvedAnimation(
      parent: buttonController,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ),
  ),
        buttomZoomOut = new Tween(
          begin: 70.0,
          end: 70.0,
        )
            .animate(
          new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(
              0.550,
              0.999,
              curve: Curves.bounceOut,
            ),
          ),
        ),
        containerCircleAnimation = new EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 50.0),
          end: const EdgeInsets.only(bottom: 0.0),
        )
            .animate(
          new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController buttonController;
  final String user;
  final String pass;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeanimation;
  final Animation buttomZoomOut;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return new Padding(
      padding: buttomZoomOut.value == 70
          ? const EdgeInsets.only(bottom: 50.0)
          : containerCircleAnimation.value,
      child: new InkWell(
          child: new Hero(
            tag: "fade",
            child: buttomZoomOut.value <= 300
                ? new Container(
                width: buttomZoomOut.value == 70
                    ? buttonSqueezeanimation.value
                    : buttomZoomOut.value,
                height:
                buttomZoomOut.value == 70 ? 60.0 : buttomZoomOut.value,
                alignment: FractionalOffset.center,
                decoration: new BoxDecoration(
                  color: const Color.fromRGBO(247, 64, 106, 1.0),
                  borderRadius: buttomZoomOut.value < 400
                      ? new BorderRadius.all(const Radius.circular(30.0))
                      : new BorderRadius.all(const Radius.circular(0.0)),
                ),
                child: buttonSqueezeanimation.value > 75.0
                    ? new Text(
                  "Sign In",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.3,
                  ),
                )
                    : buttomZoomOut.value < 300.0
                    ? new CircularProgressIndicator(
                  value: null,
                  strokeWidth: 1.0,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.white),
                )
                    : null)
                : new Container(
              width: buttomZoomOut.value,
              height: buttomZoomOut.value,
              decoration: new BoxDecoration(
                shape: buttomZoomOut.value < 500
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                color: const Color.fromRGBO(247, 64, 106, 1.0),
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    buttonController.forward();
    buttonController.addListener(() {
      print("VAL $buttomZoomOut");
      if(buttomZoomOut.isCompleted && buttonController.status != AnimationStatus.reverse){
        buttonController.stop(canceled: false);
        communityApi.login(user, pass).then((bool isSuccess) {
          if(isSuccess){
            buttonController.forward();
            Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
          }else{
            buttonController.reverse();
          }
        });
      }
    });
    return new AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }

  Future<Null> playReverse() async {
    try {
      await buttonController.reverse();
    } on TickerCanceled {}
  }
}