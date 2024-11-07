import 'package:classico/local_database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profileData = await dbHelper.getProfile();
    if (profileData != null) {
      nameController.text = profileData['name'] ?? '';
      emailController.text = profileData['email'] ?? '';
      phoneController.text = profileData['phone'] ?? '';
      addressController.text = profileData['address'] ?? '';
      cityController.text = profileData['city'] ?? '';
      stateController.text = profileData['state'] ?? '';
    }
  }

  Future<void> saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final profileData = {
        'id': 1,
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'city': cityController.text,
        'state': stateController.text,
      };

      try {
        await dbHelper.insertOrUpdateProfile(profileData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Profile saved successfully!"),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      } catch (error) {
        print("------------------------->$error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to save profile. Try again!$error"),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: GoogleFonts.poppins()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                _buildTextField('Name', nameController, validator: _validateField),
                SizedBox(height: 20),
                _buildTextField('Email', emailController, validator: _validateEmail),
                SizedBox(height: 20),
                _buildTextField('Phone Number', phoneController, validator: _validatePhone),
                SizedBox(height: 20),
                _buildTextField('Address', addressController, validator: _validateField),
                SizedBox(height: 20),
                _buildTextField('City', cityController, validator: _validateField),
                SizedBox(height: 20),
                _buildTextField('State', stateController, validator: _validateField),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: saveProfile,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.orange,
                    ),
                    child: Text(
                      'Save Profile',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType inputType = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
