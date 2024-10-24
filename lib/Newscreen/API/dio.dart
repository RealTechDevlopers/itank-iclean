import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _image;
  double _uploadProgress = 0.0;
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to upload the image and track upload progress
  Future<void> _uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    Dio dio = Dio();
    String fileName = _image!.path.split('/').last;

    // Prepare formData with file and fields
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(_image!.path, filename: fileName)
    });
    formData.fields.add(MapEntry('action', 'hi mugesh'));
    formData.fields.add(MapEntry('action1', 'hi mugesh1'));
    formData.fields.add(MapEntry('action2', 'hi mugesh2'));

    // Log form data fields
    for (var field in formData.fields) {
      log("FormData Field: ${field.key} = ${field.value}");
    }

    try {
      // Send the request
      Response response = await dio.post(
        'http://devftp.itank.io/test_tamil/image.php', // Replace with your API endpoint
        data: formData,
        options: Options(
          contentType: 'multipart/form-data', // Ensure the content type is multipart/form-data
        ),
        onSendProgress: (int sent, int total) {
          setState(() {
            _uploadProgress = sent / total;
            log("Upload progress: ${(_uploadProgress * 100).toInt()}%");
          });
        },
      );

      // Handle the response
      log("Response: ${response.data}");
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload')),
        );
      }
    } catch (e) {
      log('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image with Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image != null
                  ? Image.file(
                _image!,
                height: 200,
              )
                  : Text('No image selected.'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20),
              _uploadProgress > 0
                  ? Column(
                children: [
                  LinearProgressIndicator(value: _uploadProgress),
                  SizedBox(height: 10),
                  Text('${(_uploadProgress * 100).toStringAsFixed(0)}%'),
                ],
              )
                  : ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Upload Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}