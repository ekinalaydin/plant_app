import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  Set<int> _likedPosts = {};

  bool isLiked(int postId) {
    return _likedPosts.contains(postId);
  }

  void likePost(int postId) {
    _likedPosts.add(postId);
    notifyListeners();
  }

  void unlikePost(int postId) {
    _likedPosts.remove(postId);
    notifyListeners();
  }
}
