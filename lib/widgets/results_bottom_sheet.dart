import 'package:flutter/material.dart';
import 'package:naija_charades/colors.dart' as AppColors;

class ResultsBottomSheet extends StatelessWidget {
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
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    color: Colors.red,
                    child: Text(
                      'data',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
