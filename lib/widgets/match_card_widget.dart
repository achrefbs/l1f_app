import 'package:flutter/material.dart';

class MatchCardScreen extends StatefulWidget {
  const MatchCardScreen({
    super.key,
    required this.scoreteam1,
    required this.scoreteam2,
    required this.score,
    required this.date,
    this.team1,
    this.team1logo,
    this.team2,
    this.team2logo,
  });
  final team1;
  final team2;
  final date;
  final team1logo;
  final team2logo;
  final int scoreteam1;
  final int scoreteam2;
  final score;

  @override
  createState() => _MatchCardScreenState();
}

class _MatchCardScreenState extends State<MatchCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Positioned(
                left: 0,
                child: Wrap(children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.team1,
                        style: const TextStyle(fontSize: 12),
                      )),
                  Image.asset(
                    widget.team1logo,
                    height: 20,
                  ),
                ])),
            const Spacer(),
            Card(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: widget.score == false
                      ? widget.date == null
                          ? const Text('TBC')
                          : Text(widget.date)
                      : Row(
                          children: [
                            Text(widget.scoreteam1.toString()),
                            const Text(' - '),
                            Text(widget.scoreteam2.toString()),
                          ],
                        )),
            ),
            Wrap(children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    widget.team2logo,
                    height: 20,
                  )),
              Text(widget.team2, style: const TextStyle(fontSize: 12)),
            ]),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: widget.score == true
                    ? Center(child: Text(widget.date))
                    : const SizedBox()),
          ],
        ));
  }
}
