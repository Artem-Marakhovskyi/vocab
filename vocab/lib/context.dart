import 'dart:io';
import 'package:vocab/model/declension/declension_dict.dart';
import 'package:vocab/model/translation/existing_dict.dart';
import 'package:vocab/services/declension/declension.api.dart';
import 'package:vocab/services/declension/declension.html.parser.dart';
import 'package:vocab/services/declension/declensioner.dart';
import 'package:vocab/services/translation/html_parser.dart';
import 'package:vocab/services/input_stream.dart';
import 'package:vocab/services/translation/translator.dart';
import 'package:vocab/services/wordreference.api.dart';

class Context {
  final ExistingTranslationDict existingDict = ExistingTranslationDict(
      '${Directory.current.path}/../vocabulary/vocabulary-de.yaml');
  final DeclensionDict declensionDict =
      DeclensionDict('${Directory.current.path}/../vocabulary/decl-de.yaml');

  final HtmlParser htmlParser = HtmlParser();
  final DeclensionHtmlParser declHtmlParser = DeclensionHtmlParser();

  final WordReferenceApi api = WordReferenceApi();
  final DeclensionApi declApi = DeclensionApi();

  final InputStream input = InputStream();

  Declensioner? _declensioner;
  Declensioner get declensioner {
    _declensioner ??= Declensioner(declHtmlParser, declApi, declensionDict);
    return _declensioner!;
  }

  Translator? _translator;
  Translator get translator {
    if (_translator != null) {
      return _translator!;
    }
    return Translator(existingDict, htmlParser, api);
  }

  Future load() async {
    await existingDict.load();
    await declensionDict.load();
  }
}
