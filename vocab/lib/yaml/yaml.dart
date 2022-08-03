import 'dart:io';

import 'package:yaml_writer/yaml_writer.dart';

import 'yaml_loader.dart';

class Yaml {
  Future<dynamic> load(String filePath) async {
    if (!await File(filePath).exists()) {
      return null;
    }
    return YamlLoader().load(filePath);
  }

  Future append(String filePath, Object json) async {
    var yaml = YAMLWriter().write(json);
    if (await File(filePath).exists()) {
      File(filePath).writeAsString(yaml, mode: FileMode.append, flush: true);
    }
  }

  Future write(String filePath, Object json) async {
    var yaml = YAMLWriter().write(json);
    var file = File(filePath);
    print('writing');
    try {
      if (!await file.exists()) {
        await file.create();
      }
      var tempFile = File(filePath + 'prev');
      await file.copy(tempFile.path);
      file = (await file.create());
      file = await file.writeAsString(yaml, mode: FileMode.write, flush: true);
    } on Exception catch (e) {
      print(e);
    }
  }
}
