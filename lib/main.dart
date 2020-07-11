import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkingmap/models/place.dart';
import 'package:parkingmap/screens/search.dart';
import 'package:parkingmap/services/geolocator_service.dart';
import 'package:parkingmap/services/places_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final locatorService = GeolocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position,Future<List<Place>>>( 
          update: (context,position,places){
            return (position !=null) ? placesService.getPlaces(position.latitude, position.longitude) :null;
          },
        )
      ],
      child: MaterialApp(
        title: 'Parking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Search(),
      ),
    );
  }
}