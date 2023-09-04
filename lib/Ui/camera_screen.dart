// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:demo_app/Ui/preview_screen.dart';

class CameraScreen extends StatefulWidget {
  Function callBack;
  CameraScreen({
    Key? key,
    required this.callBack,
  }) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List cameras = [];
  int selectedCameraIndex = 0;
  String imgPath = "";
  bool iscameraInitialized = false;

  Future initCameraController(CameraDescription cameraDescription) async {
    final CameraController? cameraController = controller;
    if (cameraController != null) {
      await cameraController.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    controller?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (controller!.value.hasError) {
      print("Camera error ${controller!.value.errorDescription}");
    }

    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  showCameraException(CameraException e) {
    String errorText = "Error: ${e.code}\n Error Message: ${e.description}";
    print(errorText);
  }

  @override
  void initState() {
    cameraInit();
    super.initState();
  }

  cameraInit() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch (e) {
      print('Error in fetching the cameras: $e');
    }

    if (cameras.length > 0) {
      setState(() {
        selectedCameraIndex = 0;
      });

      initCameraController(cameras[selectedCameraIndex]).then((value) {
        print(value);
      });

      // availableCameras().then((availableCameras) {
      //   cameras = availableCameras;
      //   if (cameras.length > 0) {
      //     setState(() {
      //       selectedCameraIndex = 0;
      //     });

      //     initCameraController(cameras[selectedCameraIndex]).then((value) {
      //       print(value);
      //     });
      //   } else {
      //     print("No Camera Available");
      //   }
      // }).catchError((err) {
      //   print("Error ${err.code}");
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 1, child: cameraPreviewWidget()),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                color: Colors.black,
                child: Row(
                  children: [cameraToggleRowWidget(), cameraControlWidget(context), const Spacer()],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cameraPreviewWidget() {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        "Loading",
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
      );
    }

    return AspectRatio(
      aspectRatio: cameraController.value.aspectRatio,
      child: CameraPreview(cameraController),
    );
  }

  Widget cameraToggleRowWidget() {
    // final CameraController? cameraController = controller;
    if (cameras == null || cameras.isEmpty) {
      return const Spacer();
    }
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;
    return Expanded(
        child: Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: Icon(getCamerasIcon(lensDirection)),
        onPressed: onSwitchCamera,
        color: Colors.white,
        iconSize: 24,
        // label: Text(
        //     "${lensDirection.toString().substring(lensDirection.toString().indexOf(".") + 1).toUpperCase()}")),
      ),
    ));
  }

  Widget cameraControlWidget(BuildContext context) {
    final CameraController? cameraController = controller;
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            FloatingActionButton(
              onPressed: () {
                onCapturePressed(context);
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.camera,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSwitchCamera() {
    selectedCameraIndex = selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;

    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    initCameraController(selectedCamera);
  }

  Future onCapturePressed(BuildContext context) async {
    final CameraController? cameraController = controller;

    try {
      final path = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

      XFile picture = await cameraController!.takePicture();
      picture.saveTo(path);
      // await cameraController?.takePicture(path);
      print(path);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewScreen(
                    imgPath: path,
                    callBack: (value) {
                      widget.callBack(value);
                    },
                  )));
    } catch (e) {
      print(e);
    }
  }

  IconData? getCamerasIcon(CameraLensDirection lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return CupertinoIcons.switch_camera;
      case CameraLensDirection.front:
        return CupertinoIcons.switch_camera_solid;
      case CameraLensDirection.external:
        return CupertinoIcons.photo_camera;
      default:
        return Icons.device_unknown;
    }
  }
}
