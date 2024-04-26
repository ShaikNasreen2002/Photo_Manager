import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_mananer/camera_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:photo_mananer/camera_widget.dart';


// ignore: prefer_typing_uninitialized_variables
late var image;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    print("MyApp started");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Photo Manager'),centerTitle: true,backgroundColor: Colors.blue[100],
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
  ],
        ),
      body:  HomePage(),
      ),
    );
  }
  

}

class ImageItem {
  late Uint8List image;
  late int id;
  late String name;
  late bool isChecked;
  final TextEditingController nameController;
  

  ImageItem({
    required this.id,
    required this.image,
    required this.name,
    required this.isChecked,
    required this.nameController,
  });
  
}
class HomePage extends StatefulWidget {
  
  HomePage({super.key}){
    print("Home Page");
  }
  
  @override 
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<ImageItem> imageData = [];
  bool isVisible = false;
  int indexOfDisplayImage = 0;
  final List<int> deleteIndexList = [];
  
  
  void onImageAdd(Uint8List image) {
  final nameController = TextEditingController();
  nameController.text = "Image ${imageData.length + 1}";
  setState(() {
    imageData.add(ImageItem(
      id: imageData.length,
      image: image,
      name: "Image ${imageData.length + 1}",
      isChecked: false,
      nameController: nameController, 
    ));
    //viewedImage = imageData[0].image;
  });
}

  Future<void> onDelete() async{
    setState(() {
      imageData.removeWhere((item)=> item.isChecked);
    });
    showAdaptiveDialog(context: context,
     builder: (context){
      return const Dialog(child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(textAlign: TextAlign.center,"Items are deleted permanently"),
      ),
      );
     });
    Future.delayed(const Duration(seconds: 3),(){
        Navigator.pop(context);
      } );
  }
  @override
  Widget build(BuildContext context) {
    //print(_images);
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          //padding: const EdgeInsets.all(8.0),
                          controller: ScrollController(),
                          shrinkWrap: true,
                          key: _listKey,
                          itemCount: imageData.length,
                          itemBuilder: (context, index) {
                                index = index;
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Flexible(
                                        child: GestureDetector(
                                          onDoubleTap: (){
                                            setState(() {
                                              isVisible=!isVisible;
                                      
                                            });
                                            print("index $index");
                                          },
                                          child: Stack(
                                            children: [
                                              GestureDetector(onTap: () {
                                                    print("Image Clicked");
                                                    
                                                    setState(() {
                                                      indexOfDisplayImage = index;
                                                    });
                                                    //_viewImage(index);
                                                  },child: Image.memory(imageData[index].image)),
                                              Positioned(
                                                top: 0,
                                                left: 0,
                                                child: isVisible ?  Checkbox(hoverColor: const Color.fromARGB(255, 164, 110, 91) , focusColor: Colors.blue,value: imageData[index].isChecked,onChanged: (value){
                                                    print(value);
                                                    setState(() {
                                                      imageData[index].isChecked = !imageData[index].isChecked;
                                                      print(imageData[index].isChecked);
                                                    });
                                                    
                                                    if(imageData[index].isChecked){
                                                      setState(() {
                                                        deleteIndexList.add(index);
                                                      });
                                                      
                                                      
                                                    }
                                                    else if(!imageData[index].isChecked) {
                                                      setState(() {
                                                        deleteIndexList.remove(index);
                                                      });
                                                      
                                                    }                     
                                                    print('deleteIndexList: $deleteIndexList');
                                                },): const Padding(padding: EdgeInsets.zero),
                                              // ignore: dead_code
                                              ),
                                                          
                                            ],
                                          ),
                                          ),
                                      ),
                                     
                                       SizedBox(
                                        width:100,
                                        height: 20,
                                         child: TextField(
                                                showCursor: true,
                                                style: const TextStyle(color: Colors.black,fontSize: 15),
                                                textAlign: TextAlign.center,
                                                controller: imageData[index].nameController,
                                                enabled: true,
                                                onChanged: (value) {
                                                  print(value);
                                                  imageData[index].nameController.text = value;
                                                },
                                                autofocus: true,
                                                
                                              ),
                                       )
                                    ],
                                  ),
                                );
                                
                            }
                                    ),
                      ],
                    ),
                  ),
                ),
                 Expanded(
                  child: Container(
                    width:double.infinity,
                    color: const Color.fromARGB(255, 227, 240, 250),
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      heightFactor: 0.7,
                      child: (imageData.isNotEmpty && indexOfDisplayImage < imageData.length)? Image.memory(imageData[indexOfDisplayImage].image) : const Center(child: Text("NO IMAGE DATA IS ENTERED") ),))
                 )
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                iconSize: 45.0,
                tooltip: "Capture Image",
                onPressed: () async{
                  WidgetsFlutterBinding.ensureInitialized();
                  if(!kIsWeb && Platform.isWindows){
                    // final cameras = await availableCameras();c
                    // print("cameras $cameras");
                    // await availableCameras().then(
                    //   (value) => Navigator.push(
                    //     context, MaterialPageRoute(
                    //     builder: (_) => CameraWidget(onImageChange: onImageAdd,cameras: cameras))
                    //   ),
                    // );
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => CameraWidget(onImageChange: onImageAdd)));
                  }
                  else{
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage(onImageChange: onImageAdd)));
                  }
                  
                  await Future.delayed(const Duration(milliseconds: 5000));
              }, icon: const Icon(Icons.add_a_photo)),
              IconButton(
                tooltip: "Pick Image",
                iconSize: 45.0,
                onPressed: () async{
                  ImagePicker imagePicker = ImagePicker();
                  XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
                  if(image != null){
                    onImageAdd(await image.readAsBytes());
                  }
              },icon: const Icon(Icons.photo_library),),
              isVisible ? IconButton(
                tooltip: "Delete Image",
                icon: const Icon(Icons.delete_outline),
                onPressed: () async{
                  var confirmation = false;
                  for(ImageItem i in imageData){
                    if(i.isChecked){
                      setState(() {
                        deleteIndexList.add(i.id);
                      });  
                    }
                  }
                  if(deleteIndexList.isEmpty){
                    showDialog(context: context, builder: (context){
                      return const AlertDialog(title: Text("NO IMAGE IS SELECTED"));
                    });
                  }else{
                    await showDialog(context: context,
                   builder: (context){
                    return AlertDialog(
                      title: const Text("DELETE CONFIRMATION"),
                      content: const Text("Are you sure you want to delete?"),
                      actions: [
                        TextButton(onPressed: (){
                          confirmation = true;
                          Navigator.of(context).pop();
                          // print(confirmation);
                        }, child: const Text("YES")),
                        TextButton(onPressed: (){
                          confirmation = false;
                           Navigator.of(context).pop();
                          //  print(confirmation);
                        }, child: const Text("NO"),)
                      ]
                    );
                   }
                  );
                  if(confirmation){
                    await onDelete();
                  }
                  else{
                    
                    deleteIndexList.clear();
                  }
                  }
                  
                },
                  
              // ignore: dead_code
              ): const Padding(padding: EdgeInsets.zero),
            ],
          ),
          
        ],
      );
  }
  
  
  
  
}

