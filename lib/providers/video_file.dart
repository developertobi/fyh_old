class VideoFile {
  String _path = '';

  void setPath(String path) {
    print('Video path: $path');
    _path = path;
  }

  String get path => _path;
}
