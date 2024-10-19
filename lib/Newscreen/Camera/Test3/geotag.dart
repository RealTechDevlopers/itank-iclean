import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'geotagcontroller.dart';
class pictureImageScreen extends StatelessWidget {
  final PictureController _imageController = Get.put(PictureController());
  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay Text on Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _imageController.captureImage1,
              child: const Text('Capture Image'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Enter overlay text',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final mergedFile = await _imageController.mergeImageWithTextOverlay();
                if (mergedFile != null) {
                  Get.snackbar('Success', 'Image with text overlay saved at ${mergedFile.path}');
                }
              },
              child: const Text('Add Overlay Text'),
            ),
          ],
        ),
      ),
    );
  }
}
