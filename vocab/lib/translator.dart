import 'dart:io';

import 'package:vocab/dict/existing_dict.dart';
import 'package:vocab/dict/input/input_dict.dart';
import 'package:vocab/html/html_parser.dart';
import 'package:vocab/network/wordreference.api.dart';

class Translator {
  final InputDict _inputDict;
  final ExistingDict existingDict;
  final HtmlParser parser;
  final WordReferenceApi api;

  Translator(this._inputDict, this.existingDict, this.parser, this.api) {}

  Future loadTranslations() async {
    for (var term in existingDict.brokenWords) {
      print('fixing broken: $term');
      loadTranslation(term);
    }

    for (var term in _inputDict.terms) {
      if (existingDict.containsTerm(term)) {
        continue;
      }
      print('working on: $term');
      await loadTranslation(term);
      existingDict.flushToJson();
    }
  }

  Future loadTranslation(String term) async {
    var html = await api.getHtml(_inputDict.srcLang, _inputDict.destLang, term);
    var word = parser.processHtml(html);
    if (word == null) {
      print('\t$term - broken');
      existingDict.addBroken(term);
    } else {
      print('\t$term - success');
      existingDict.addWord(word);
    }
  }
}
