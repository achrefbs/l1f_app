import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderWidget extends StatefulWidget {
  HeaderWidget({
    Key? key,
    required this.title,
    this.hasBackArrow = true,
    this.navigateTo,
  }) : super(key: key);
  String title;
  bool hasBackArrow;
  Widget? navigateTo;
  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.015,
        right: MediaQuery.of(context).size.width * 0.015,
        top: MediaQuery.of(context).size.height * 0.015,
        bottom: MediaQuery.of(context).size.height * 0.015,
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.hasBackArrow == true
                  ? GestureDetector(
                      child: const Icon(
                        Icons.arrow_back,
                        size: 28,
                      ),
                      onTap: () {
                        if (widget.navigateTo != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => widget.navigateTo!,
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    )
                  : const SizedBox(),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
