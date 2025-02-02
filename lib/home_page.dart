import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceModel = 'Loading...';
  String osVersion = 'Loading...';

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  Future<void> getDeviceInfo() async {
    try{
      if(Platform.isAndroid){
        final androidInfo = await deviceInfo.androidInfo;
        setState(() {
          deviceModel = androidInfo.model;
          osVersion = 'Android ${androidInfo.version.release}';
        });
      } else if(Platform.isIOS){
        final iosInfo = await deviceInfo.iosInfo;
        setState(() {
          deviceModel = iosInfo.model;
          osVersion = '${iosInfo.systemName} ${iosInfo.systemVersion}';
        });
      }
    } catch(e) {
      if(mounted){
        setState(() {
          deviceModel = 'Error: ${e.toString()}';
          osVersion = 'Error getting OS version';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Device Information", style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Text(
                'Device Model: $deviceModel',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: Text(
                'OS Version: $osVersion',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      )
    );
  }
}
