import 'package:flutter/material.dart';
import 'liste_deroulante.dart';

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
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Objectifs : $selectedValue',
              style: const TextStyle(
                fontSize: 18,
                height: 1.2,
              ),
            ),
          ),
          ActionSheet(onSelectionChanged: _onSelectionChanged),
        ],
      ),
    );
  }
}