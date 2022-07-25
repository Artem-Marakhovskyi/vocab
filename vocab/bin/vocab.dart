import 'dart:convert';
import 'dart:io';

import 'package:vocab/dict/input/input_dict.dart';
import 'package:vocab/html/html_parser.dart';
import 'package:vocab/network/wordreference.api.dart';
import 'package:vocab/translator.dart';
import 'package:vocab/dict/existing_dict.dart';

void main(List<String> arguments) async {
  // var s = await WordReferenceApi().getHtml('de', 'en', 'quatsch');
  // var s = File('${Directory.current.path}/../vocabulary/index.html')
  //     .readAsStringSync();
  // print(HtmlParser().processHtml(s));

  var existingDict = ExistingDict(
      '${Directory.current.path}/../vocabulary/vocabulary-de.yaml');
  await existingDict.load();

  var inputDict =
      InputDict('${Directory.current.path}/../vocabulary/input.yaml');
  await inputDict.load();

  var translator =
      Translator(inputDict, existingDict, HtmlParser(), WordReferenceApi());
  await translator.loadTranslations();
}
