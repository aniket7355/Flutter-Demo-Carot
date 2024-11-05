import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import '../models/post_model.dart';
import '../CustomToolbar.dart';
import 'package:classico/Token%20Manager.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  late Future<List<Post>> _posts;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _posts = _apiService.fetchPosts();
  }

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
        title: 'Trips',
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
      body: FutureBuilder<List<Post>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load posts"));
          } else {
            final posts = snapshot.data ?? [];
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostViewHolder(post: posts[index]);
              },
            );
          }
        },
      ),
    );
  }
}

class PostViewHolder extends StatelessWidget {
  final Post post;

  const PostViewHolder({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("You clicked on id ${post.id}"),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            leading: CircleAvatar(
              backgroundColor: Color(0xFFF8941E),
              child: Text(post.id.toString()),
            ),
            title: Text(
              _truncateTitle(post.title),
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  String _truncateTitle(String title) {
    List<String> words = title.split(' ');
    if (words.length > 8) {
      return words.sublist(0, 8).join(' ') + '...'; // Add ellipsis if truncated
    }
    return title; // Return the original title if it's 8 words or less
  }
}
