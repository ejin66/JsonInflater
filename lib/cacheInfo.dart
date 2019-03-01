class CacheInfo {
  String package;
  String path;

  CacheInfo(this.package, this.path);

  String getImportString(int index) {
    return '''
    import 'package:$package/${path.replaceFirst('lib/', '')}' as part$index;
    ''';
  }
}
