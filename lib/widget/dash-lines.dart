import 'package:flutter/material.dart';

import '../utils/widget_extensions.dart';

class DashLines extends StatelessWidget {
  final int dashAmount;
  const DashLines({super.key, required this.dashAmount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width(context),
          height: 0.5,
          color: Colors.white,
        ),
        Row(
          children: List.generate(dashAmount, (index) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  index == dashAmount-1? 0.0.sbW: 5.0.sbW
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}