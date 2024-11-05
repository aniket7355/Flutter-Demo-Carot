import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomToolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenuIcon;
  final bool showNotificationIcon;

  CustomToolbar({
    required this.title,
    this.showMenuIcon = true,
    this.showNotificationIcon = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          if (showMenuIcon)
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(),
            ),
          ),
          if (showNotificationIcon)
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print('Notification button pressed');
              },
            ),
        ],
      ),
      centerTitle: true,
    );
  }
}
