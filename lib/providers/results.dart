import 'package:naija_charades/models/response.dart';
import 'package:permission_handler/permission_handler.dart';

class Results {
  late List<Response> responses;
  late int score;
  late String deckImageUrl;
  late int colorHex;
  late List words;
  Map<String, PermissionStatus>? permissionStatuses;
}
