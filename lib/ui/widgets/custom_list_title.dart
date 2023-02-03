import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/models/character.dart';

class CustomListTitle extends StatelessWidget {
  final Results results;
  const CustomListTitle({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        results.name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
