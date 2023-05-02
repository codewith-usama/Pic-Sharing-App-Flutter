import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<File> _selectedImages = [];

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      setState(() {
        _selectedImages.add(imageFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Picture Sharing App'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _selectedImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.66,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.66,
                    margin: const EdgeInsets.all(8.0),
                    child: Image.file(
                      _selectedImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Container(
                color: Colors.deepPurple,
                child: TextButton(
                  onPressed: _pickImage,
                  child: const Text(
                    'Upload Pic',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}