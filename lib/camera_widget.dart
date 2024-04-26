// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// import 'package:camera_platform_interface/camera_platform_interface.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class CameraWidget extends StatefulWidget {
//   final Function(Uint8List) onImageChange;
//   final List<CameraDescription> cameras;
//   const CameraWidget({super.key, required this.onImageChange, required this.cameras});

//   @override
//   // ignore: library_private_types_in_public_api
//   _CameraWidgetState createState() => _CameraWidgetState();
// }

// class _CameraWidgetState extends State<CameraWidget> {
//   late CameraController _controller;
   
//   Future<void> _initializeControllerFuture = Future.value();
  
//   @override
//   void initState(){
//     super.initState();
//     print("BEFORE CAMERA INITIALIZATION");
//     _initializeCamera(widget.cameras[0]);
//     print("AFTER CAMERA INITIALIZATION");
//   }
  
//   Future<void> _initializeCamera(CameraDescription cameraDescription) async {
//     WidgetsFlutterBinding.ensureInitialized();
//     print("BEFORE AVALABLE CAMERAS");
//      //final cameras = await availableCameras();
//      //print("cameras $cameras");
//      //final firstCamera =  cameras.first;
//       _controller =  CameraController(
//       cameraDescription,
//       ResolutionPreset.medium,
//     );
//       _initializeControllerFuture =  _controller.initialize();
//       print("AFTER CONTROLLER INITIALIZATION");
//       await _controller.initialize();
//      setState(() {});
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _takePicture() async {
//     try {
//       //await _initializeCamera();
//       await _initializeControllerFuture;
//       final image = await _controller.takePicture();
//       // Do something with the captured image
//       print('Image path: ${image.path}');
//       widget.onImageChange(Uint8List.fromList(await File(image.path).readAsBytes()));
//       showDialog(
//         // ignore: use_build_context_synchronously
//         context: context,
//         builder: (context) => AlertDialog(
//           content: Image.file(File(image.path)),
//         ),
//       );
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     //  if (!_controller.value.isInitialized) {
//     //   return Center(child: CircularProgressIndicator());
//     // }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Camera Example"),
//       ),
//       // body:  
//       //  FutureBuilder<void>(
//       //   future: _initializeControllerFuture,
//       //   builder: (context, snapshot) {
//       //     if (snapshot.connectionState == ConnectionState.done) {
//       //       return CameraPreview(_controller);
//       //     } else {
//       //       return Center(child: CircularProgressIndicator());
//       //     }
//       //   },
//       // ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _takePicture,
//         child: const Icon(Icons.camera),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraWidget extends StatefulWidget {
  final Function(Uint8List) onImageChange;
  const CameraWidget({super.key, required this.onImageChange});

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {

  late CameraController _controller ;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;
  

  @override
  void initState(){
     WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    // _controller = CameraController(_cameras[0], ResolutionPreset.max);
     _initializeCamera();
  }
  
  Future<void> _initializeCamera() async {
    // WidgetsFlutterBinding.ensureInitialized();
    //Future<List<CameraDescription>> cameras = availableCameras();
    final cameras = await availableCameras();
    CameraDescription firstCamera = cameras[0];
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture; // Wait until the controller is initialized
    setState(() {}); // Trigger a rebuild to update the UI
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
    //   final cameras = await availableCameras();
    //   CameraDescription firstCamera = cameras[0];
    //   _controller = CameraController(
    //     firstCamera,
    //     ResolutionPreset.medium,
    // );
    // // _initializeControllerFuture = _controller.initialize();
    // // await _initializeControllerFuture; // Wait until the controller is initialized
    // // setState(() {});
    //   await _initializeCamera();
       await _initializeControllerFuture;
      final image = await _controller.takePicture();
      // Do something with the captured image
      print('Image path: ${image.path}');
      widget.onImageChange(Uint8List.fromList(await File(image.path).readAsBytes()));
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Image.file(File(image.path)),
        ),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    // if (!_controller.value.isInitialized) {
    //   // Camera is not initialized yet, show a loading indicator
    //   return Center(child: CircularProgressIndicator());
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera Example"),
      ),
      //body: CameraPreview(_controller),
      floatingActionButton: FloatingActionButton(
        onPressed:()async{
          
          await _initializeCamera();
          await _initializeControllerFuture;
          await  _takePicture();
          final capImage = await _controller.takePicture();
          widget.onImageChange(Uint8List.fromList(await File(capImage.path).readAsBytes()));

        } ,
        child: Icon(Icons.camera),
      ),
    );
  }
}




// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// import 'package:camera_platform_interface/camera_platform_interface.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:photo_mananer/main.dart';

// class CameraWidget extends StatefulWidget {
//   final Function(Uint8List) onImageChange;
//   //final List<CameraDescription> cameras;
//   const CameraWidget({super.key, required this.onImageChange});

//   @override
//   // ignore: library_private_types_in_public_api
//   _CameraWidgetState createState() => _CameraWidgetState();
// }

// class _CameraWidgetState extends State<CameraWidget> {
//   List<CameraDescription> _cameras = <CameraDescription>[];
//   int _cameraIndex = 0;
//   int _cameraId = -1;
//   bool _initialized = false;

//   bool _recording = false;
//   bool _recordingTimed = false;
//   bool _previewPaused = false;

//    Size? _previewSize;
//   MediaSettings _mediaSettings = const MediaSettings(
//     resolutionPreset: ResolutionPreset.low,
//     fps: 15,
//     videoBitrate: 200000,
//     audioBitrate: 32000,
//     enableAudio: true,
//   );
//   StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;
//   StreamSubscription<CameraClosingEvent>? _cameraClosingStreamSubscription;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsFlutterBinding.ensureInitialized();
//     _fetchCameras();
//   }
  
//   @override
//   void dispose() {
//     _disposeCurrentCamera();
//     // _errorStreamSubscription?.cancel();
//     // _errorStreamSubscription = null;
//     // _cameraClosingStreamSubscription?.cancel();
//     // _cameraClosingStreamSubscription = null;
//     super.dispose();
//   }

//   Future<void> _fetchCameras() async {
//     String cameraInfo;
//     List<CameraDescription> cameras = <CameraDescription>[];

//     int cameraIndex = 0;
//     try {
//       cameras = await CameraPlatform.instance.availableCameras();
//       if (cameras.isEmpty) {
//         cameraInfo = 'No available cameras';
//       } else {
//         cameraIndex = _cameraIndex % cameras.length;
//         cameraInfo = 'Found camera: ${cameras[cameraIndex].name}';
//       }
//     } on PlatformException catch (e) {
//       cameraInfo = 'Failed to get cameras: ${e.code}: ${e.message}';
//     }

//     if (mounted) {
//       setState(() {
//         _cameraIndex = cameraIndex;
//         _cameras = cameras;
//         //_cameraInfo = cameraInfo;
//       });
//     }
//   }

//   Future<void> _initializeCamera() async {
//     assert(!_initialized);

//     if (_cameras.isEmpty) {
//       return;
//     }

//     int cameraId = -1;
//     try {
//       final int cameraIndex = _cameraIndex % _cameras.length;
//       final CameraDescription camera = _cameras[cameraIndex];

//       cameraId = await CameraPlatform.instance.createCameraWithSettings(
//         camera,
//         _mediaSettings,
//       );

//       unawaited(_errorStreamSubscription?.cancel());
//       _errorStreamSubscription = CameraPlatform.instance
//           .onCameraError(cameraId)
//           .listen(_onCameraError);

//       unawaited(_cameraClosingStreamSubscription?.cancel());
//       _cameraClosingStreamSubscription = CameraPlatform.instance
//           .onCameraClosing(cameraId)
//           .listen(_onCameraClosing);

//       final Future<CameraInitializedEvent> initialized =
//           CameraPlatform.instance.onCameraInitialized(cameraId).first;

//       await CameraPlatform.instance.initializeCamera(
//         cameraId,
//       );

//       final CameraInitializedEvent event = await initialized;
//       _previewSize = Size(
//         event.previewWidth,
//         event.previewHeight,
//       );

//       if (mounted) {
//         setState(() {
//           _initialized = true;
//           _cameraId = cameraId;
//           _cameraIndex = cameraIndex;
//           //_cameraInfo = 'Capturing camera: ${camera.name}';
//         });
//       }
//     } on CameraException catch (e) {
//       try {
//         if (cameraId >= 0) {
//           await CameraPlatform.instance.dispose(cameraId);
//         }
//       } on CameraException catch (e) {
//         debugPrint('Failed to dispose camera: ${e.code}: ${e.description}');
//       }

//       // Reset state.
//       if (mounted) {
//         setState(() {
//           _initialized = false;
//           _cameraId = -1;
//           _cameraIndex = 0;
//           _previewSize = null;
//           _recording = false;
//           _recordingTimed = false;
//          // _cameraInfo ='Failed to initialize camera: ${e.code}: ${e.description}';
//         });
//       }
//     }
//   }

//   Future<void> _disposeCurrentCamera() async {
//     if (_cameraId >= 0 && _initialized) {
//       try {
//         await CameraPlatform.instance.dispose(_cameraId);

//         if (mounted) {
//           setState(() {
//             _initialized = false;
//             _cameraId = -1;
//             // _previewSize = null;
//             // _recording = false;
//             // _recordingTimed = false;
//             // _previewPaused = false;
//             // _cameraInfo = 'Camera disposed';
//           });
//         }
//       } on CameraException catch (e) {
//         if (mounted) {
//           setState(() {
//            // _cameraInfo ='Failed to dispose camera: ${e.code}: ${e.description}';
//           });
//         }
//       }
//     }
//   }

//   Widget _buildPreview() {
//     return CameraPlatform.instance.buildPreview(_cameraId);
//   }
//   Future<void> _takePicture() async {
//     final XFile file = await CameraPlatform.instance.takePicture(_cameraId);
//     _showInSnackBar('Picture captured to: ${file.path}');
//     await widget.onImageChange(file as Uint8List);
//     Navigator.pop(context);
//     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//   }

//   void _onCameraError(CameraErrorEvent event) {
//     if (mounted) {
//       _scaffoldMessengerKey.currentState?.showSnackBar(
//           SnackBar(content: Text('Error: ${event.description}')));

//       // Dispose camera on camera error as it can not be used anymore.
//       _disposeCurrentCamera();
//       _fetchCameras();
//     }
//   }

//   void _onCameraClosing(CameraClosingEvent event) {
//     if (mounted) {
//       _showInSnackBar('Camera is closing');
//     }
//   }
//  void _showInSnackBar(String message) {
//     _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       content: Text(message),
//       duration: const Duration(seconds: 1),
//     ));
//   }

//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>();


//   @override
//   Widget build(BuildContext context) {
//     return(
//       // MaterialApp(
//       //   scaffoldMessengerKey: _scaffoldMessengerKey,
//       //   home: 
//        Scaffold(
//           body: Row(children: [
//                   ElevatedButton(
//                     onPressed: _initialized
//                         ? _disposeCurrentCamera
//                         : _initializeCamera,
//                     child:
//                         Text(_initialized ? 'Dispose camera' : 'Create camera'),
//                   ),
//                   const SizedBox(width: 5),
//                   ElevatedButton(
//                     onPressed: _initialized ? _takePicture : null,
//                     child: const Text('Take picture'),
//                   ),
//           ],),
//         )
//          );
//     // );
//   }
// }