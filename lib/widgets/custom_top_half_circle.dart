
import 'package:flutter/material.dart';

class TopHalfCircle extends StatelessWidget {
  const TopHalfCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width * 3,
        height: 150,
        decoration: const BoxDecoration(
          color: Color(0xFFF8F9FF),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(120),
          ),
        ),
      ),
    );
  }
}

