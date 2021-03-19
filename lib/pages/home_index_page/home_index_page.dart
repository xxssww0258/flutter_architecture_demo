import 'package:flutter/material.dart';
import 'package:flutter_architecture_demo/utils/application.dart';

class HomeIndexPage extends StatefulWidget {
  @override
  _HomeIndexPageState createState() => _HomeIndexPageState();
}

class _HomeIndexPageState extends State<HomeIndexPage> {
  var $S = Application.$S;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Center(
          child:Text($S.hello_world)
        )
      )
    );
  }
}