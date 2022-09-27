import 'package:flutter/material.dart';

class BoostCard extends StatelessWidget {
  const BoostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.airline_seat_recline_normal),
    );
  }
}
