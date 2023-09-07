import 'package:flutter/material.dart';

class LabelWrapper extends StatelessWidget {
  final Widget child;
  final Widget label;

  const LabelWrapper({
    super.key,
    required this.child,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DefaultTextStyle(
          style: TextStyle(color: Colors.black),
          child: label,
        ),
        child,
      ],
    );
  }
}
