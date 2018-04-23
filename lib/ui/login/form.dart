import 'package:flutter/material.dart';
import './inputfields.dart';

class FormContainer extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  FormContainer({this.passwordController, this.usernameController});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new InputFieldArea(
                  controller: usernameController,
                  hint: "Username",
                  obscure: false,
                  icon: Icons.person_outline,
                ),
                new InputFieldArea(
                  controller: passwordController,
                  hint: "Password",
                  obscure: true,
                  icon: Icons.lock_outline,
                ),
              ],
            ),),
        ],
      ),
    ));
  }
}