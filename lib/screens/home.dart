import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../CustomToolbar.dart';
import '../Token Manager.dart';
import '../component/CarHealth.dart';
import '../component/LocationCard.dart';
import '../component/VehicleScoreCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LatLng _dummyLocation = LatLng(40.758896, -73.985130);
  final bool isLoading = false;

  final VehicleDriverScoreResponse vehicleDriverScoreResponse =
  VehicleDriverScoreResponse(
    driverScore: 75,
    factorsScore: FactorsScore(
      fuelEfficiency: 40,
      tripEfficiency: 60,
      safetyLevel: 30,
    ),
  );

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout", style: GoogleFonts.poppins()),
          content: Text("Are you sure you want to logout?", style: GoogleFonts.poppins()),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel", style: GoogleFonts.poppins()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Logout", style: GoogleFonts.poppins(color: Colors.red)),
              onPressed: () {
                _logoutUser();
              },
            ),
          ],
        );
      },
    );
  }

  void _logoutUser() async {
    await TokenManager().removeToken();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomToolbar(
        title: 'Home',
        showMenuIcon: false,
        showNotificationIcon: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Safety', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout', style: GoogleFonts.poppins()),
              onTap: () {
                _showLogoutConfirmation(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocationCard(location: _dummyLocation),
            SizedBox(height: 16),
            VehicleScoreCard(
              vehicleDriverScoreResponse: vehicleDriverScoreResponse,
              isLoading: isLoading,
            ),
            SizedBox(height: 15),
            Text(
              'Car Health',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: Color(0xFF2C2C2C),
              ),
            ),
            SizedBox(height: 15),
             const Wrap(
              spacing: 13,
              runSpacing: 10,
              children: [
                CarHealth(
                  mainIconPath: 'assets/images/engine.png',
                  alertIconPath: 'assets/images/exclamation.png',
                  label: 'Engine',
                  alertIconColor: Color(0xFFFF1414),
                ),
                CarHealth(
                  mainIconPath: 'assets/images/battery.png',
                  alertIconPath: 'assets/images/check.png',
                  label: 'Battery',
                  alertIconColor: Color(0xFF07850C),
                ),
                CarHealth(
                  mainIconPath: 'assets/images/tow.png',
                  alertIconPath: 'assets/images/exclamation.png',
                  label: 'Tow',
                  alertIconColor: Color(0xFFFF1414),
                ),
                CarHealth(
                  mainIconPath: 'assets/images/tow.png',
                  alertIconPath: 'assets/images/check.png',
                  label: 'Impact',
                  alertIconColor: Color(0xFF07850C),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
