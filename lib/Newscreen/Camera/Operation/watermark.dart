import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_watermark/image_watermark.dart';

class WatermarkScreen extends StatefulWidget {
  @override
  _WatermarkScreenState createState() => _WatermarkScreenState();
}

class _WatermarkScreenState extends State<WatermarkScreen> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _originalImage;
  Uint8List? _watermarkedImage;
  bool _isLoading = false;
  String _watermarkText = 'My Watermark';

  Future<void> _captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _originalImage = await pickedFile.readAsBytes();
      setState(() {});
    }
  }

  Future<void> _addTextWatermark() async {
    if (_originalImage != null) {
      setState(() {
        _isLoading = true;
      });

      _watermarkedImage = await ImageWatermark.addTextWatermark(
        imgBytes: _originalImage!,
        watermarkText: _watermarkText,
        dstX: 30,
        dstY: 90,
        color: Colors.black,
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Image and Watermark'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _captureImage,
              child: Text('Capture Image'),
            ),
            if (_originalImage != null)
              Image.memory(
                _originalImage!,
                height: 200,
                fit: BoxFit.contain,
              ),
            TextField(
              decoration: InputDecoration(labelText: 'Enter Watermark Text'),
              onChanged: (value) {
                _watermarkText = value;
              },
            ),
            ElevatedButton(
              onPressed: _addTextWatermark,
              child: Text('Add Watermark'),
            ),
            if (_isLoading) CircularProgressIndicator(),
            if (_watermarkedImage != null)
              Image.memory(
                _watermarkedImage!,
                height: 200,
                fit: BoxFit.contain,
              ),
          ],
        ),
      ),
    );
  }
}
