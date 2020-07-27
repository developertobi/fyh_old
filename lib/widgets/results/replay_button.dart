import 'package:flutter/material.dart';
import 'package:naija_charades/widgets/shared/round_button.dart';

class ReplayButton extends StatelessWidget {
  const ReplayButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundButton(
      width: (MediaQuery.of(context).size.width - 70) / 2,
      onPressed: () => Navigator.of(context).pop(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.loop,
            size: 30,
          ),
          SizedBox(width: 5),
          Text(
            'Play Again',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
