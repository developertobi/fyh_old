import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/models/category.dart';
import 'package:naija_charades/providers/firestore_data.dart';

import 'package:naija_charades/widgets/category_decks.dart';
import 'package:naija_charades/widgets/error_message.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../colors.dart' as AppColors;

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: AppColors.prussianBlue,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xFF191A1C),
            child: Center(
              child: Image.asset('assets/logo.jpg'),
            ),
          ),
          FutureBuilder(
            future: _requestAllPermissions(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  color: AppColors.prussianBlue.withOpacity(0.9),
                  padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                  child: Consumer<FirestoreData>(
                    builder: (_, firestoreData, __) {
                      return FutureBuilder<List<Category>>(
                        future: firestoreData.updateData(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData && snapshot.data.isNotEmpty) {
                            var categories = snapshot.data;
                            return ListView.builder(
                              itemCount: categories.length,
                              itemBuilder: (_, i) {
                                return CategoryDecks(
                                  categoryTitle: categories[i].title,
                                  decks: categories[i].decks,
                                );
                              },
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ErrorMsg();
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                strokeWidth: 10,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    AppColors.prussianBlue),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                );
              }
              return Container(color: AppColors.prussianBlue.withOpacity(0.9));
            },
          ),
        ],
      ),
    );
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
