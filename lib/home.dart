import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_reader/scan_screen.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String deviceID = "";
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    await availableCameras().then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPage(
            cameras: value,
          ),
        ),
      ),
    );
    _btnController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Hubiye",
            style: TextStyle(fontSize: 18, color: Colors.black45),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => copyAndShareDeviceID(context),
                icon: Icon(Icons.copy,color: Colors.black,))
          ],
          leading: Icon(CupertinoIcons.line_horizontal_3_decrease,
              color: Colors.black54),
        ),
        body: CustomScrollView(slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.network(
                      "https://assets9.lottiefiles.com/packages/lf20_joborrUseU.json",
                      height: 250,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Scan gareey si aad u Hubiso 🤳',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                // fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: RoundedLoadingButton(
                          borderRadius: 16,
                          child: Text('Scan!',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                          controller: _btnController,
                          onPressed: _doSomething,
                        ))
                  ],
                ),
              ),
            )
          ]))
        ]));
  }

  void copyAndShareDeviceID(BuildContext context) async {
    if (deviceID.isEmpty) deviceID = await PlatformDeviceId.getDeviceId ?? '';
    await Clipboard.setData(ClipboardData(text: deviceID));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Device ID Copied',
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      action: SnackBarAction(
        label: 'Share',
        textColor: Colors.white,
        onPressed: () =>
            Share.share('My Device ID is $deviceID', subject: 'Device ID'),
      ),
    ));
  }
}
