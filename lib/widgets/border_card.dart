import 'package:fantasyapp/vars.dart';
import 'package:flutter/material.dart';

class BorderCard extends StatelessWidget {
  const BorderCard({
    Key? key,
    required this.widget,
    required this.flex,
  }) : super(key: key);

  final Widget widget;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.all(kMargin),
        decoration: const BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(style: BorderStyle.solid),
          ),
        ),
        child: Center(child: widget),
      ),
    );
  }
}
