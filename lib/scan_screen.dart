import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  // XFile? pictureFile;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              height: 600,
              width: 400,
              child: CameraPreview(controller),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ))),
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.rightSlide,
                      title: 'Card-kaan Waa mid Sax Ah 👍',
                      // desc: '',
                      // btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    )..show();
                  },
                  child: Icon(
                    CupertinoIcons.check_mark,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
            SizedBox(
              width: 50,
            ),
            Container(
              height: 60,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ))),
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: "Card-kaan Ma'ahn mid Jira !! 🙅‍♂️",
                      // desc: '',
                      btnCancelText: 'OK',
                      btnCancelOnPress: () {},
                      // btnOkOnPress: () {},
                    )..show();
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: 30,
                  )),
            )
          ],
        )
        //Android/iOS
        // Image.file(File(pictureFile!.path)))
      ],
    );
  }
}
