import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Geocoding Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dynamic Reverse Geocoding'),
        ),
        body: GeocodingApp(),
      ),
    );
  }
}

class GeocodingApp extends StatefulWidget {
  @override
  _GeocodingAppState createState() => _GeocodingAppState();
}

class _GeocodingAppState extends State<GeocodingApp> {
  // List of locations with latitude and longitude
  List<Map<String, dynamic>> locations = [
    {'lat': 37.7749, 'lng': -122.4194}, // San Francisco
    {'lat': 40.7128, 'lng': -74.0060},  // New York
    {'lat': 51.5074, 'lng': -0.1278},   // London
    {'lat': 48.8566, 'lng': 2.3522},    // Paris
  ];

  // Store the reverse geocoded addresses
  Map<String, String> addresses = {};

  @override
  void initState() {
    super.initState();
    _populateAddresses(); // Fetch addresses when app starts
  }

  // Function to get the address from latitude and longitude
  Future<void> _populateAddresses() async {
    for (var location in locations) {
      double lat = location['lat'];
      double lng = location['lng'];

      try {
        // Reverse geocode to get address using latitude and longitude
        List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
        Placemark place = placemarks[0];

        // Create a formatted address from the Placemark result
        String address =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

        // Update the state with the fetched address if the widget is still mounted
        if (mounted) {
          setState(() {
            addresses['$lat,$lng'] = address;
          });
        }
      } catch (e) {
        // If an error occurs (e.g., invalid location), set to "Address not found"
        if (mounted) {
          setState(() {
            addresses['$lat,$lng'] = 'Address not found';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          // Fetch the location data (lat and lng)
          var location = locations[index];
          double lat = location['lat'];
          double lng = location['lng'];
          String key = '$lat,$lng'; // Create a unique key for each location

          return Card(
            key: ValueKey(key), // Ensure each card has a unique key
            child: ListTile(
              title: Text('Lat: $lat, Lng: $lng'),
              subtitle: Text(
                // Display the reverse geocoded address or a loading message
                addresses[key] != null ? addresses[key]! : 'Fetching address...',
              ),
            ),
          );
        },
      ),
    );
  }
}
