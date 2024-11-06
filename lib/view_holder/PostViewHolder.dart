import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/post_model.dart';

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
              _truncateTitle("Title: ${post.title}"),
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              _truncateTitle("Content: ${post.body}"),
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  String _truncateTitle(String title) {
    List<String> words = title.split(' ');
    return words.length > 3 ? '${words.sublist(0, 3).join(' ')}...' : title;
  }
}
