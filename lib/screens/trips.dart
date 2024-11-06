import 'package:classico/view_holder/PostViewHolder.dart';
import 'package:classico/viewmodel/TripsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CustomToolbar.dart';
import 'package:provider/provider.dart';


class TripsScreen extends StatelessWidget {
  const TripsScreen({Key? key}) : super(key: key);

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
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Logout", style: GoogleFonts.poppins(color: Colors.red)),
              onPressed: () {
                // Add logout logic
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripsViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomToolbar(
          title: 'Trips',
          showMenuIcon: false,
          showNotificationIcon: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Menu', style: GoogleFonts.poppins(color: Colors.white, fontSize: 24)),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile', style: GoogleFonts.poppins()),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.security),
                title: Text('Safety', style: GoogleFonts.poppins()),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout', style: GoogleFonts.poppins()),
                onTap: () => _showLogoutConfirmation(context),
              ),
            ],
          ),
        ),
        body: Consumer<TripsViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (viewModel.errorMessage != null) {
              return Center(child: Text(viewModel.errorMessage!));
            } else {
              return ListView.builder(
                itemCount: viewModel.posts.length,
                itemBuilder: (context, index) {
                  return PostViewHolder(post: viewModel.posts[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
