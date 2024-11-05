import 'package:classico/screens/Safety.dart';
import 'package:classico/screens/geofence.dart';
import 'package:classico/screens/home.dart';
import 'package:classico/screens/trips.dart';
import 'package:classico/screens/vehicle.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final bool showBottomNavigation;

  const DashboardScreen({super.key, this.showBottomNavigation = true});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  bool _showBottomNavigation = true;

  @override
  void initState() {
    super.initState();
    _showBottomNavigation = widget.showBottomNavigation;
  }

  final List<Widget> _screens = [
    HomeScreen(),
    TripsScreen(),
    GeofenceScreen(),
    VehicleScreen(),
    SafetyScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: _showBottomNavigation
          ? Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1C2129),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: const Color(0xFF1C2129),
                  currentIndex: _currentIndex,
                  onTap: _onTabTapped,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.directions_car_outlined),
                      activeIcon: Icon(Icons.directions_car),
                      label: 'Trip',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.location_on_outlined),
                      activeIcon: Icon(Icons.location_on),
                      label: 'Geofence',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.directions_bus_outlined),
                      activeIcon: Icon(Icons.directions_bus),
                      label: 'Vehicle',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.security_outlined),
                      activeIcon: Icon(Icons.security),
                      label: 'Safety',
                    ),
                  ],
                  unselectedItemColor: Colors.white70,
                  selectedItemColor: const Color(0xFFF8941E),
                ),
              ),
            )
          : null,
    );
  }
}
