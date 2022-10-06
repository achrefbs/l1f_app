import 'package:fantasyapp/providers/transfer_state.dart';
import 'package:fantasyapp/widgets/fantasy_page/player_transfer_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectGK extends StatelessWidget {
  SelectGK({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransferState transfer = Provider.of<TransferState>(context);
    var players = transfer.selectedGKs;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...players.map((player) => PlayerTransferCard(player: player)).toList(),
      ],
    );
  }
}
