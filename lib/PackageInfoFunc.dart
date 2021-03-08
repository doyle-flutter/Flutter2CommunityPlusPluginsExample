import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoFunc extends StatefulWidget {
  @override
  _PackageInfoFuncState createState() => _PackageInfoFuncState();
}

class _PackageInfoFuncState extends State<PackageInfoFunc> {
  @override
  void initState() {
    Future(_init);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Text("""
      AppName : ${this.appName ?? "Load..."}
      PackageName : ${this.packageName ?? "Load..."}
      Version : ${this.version ?? "Load..."}
      BuildNumber : ${this.buildNumber ?? "Load..."}
      """),
    );
  }

  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;

  Future<void> _init() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
    return;
  }
}
