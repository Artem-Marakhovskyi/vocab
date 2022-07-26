import 'package:vocab/model/input_dict.dart';
import 'package:vocab/services/wordreference.api.dart';

import '../model/existing_dict.dart';
import 'html_parser.dart';

class Translator {
  final ExistingDict existingDict;
  final HtmlParser parser;
  final WordReferenceApi api;

  Translator(this.existingDict, this.parser, this.api) {}

  Future loadTranslations(InputDict inputDict) async {
    for (var term in existingDict.brokenWords) {
      print('fixing broken: $term');
      await loadTranslation(inputDict, term);
    }

    for (var term in inputDict.terms) {
      if (existingDict.containsTerm(term)) {
        continue;
      }
      print('working on: $term');
      await loadTranslation(inputDict, term);
      existingDict.flushToJson();
    }
  }

  Future loadTranslation(InputDict inputDict, String term) async {
    var html = await api.getHtml(inputDict.srcLang, inputDict.destLang, term);
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
