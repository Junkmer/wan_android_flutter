import 'package:flutter/material.dart';

class HotKeyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HotKeyPageState();
  }
}

class _HotKeyPageState extends State<HotKeyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Text("HotKey"),
    )));
  }
}
