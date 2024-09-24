import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonalPageState();
  }
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
              child: Text("PersonalPage"),
            )));
  }
}
