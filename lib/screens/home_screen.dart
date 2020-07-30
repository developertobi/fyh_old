import 'package:after_layout/after_layout.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/models/deck.dart';
import 'package:naija_charades/providers/firestore_data.dart';
import 'package:naija_charades/providers/results.dart';
import 'package:naija_charades/widgets/deck/deck_builder.dart';

import 'package:naija_charades/widgets/home/error_message.dart';
import 'package:naija_charades/widgets/home/loading.dart';
import 'package:naija_charades/widgets/results/results_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../colors.dart' as AppColors;

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  @override
  void afterFirstLayout(BuildContext context) {
    _showResults(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: Center(
              child: Image.asset('assets/logo.jpg'),
            ),
          ),
          FutureBuilder(
            future: _requestAllPermissions(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  color: Colors.black.withOpacity(0.7),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Consumer<FirestoreData>(
                    builder: (_, firestoreData, __) =>
                        FutureBuilder<List<Deck>>(
                      future: firestoreData.updateData(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData && snapshot.data.isNotEmpty) {
                          var decks = snapshot.data;
                          return DeckBuilder(decks: decks);
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return ErrorMsg();
                        } else {
                          return Loading();
                        }
                      },
                    ),
                  ),
                );
              }
              // While _requestAllPermissions hasnt completed execution
              return Container(
                color: Colors.black.withOpacity(0.9),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showResults(BuildContext context) async {
    Map<String, String> args = ModalRoute.of(context).settings.arguments;
    var permissionStatuses =
        Provider.of<Results>(context, listen: false).permissionStatuses;

    if (args != null) {
      showDialog(
        context: context,
        builder: (_) => ResultsDialog(
          showVideo: permissionStatuses['camera'].isGranted &&
              permissionStatuses['microphone'].isGranted,
        ),
        barrierDismissible: false,
      );
    }
  }

  Future<void> _requestAllPermissions(BuildContext context) async {
    if (await Permission.camera.isDenied ||
        await Permission.microphone.isDenied ||
        await Permission.photos.isDenied) {
      Flushbar(
        messageText: Text(
          'Your camera, mic or photos is disabled for this app',
          style: TextStyle(color: Colors.white),
        ),
        mainButton: FlatButton(
          onPressed: () => openAppSettings(),
          child: Text(
            'Grant permission',
            style: TextStyle(
                color: AppColors.persimmon,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        flushbarStyle: FlushbarStyle.GROUNDED,
        duration: Duration(seconds: 3),
        animationDuration: Duration(milliseconds: 500),
      )..show(context);
    }

    await [
      Permission.camera,
      Permission.microphone,
    ].request();
  }
}
