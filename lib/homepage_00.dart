import 'main.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class NumberInputPage extends StatefulWidget {
  @override
  _NumberInputPageState createState() => _NumberInputPageState();
}

class _NumberInputPageState extends State<NumberInputPage> {
  TextEditingController _numberController = TextEditingController();
  TextEditingController _numberController1 = TextEditingController();

  List<int> numbers = [];
  int min = 0;
  int max = 0;
  int value = 0;
  Random random = Random();

  void _saveNumber() {
    String inputText = _numberController.text;
    String inputText1 = _numberController1.text;
    if (inputText.isNotEmpty) {
      int? number = int.tryParse(inputText);
      if (number != null) {
        setState(() {
          min = number;
        });
      }
    }
    if (inputText.isNotEmpty) {
      int? number1 = int.tryParse(inputText1);
      if (number1 != null) {
        setState(() {
          max = number1;
          _display();
        });
      }
    }
  }

  void _display() {
    setState(() {
      value = min + random.nextInt(max - min);
      if (numbers.contains(value)) {
        _display();
      } else {
        numbers.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    IconData icon;
    if (appState.favorites.contains(value)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(
            ' $value',
            style: TextStyle(fontSize: 40.0),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 200.0,
          ),
          child: TextField(
            controller: _numberController,
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              labelText: 'Enter Min Value',
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 200.0,
          ),
          child: TextField(
            controller: _numberController1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter Max Value',
            ),
          ),
        ),
        SizedBox(
          height: 60.0,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                appState.toggleFavorite(value);
              },
              icon: Icon(icon),
              label: Text('Like'),
            ),
            SizedBox(
              width: 50.0,
            ),
            ElevatedButton.icon(
              onPressed: _saveNumber,
              icon: Icon(Icons.next_plan),
              label: Text('NEXT'),
            ),
          ],
        ),
      ],
    );
  }
}
