import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityFunc extends StatefulWidget {
  @override
  _ConnectivityFuncState createState() => _ConnectivityFuncState();
}

class _ConnectivityFuncState extends State<ConnectivityFunc> {
  final Connectivity _connectivity = Connectivity();
  bool check = false;
  @override
  void initState() {
    Future(() async{
      ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();
      // 연결에 변화가 생기는지 확인하여 변경합니다(addEventListener)
      _connectivity.onConnectivityChanged.listen((ConnectivityResult event) {
        if(event == ConnectivityResult.none){
          setState(() {
            this.check = false;
          });
        }else{
          setState(() {
            this.check = true;
          });
        }
      });
      if (connectivityResult == ConnectivityResult.mobile
       || connectivityResult == ConnectivityResult.wifi) {
        setState(() {
          this.check = true;
        });
      }
      if(connectivityResult == ConnectivityResult.none){
        setState(() {
          this.check = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Icon(Icons.wifi,
        color: this.check ? Colors.blue : Colors.red,
      ),
    );
  }
}
