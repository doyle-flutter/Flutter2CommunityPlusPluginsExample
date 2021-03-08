import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class NetworkInfoFunc extends StatefulWidget {
  @override
  _NetworkInfoFuncState createState() => _NetworkInfoFuncState();
}

class _NetworkInfoFuncState extends State<NetworkInfoFunc> {
  @override
  void initState() {
    Future(_init).then((_) => setState((){}));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Text("WifiName : ${this.wifiName}\n WifiIP :${this.wifiIP}\n WifiBSSID : ${this.wifiBSSID}"),
    );
  }
  String wifiName = "Load...";
  String wifiIP = "Load...";
  String wifiBSSID = "Load...";
  Future<void> _init() async{
    await Permission.locationAlways.request();
    await Permission.locationWhenInUse.request();
    await Permission.accessMediaLocation.request();
    await Permission.activityRecognition.request();
    wifiName = (await NetworkInfo().getWifiName().catchError(_catchError) ?? "찾을 수 없습니다");
    wifiIP = (await NetworkInfo().getWifiIP().catchError(_catchError) ?? "찾을 수 없습니다");
    wifiBSSID = (await NetworkInfo().getWifiBSSID().catchError(_catchError) ?? "찾을 수 없습니다");
    return;
  }
  String _catchError(dynamic err) => "NONE";
}
