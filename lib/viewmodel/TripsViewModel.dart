import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

class TripsViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Post> _posts = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  TripsViewModel() {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      _posts = await _apiService.fetchPosts();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load posts";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
