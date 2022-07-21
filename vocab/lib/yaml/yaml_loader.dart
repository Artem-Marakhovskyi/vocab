import 'dart:io';
import 'package:yaml/yaml.dart';

class YamlLoader {
  Future<dynamic> load(String filePath) async {
    var fileContent = await File(filePath).readAsString();
    return loadYaml(fileContent);
  }
}
