import 'dart:io';
import 'package:vocab/model/existing_dict.dart';
import 'package:vocab/services/parser/definition_html_parser.dart';
import 'package:vocab/services/tools/input_stream.dart';
import 'package:vocab/services/translator.dart';
import 'package:vocab/services/api/wordreference.api.dart';

class Context {
  final ExistingDict existingDict = ExistingDict(
      '${Directory.current.path}/../vocabulary/vocabulary-de.yaml');
  final DefinitionHtmlParser htmlParser = DefinitionHtmlParser();
  final WordReferenceApi api = WordReferenceApi();
  final InputStream input = InputStream();

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
