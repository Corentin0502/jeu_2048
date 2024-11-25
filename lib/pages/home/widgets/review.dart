import 'package:flutter/material.dart';

class ReviewSection extends StatefulWidget {
  final int selectedValue;

  const ReviewSection({super.key, required this.selectedValue});

  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  late int selectedValue;
  late int maxScore;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
    maxScore = selectedValue;
  }

  void _onSelectionChanged(int value) {
    setState(() {
      selectedValue = value;
      maxScore = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 119,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Objectifs à atteindre : $selectedValue',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        child: const Icon(
          Icons.refresh,
          size: 24,
        ),
      ),
        ],
      ),
    );
  }
}
