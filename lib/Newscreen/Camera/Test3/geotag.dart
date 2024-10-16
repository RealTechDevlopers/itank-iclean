import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class GeoCameraApp extends StatefulWidget {
  @override
  _GeoCameraAppState createState() => _GeoCameraAppState();
}
class _GeoCameraAppState extends State<GeoCameraApp> {
  File? _imageFile;
  Position? _currentPosition;
  final ImagePicker _picker = ImagePicker();
  // Check and request location permissions
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Request to open location settings if location services are not enabled
      await Geolocator.openLocationSettings();
      return false;
    }
    // Check if the app has location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if not granted
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // If permission is still denied, return false
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return false;
    }
    return true;
  }
  // Get the current location
  Future<void> _getCurrentLocation() async {
    bool hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permissions are not granted'),
      ));
      return;
    }
    // If permission is granted, get the current position
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {});
  }
  // Capture or select image
  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _imageFile = pickedFile != null ? File(pickedFile.path) : null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error picking image: $e'),
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geo Camera App'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    _imageFile == null
                        ? const Text('No image selected.')
                        : Image.file(_imageFile!), // Image background
                    if (_currentPosition != null)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: 80,
                          color: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Text(
                                'Name: Krishanan',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await _pickImage();
                    await _getCurrentLocation();
                  },
                  child: const Text('Capture Image with Location'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

