import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeviceInfoPlusFunc extends StatefulWidget {
  @override
  _DeviceInfoPlusFuncState createState() => _DeviceInfoPlusFuncState();
}

class _DeviceInfoPlusFuncState extends State<DeviceInfoPlusFunc> {

  String? info;

  @override
  void initState() {
    Future(this._check);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.all(20.0),
    child: Text("[ DeviceInfoPlus ]\n${info??'Loading...'}"),
  );

  Future<void> _check() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo.catchError((err) => AndroidDeviceInfo.fromMap({'model':"NULL AND"}), test: (obj) => true);
      print('Running on AND : ${androidInfo.model}');  // e.g. "Moto G (4)"
      setState(() {
        this.info = 'Running on AND : ${androidInfo.model ?? "AND Model Not Found"}';
      });
    }
    if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo.catchError((err) => IosDeviceInfo.fromMap({"utsname":{"machine":"NULL IOS"}}), test: (obj) => true);
      print('Running on IOS : ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
      setState(() {
        this.info = 'Running on IOS : ${iosInfo.utsname.machine ?? "IOS Model Not Found"}';
      });
    }
    if(kIsWeb){
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo.catchError((err) => WebBrowserInfo.fromMap({"userAgent":"NULL WEB"}), test: (obj) => true);
      print('Running on WEB : ${webBrowserInfo.userAgent}');  // e.g. "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"
      setState(() {
        this.info = 'Running on WEB : ${webBrowserInfo.userAgent}'; // Non-nullable 으로 제안하므로 기본 값이 있는 것으로 간주하고 사용
      });
    }
    return;
  }
}
