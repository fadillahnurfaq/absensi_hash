import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';

class AppMaps extends StatelessWidget {
  final LatLng? location;
  final List<Widget>? children;
  final MapController? mapController;
  const AppMaps({
    super.key, 
    this.location, 
    this.mapController, 
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: location ?? const LatLng(-6.1719, 106.8229),
        initialZoom: 15.0,
        minZoom: 2,
        backgroundColor: const Color(0xFFaad2df),
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "com.ritra.presensi",
          minZoom: 2,
          errorTileCallback: (tile, error, stackTrace) {},
          tileProvider: CancellableNetworkTileProvider(),
        ),
        if (children != null) ...children!,
      ],
    );
  }
}