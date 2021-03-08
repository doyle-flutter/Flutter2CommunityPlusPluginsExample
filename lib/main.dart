import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:newflutter/AlarmConfig.dart';
import 'package:newflutter/AlarmFunc.dart';
import 'package:newflutter/ConnectivityFunc.dart';
import 'package:newflutter/NetworkInfoFunc.dart';
import 'package:newflutter/PackageInfoFunc.dart';
import 'package:newflutter/ShareFunc.dart';
import 'DeviceInfoPlusFunc.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid){
    IsolateNameServer.registerPortWithName(
      AlarmConfig.port.sendPort,
      AlarmConfig.isolateName,
    );
  }
  return runApp(MaterialApp(home: MainApp(),));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plus Packages"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ConnectivityFunc(),
              DeviceInfoPlusFunc(),
              NetworkInfoFunc(),
              PackageInfoFunc(),
              ShareFunc(),
              AlarmFunc()
            ],
          ),
        ),
      ),
    );
  }
}



