import 'package:flutter/material.dart';
import 'package:kinoweights/data/api/weightxreps.dart';
import 'dart:async';

class StaggerAnimation extends StatelessWidget {
  final communityApi = new CommunityApi();
  StaggerAnimation({Key key, this.buttonController, this.user, this.pass})
      : buttonSqueezeAnimation = new Tween(
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
        buttonZoomOut = new Tween(
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
  final Animation buttonSqueezeAnimation;
  final Animation buttonZoomOut;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return new Padding(
      padding: buttonZoomOut.value == 70
          ? const EdgeInsets.only(bottom: 50.0)
          : containerCircleAnimation.value,
      child: new InkWell(
          child: new Hero(
            tag: "fade",
            child: buttonZoomOut.value <= 300
                ? new Container(
                width: buttonZoomOut.value == 70
                    ? buttonSqueezeAnimation.value
                    : buttonZoomOut.value,
                height:
                buttonZoomOut.value == 70 ? 60.0 : buttonZoomOut.value,
                alignment: FractionalOffset.center,
                decoration: new BoxDecoration(
                  color: const Color.fromRGBO(247, 64, 106, 1.0),
                  borderRadius: buttonZoomOut.value < 400
                      ? new BorderRadius.all(const Radius.circular(30.0))
                      : new BorderRadius.all(const Radius.circular(0.0)),
                ),
                child: buttonSqueezeAnimation.value > 75.0
                    ? new Text(
                  "Sign In",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.3,
                  ),
                )
                    : buttonZoomOut.value < 300.0
                    ? new CircularProgressIndicator(
                  value: null,
                  strokeWidth: 1.0,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.white),
                )
                    : null)
                : new Container(
              width: buttonZoomOut.value,
              height: buttonZoomOut.value,
              decoration: new BoxDecoration(
                shape: buttonZoomOut.value < 500
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
      print("VAL $buttonZoomOut");
      if(buttonZoomOut.isCompleted && buttonController.status != AnimationStatus.reverse){
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