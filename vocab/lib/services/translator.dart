import 'package:colorize/colorize.dart';
import 'package:vocab/model/input_dict.dart';
import 'package:vocab/model/word_entity.dart';
import 'package:vocab/services/wordreference.api.dart';

import '../model/existing_dict.dart';
import 'html_parser.dart';

class Translator {
  final ExistingDict _existingDict;
  final HtmlParser _parser;
  final WordReferenceApi _api;

  Translator(this._existingDict, this._parser, this._api) {}

  Future loadTranslations(InputDict inputDict) async {
    for (var term in inputDict.terms) {
      if (_existingDict.containsTerm(term)) {
        continue;
      }
      await addTranslation(inputDict.srcLang, inputDict.destLang, term);
    }
  }

  Future<WordEntity?> addTranslation(
      String srcLang, String destLang, String term) async {
    var html = await _api.getHtml(srcLang, destLang, term);
    var word = _parser.processHtml(html);
    _existingDict.add(word, term);
    await _existingDict.commit();

    if (word == null) {
      color('Term $term cannot be translated', front: Styles.YELLOW);
    } else {
      color(word.toString(), front: Styles.GREEN);
    }

    return word;
  }
}
