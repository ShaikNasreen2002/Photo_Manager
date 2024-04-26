
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';

class CameraPage extends StatefulWidget {
  final Function(Uint8List) onImageChange;
  const CameraPage({super.key, required this.onImageChange});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterCamera(
      color: Colors.amber,
      onImageCaptured: (value) async {
        final XFile imageFile = value;
        final Uint8List imageData = await imageFile.readAsBytes();
        print('imageData: $imageFile');
        await widget.onImageChange(imageData);
        
      },
      
    );
  }
}