import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../utils/get_location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //final mapController = MapController();
  LocationData? locationData;
  LocationData? currentLocation;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Street Map'),
      ),
      body: FutureBuilder(
          future: GetLocation().getLocation(),
          builder: (context, AsyncSnapshot snapshot) {
            print(snapshot.data?.latitude);
            if (snapshot.hasData) {
              locationData = snapshot.data;
              print("--------- $locationData");
              return OpenStreetMapSearchAndPick(
                center: LatLong(locationData?.latitude ?? 28.7041,
                    locationData?.longitude ?? 77.1025),
                buttonColor: Colors.blue,
                buttonText: 'Set Current Location',
                onPicked: (pickedData) {
                  // print(pickedData.latLong.latitude);
                  // print(pickedData.latLong.longitude);
                  // print(pickedData.address);
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
