// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';

enum LivaState { alive, dead, unnow }

class CharacterStatus extends StatelessWidget {
  final LivaState livaState;
  const CharacterStatus({Key? key, required this.livaState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.circle,
            size: 11,
            color: livaState == LivaState.alive
                ? Colors.lightGreenAccent[400]
                : livaState == LivaState.dead
                    ? Colors.red
                    : Colors.white),
        const SizedBox(
          width: 6,
        ),
        Text(livaState == LivaState.dead
            ? 'Dead'
            : livaState == LivaState.alive
                ? 'Alive'
                : 'Unnow'),
      ],
    );
  }
}
