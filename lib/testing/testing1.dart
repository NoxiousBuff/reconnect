import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickPage extends StatefulWidget {
  @override
  _PickPageState createState() => _PickPageState();
}

class _PickPageState extends State<PickPage> {
  File _image;
  File _imageGallery;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getGallery() async {
    final pickedFileGallery =
        await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFileGallery != null) {
        _imageGallery = File(pickedFileGallery.path);
      } else {
        print('No image from Gallery is selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PickImage'),
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(Icons.sd_storage_outlined), onPressed: getGallery)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.camera_alt_outlined),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: _image != null
                  ? Image.file(
                      _image,
                      fit: BoxFit.cover,
                    )
                  : Text('Image is not working'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: _imageGallery != null
                  ? Image.file(
                      _imageGallery,
                      fit: BoxFit.cover,
                    )
                  : Text('ImageGallery is not working'),
            ),
          ),
        ],
      ),
    );
  }
}