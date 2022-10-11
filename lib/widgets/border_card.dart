import 'package:fantasyapp/vars.dart';
import 'package:flutter/material.dart';

class BorderCard extends StatelessWidget {
  final Widget widget;
  final double height;

  const BorderCard({
    Key? key,
    required this.widget,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.all(kMargin),
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(style: BorderStyle.solid),
        ),
      ),
      child: Center(child: widget),
    );
  }
}
