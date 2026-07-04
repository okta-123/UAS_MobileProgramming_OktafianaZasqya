import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  // Ganti dengan koordinat laundry kamu
  static const LatLng lokasiLaundry = LatLng(
    -6.3098,
    106.7338,
  );

  Future<void> bukaGoogleMaps() async {
    final Uri url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=-6.3098,106.7338",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          FlutterMap(
            options: const MapOptions(
              initialCenter: lokasiLaundry,
              initialZoom: 16,
            ),

            children: [

              TileLayer(
                urlTemplate:
                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName:
                    "com.example.laundry_booking",
              ),

              MarkerLayer(
                markers: [

                  Marker(
                    point: lokasiLaundry,
                    width: 80,
                    height: 80,

                    child: const Icon(
                      Icons.location_on,
                      size: 45,
                      color: Colors.red,
                    ),
                  )

                ],
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,

            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),

                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black26,
                  )
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Text(
                    "🧺 Laundry Taarooms",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    children: [

                      Icon(Icons.location_on,color: Colors.red),

                      SizedBox(width:10),

                      Expanded(
                        child: Text(
                          "Jl. Pamulang Raya No.10, Tangerang Selatan",
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height:10),

                  const Row(
                    children: [

                      Icon(Icons.access_time),

                      SizedBox(width:10),

                      Text("08.00 - 21.00 WIB"),

                    ],
                  ),

                  const SizedBox(height:10),

                  const Row(
                    children: [

                      Icon(Icons.phone),

                      SizedBox(width:10),

                      Text("0812-3456-7890"),

                    ],
                  ),

                  const SizedBox(height:18),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton.icon(

                      onPressed: bukaGoogleMaps,

                      icon: const Icon(Icons.map),

                      label: const Text(
                        "Buka di Google Maps",
                      ),

                    ),
                  )

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}