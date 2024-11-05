import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleDriverScoreResponse {
  final int driverScore;
  final FactorsScore factorsScore;

  VehicleDriverScoreResponse({required this.driverScore, required this.factorsScore});
}

class FactorsScore {
  final int fuelEfficiency;
  final int tripEfficiency;
  final int safetyLevel;

  FactorsScore({
    required this.fuelEfficiency,
    required this.tripEfficiency,
    required this.safetyLevel,
  });
}

class VehicleScoreCard extends StatelessWidget {
  final VehicleDriverScoreResponse? vehicleDriverScoreResponse;
  final bool isLoading;

  const VehicleScoreCard({
    Key? key,
    required this.vehicleDriverScoreResponse,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/driver_score_card_bg_shape.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Driver Score",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else if (vehicleDriverScoreResponse != null)
                  Column(
                    children: [
                      _buildFactorRow(
                        label: "Fuel Efficiency",
                        value: vehicleDriverScoreResponse!.factorsScore.fuelEfficiency,
                      ),
                      _buildFactorRow(
                        label: "Trip Efficiency",
                        value: vehicleDriverScoreResponse!.factorsScore.tripEfficiency,
                      ),
                      _buildFactorRow(
                        label: "Safety",
                        value: vehicleDriverScoreResponse!.factorsScore.safetyLevel,
                      ),
                    ],
                  )
                else
                  Text("No data available"),
              ],
            ),
          ),
          if (!isLoading && vehicleDriverScoreResponse != null)
            Padding(
              padding: const EdgeInsets.only(top: 35, left: 19),
              child: _buildOverallScoreColumn(vehicleDriverScoreResponse!.driverScore),
            ),
        ],
      ),
    );
  }

  Widget _buildFactorRow({required String label, required int value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF525252),
            ),
          ),
          SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value > 0 ? value / 100.0 : 0.0,
              backgroundColor: Colors.grey[100],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF8941E)),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallScoreColumn(int score) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF980C4B), Color(0xFFF8941E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$score%",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Overall score\nGood!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
