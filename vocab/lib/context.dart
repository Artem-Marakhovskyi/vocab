import 'dart:io';
import 'package:vocab/model/existing_dict.dart';
import 'package:vocab/services/html_parser.dart';
import 'package:vocab/services/translator.dart';
import 'package:vocab/services/wordreference.api.dart';

class Context {
  final ExistingDict existingDict = ExistingDict(
      '${Directory.current.path}/../vocabulary/vocabulary-de.yaml');
  final HtmlParser htmlParser = HtmlParser();
  final WordReferenceApi api = WordReferenceApi();

  Translator? _translator;
  Translator get translator {
    if (_translator != null) {
      return _translator!;
    }
    return Translator(existingDict, htmlParser, api);
  }

  Future load() async {
    await existingDict.load();
  }
}
