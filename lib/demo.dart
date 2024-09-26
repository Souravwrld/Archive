import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformCheckPage extends StatefulWidget {
  @override
  _PlatformCheckPageState createState() => _PlatformCheckPageState();
}

class _PlatformCheckPageState extends State<PlatformCheckPage> {
  @override
  Widget build(BuildContext context) {
    bool containerColor;
    if (Theme.of(context).platform == TargetPlatform.android) {
      containerColor = true;
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      containerColor = false;
    } else {
      containerColor = false; // Default color for unknown platform
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Platform Check'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: containerColor? Colors.red : Colors.green,
          child: Center(
            child: Text(
              'Device is running on: ${Theme.of(context).platform}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
