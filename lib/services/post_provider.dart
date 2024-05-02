import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  Set<int> _likedPosts = {};

  bool isLiked(int postId) {
    return _likedPosts.contains(postId);
  }

  Future<void> likePost(int postId) async {
    // Perform the like action
    _likedPosts.add(postId);
    notifyListeners(); // Notify listeners that the state has changed
  }
}
