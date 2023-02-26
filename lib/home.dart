import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_reader/scan_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          title: Text("Hubiye",style: TextStyle(fontSize: 18,color:Colors.black45),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(CupertinoIcons.line_horizontal_3_decrease,
              color: Colors.black54),
        ),
        body: Column(children: [
          Expanded(
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
          ),
        ]));
  }
}
