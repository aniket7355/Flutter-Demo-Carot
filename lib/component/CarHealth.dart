import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarHealth extends StatelessWidget {
  final String mainIconPath;
  final String alertIconPath;
  final String label;
  final Color alertIconColor;
  const CarHealth({
    Key? key,
    required this.mainIconPath,
    required this.alertIconPath,
    required this.label,
    this.alertIconColor = const Color(0xFFFF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFFE0F3F9),
              radius: 12,
              child: Image.asset(
                alertIconPath,
                width: 12,
                height: 12,
                color: alertIconColor,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  mainIconPath,
                  width: 40,
                  height: 40,
                  color: Color(0xFF4C4C4C),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF717171),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
