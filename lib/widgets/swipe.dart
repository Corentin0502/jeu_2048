import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';


class Swipe extends StatelessWidget {

  void _addSwipe(SwipeDirection direction) {
    // Implémentez la logique pour gérer le swipe
    print('Swipe detected: $direction');
  }

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipe: (direction, offset) {
        _addSwipe(direction);
      },
      onSwipeUp: (offset) {
        _addSwipe(SwipeDirection.up);
      },
      onSwipeDown: (offset) {
        _addSwipe(SwipeDirection.down);
      },
      onSwipeLeft: (offset) {
        _addSwipe(SwipeDirection.left);
      },
      onSwipeRight: (offset) {
        _addSwipe(SwipeDirection.right);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          'Swipe me!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}