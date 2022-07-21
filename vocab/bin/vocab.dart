import 'dart:io';

import 'package:html/parser.dart';
import 'package:vocab/html/html_parser.dart';
import 'package:vocab/translator.dart';
import 'package:vocab/dict/existing_dict.dart';
import 'package:vocab/yaml/yaml.dart';

void main(List<String> arguments) async {
  var f = await File('${Directory.current.path}/../vocabulary/index.html')
      .readAsString();
  print(processHtml(f));
  f = await File('${Directory.current.path}/../vocabulary/index2.html')
      .readAsString();
  print(processHtml(f));
  f = await File('${Directory.current.path}/../vocabulary/index3.html')
      .readAsString();
  print(processHtml(f));
  // var existingDict = await ExistingDict(
  //     '${Directory.current.path}/../vocabulary/vocabulary-de.yaml');
  // existingDict.load();

  // var translator = Translator(Yaml(), existingDict);
  // translator.loadTranslations(
  //   '${Directory.current.path}/../vocabulary/old.yaml',
  // );
}
