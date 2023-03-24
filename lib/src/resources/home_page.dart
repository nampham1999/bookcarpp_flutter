import 'dart:async';

import 'package:book_car_app/src/resources/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Polyline> _polyline = {};
  List<LatLng> latLen = [];

  void getPolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult rs = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyA25KbkRpwpyFJjuVD70M_vyzb60HJsE4s',
      const PointLatLng(21.062862, 105.794082),
      const PointLatLng(21.062908, 105.8091),
      travelMode: TravelMode.driving,
    );
    if (rs.points.isNotEmpty) {
      for (var point in rs.points) {
        latLen.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    }
    setState(() {});
  }

  Set<Marker> _createMarker() {
    return {
      const Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(21.062862, 105.794082),
        infoWindow: InfoWindow(title: 'Company'),
        rotation: 0,
      ),
      const Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(21.062908, 105.8091),
        infoWindow: InfoWindow(title: 'Marker 1'),
        rotation: 0,
      ),
    };
  }

  void _currentLocation() async {
    // Create a map controller
    final GoogleMapController controller = await _controller.future;
    LocationData? currentLocation;
    var location = Location();
    try {
      // Find and store your location in a variable
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    // Move the map camera to the found location using the controller
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(double.parse(currentLocation!.latitude.toString()),
            double.parse(currentLocation.longitude.toString())),
        zoom: 17.0,
      ),
    ));
  }

  @override
  void initState() {
    getPolyPoint();
    super.initState();
  }

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(21.062862, 105.794082),
    zoom: 14.4746,
  );

  final CameraPosition _kLake = const CameraPosition(
      bearing: 45.0,
      target: LatLng(21.062862, 105.794082),
      tilt: 59.440717697143555,
      zoom: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: latLen.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              myLocationEnabled: true,
              padding: EdgeInsets.only(
                top: 40.0,
              ),
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              polylines: {
                Polyline(
                  polylineId: PolylineId('1'),
                  width: 5,
                  points: latLen,
                  color: Colors.red,
                )
              },
              markers: _createMarker(),
            ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To apartment!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
        child: FloatingActionButton.extended(
          onPressed: _currentLocation,
          label: Text('My Location'),
          icon: Icon(Icons.location_on),
        ),
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}

// import 'dart:async';

// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> with TickerProviderStateMixin {
//   late Animation _arrowAnimation, _heartAnimation;
//   late AnimationController _arrowAnimationController, _heartAnimationController;

//   @override
//   void initState() {
//     super.initState();

//     _heartAnimationController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 1200));
//     _heartAnimation = Tween(begin: 150.0, end: 180.0).animate(CurvedAnimation(
//         curve: Curves.bounceInOut, parent: _heartAnimationController));

//     _heartAnimationController.addStatusListener((AnimationStatus status) {
//       if (status == AnimationStatus.completed) {
//         _heartAnimationController.repeat();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _arrowAnimationController.dispose();
//     _heartAnimationController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Animations'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           // firstChild(),
//           const SizedBox(
//             height: 50.0,
//           ),
//           secondChild(),
//         ],
//       ),
//     );
//   }

//   Widget secondChild() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         Expanded(
//           child: AnimatedBuilder(
//             animation: _heartAnimationController,
//             builder: (context, child) {
//               return Center(
//                 child: Container(
//                   child: Center(
//                     child: Icon(
//                       Icons.favorite,
//                       color: Colors.red,
//                       size: _heartAnimation.value,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(right: 12.0),
//             child: ElevatedButton(
//               child: Text('Start'),
//               onPressed: () {
//                 _heartAnimationController.forward();
//               },
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
