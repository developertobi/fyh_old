import 'package:naija_charades/models/response.dart';
import 'package:permission_handler/permission_handler.dart';

class Results {
  List<Response> responses;
  int score;
  String deckImageUrl;
  int colorHex;
  List words;
  Map<String, PermissionStatus> permissionStatuses;
}
