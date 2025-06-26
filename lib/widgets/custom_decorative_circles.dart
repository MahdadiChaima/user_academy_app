
import 'package:flutter/material.dart' ;

class DecorativeCircles extends StatelessWidget {
  final Size mediaQuery;
  DecorativeCircles({super.key, required this.mediaQuery});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // دائرة الحدود (border)
        Positioned(
          top: -mediaQuery.width * 0.25,
          right: -mediaQuery.width * 0.35,
          child: Container(
            width: mediaQuery.width * 1.18,
            height: mediaQuery.width * 1.18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: const Color(0xFFF8F9FF), width: 2),
            ),
          ),
        ),

        // الدائرة المعبّأة (filled circle)
        Positioned(
          top: -mediaQuery.width * 0.3,
          right: -mediaQuery.width * 0.4,
          child: Container(
            width: mediaQuery.width * 1.05,
            height: mediaQuery.width * 1.05,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF8F9FF),
            ),
          ),
        ),
      ],
    );
  }
}
