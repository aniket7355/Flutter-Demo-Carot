import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class LocationCard extends StatefulWidget {
  final LatLng location;

  LocationCard({required this.location});

  @override
  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  late GoogleMapController mapController;
  bool _isMapExpanded = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newLatLng(widget.location));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isMapExpanded = !_isMapExpanded;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Latitude: ${widget.location.latitude}, Longitude: ${widget.location.longitude}',
              style: GoogleFonts.poppins(fontSize: 14.0),
            ),
            SizedBox(height: 4.0),
            Text(
              'Time: ${DateFormat('hh:mm a, dd MMM yyyy').format(DateTime.now().toUtc().add(Duration(hours: 5, minutes: 30)))}',
              style: GoogleFonts.poppins(fontSize: 14.0),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Engine: ',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ON',
                  style: GoogleFonts.poppins(color: Colors.green),
                ),
                Spacer(),
                Text(
                  'Online',
                  style: GoogleFonts.poppins(color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _isMapExpanded ? 550.0 : 150.0,
              width: double.infinity,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: widget.location,
                  zoom: 14.0,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('dummyLocation'),
                    position: widget.location,
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
