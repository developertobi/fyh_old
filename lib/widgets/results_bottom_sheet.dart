import 'package:flutter/material.dart';
import 'package:naija_charades/colors.dart' as AppColors;
import 'package:naija_charades/screens/home_screen.dart';
import 'package:naija_charades/widgets/round_button.dart';

// TODO: Possible hack is to use provider to delete the content of column before transition

class ResultsBottomSheet extends StatefulWidget {
  @override
  _ResultsBottomSheetState createState() => _ResultsBottomSheetState();
}

class _ResultsBottomSheetState extends State<ResultsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: FractionallySizedBox(
          heightFactor: 1.0,
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 30,
              right: 20,
              left: 20,
            ),
            decoration: BoxDecoration(
              color: AppColors.greenBlueCrayola,
              borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(25),
                topRight: const Radius.circular(25),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(3)),
                ),
                SizedBox(height: 10),
                Text(
                  'You answered',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '05',
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.w800),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white30)),
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, i) => Text(
                        'Shokoloko',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 34,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white30),
                  ),
                ),
                const SizedBox(height: 10),
                ButtonBar(
                  buttonPadding: EdgeInsets.all(0),
                  alignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RoundButton(
                      buttonText: 'All Decks',
                      onPressed: () => Navigator.pop(context),
                    ),
                    RoundButton(
                      buttonText: 'Save Video',
                      isFocused: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
