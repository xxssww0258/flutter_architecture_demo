import 'package:flutter/material.dart';
import 'package:flutter_architecture_demo/utils/application.dart';
import 'package:provider/provider.dart';

import '../../my_app.dart';
class HomeIndexPage extends StatefulWidget {
  @override
  _HomeIndexPageState createState() => _HomeIndexPageState();
}

class _HomeIndexPageState extends State<HomeIndexPage> {
  var $S = Application.$S;
  var client = Application.client;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Center(
          child:Column(
            children: [
              Text($S.hello_world),
              ElevatedButton(onPressed: (){
              }, child: Text('button'),)
            ],
          )
        )
      )
    );
  }
}