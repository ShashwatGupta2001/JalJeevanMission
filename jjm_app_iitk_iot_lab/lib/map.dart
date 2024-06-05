import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';

TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  // Use the recommended flutter_map_cancellable_tile_provider package to
  // support the cancellation of loading tiles.
  tileProvider: CancellableNetworkTileProvider(),
);

class MenuDrawer extends StatelessWidget {
  final String currentRoute;

  const MenuDrawer(this.currentRoute, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // your menu items go here
        ],
      ),
    );
  }
}

class SecondScreenPage extends StatefulWidget {
  static const String route = '/second_screen';

  const SecondScreenPage({Key? key}) : super(key: key);

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreenPage> {
  static const double pointSize = 65;
  static const double pointY = 250;

  final mapController = MapController();

  LatLng? latLng;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => updatePoint(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jal Jeevan Mission - IITK')),
      drawer: const MenuDrawer(SecondScreenPage.route),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              onPositionChanged: (_, __) => updatePoint(context),
              initialCenter: const LatLng(51.5, -0.09),
              initialZoom: 5,
              minZoom: 3,
            ),
            children: [
              openStreetMapTileLayer,
              if (latLng != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: pointSize,
                      height: pointSize,
                      point: latLng!,
                      child: const Icon(
                        Icons.circle,
                        size: 10,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
            ],
          ),
          Positioned(
            top: pointY - pointSize / 2,
            left: _getPointX(context) - pointSize / 2,
            child: const IgnorePointer(
              child: Icon(
                Icons.center_focus_strong_outlined,
                size: pointSize,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: pointY + pointSize / 2 + 6,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Text(
                '(${latLng?.latitude.toStringAsFixed(3)},${latLng?.longitude.toStringAsFixed(3)})',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void updatePoint(BuildContext context) => setState(() => latLng =
      mapController.camera.pointToLatLng(Point(_getPointX(context), pointY)));

  double _getPointX(BuildContext context) =>
      MediaQuery.of(context).size.width / 2;
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SecondScreenPage();
  }
}
