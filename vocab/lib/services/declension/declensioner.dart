import 'package:colorize/colorize.dart';
import 'package:vocab/model/declension/declension_dict.dart';
import 'package:vocab/model/declension/declension_set.dart';
import 'package:vocab/services/declension/declension.api.dart';

import 'declension.html.parser.dart';

class Declensioner {
  final DeclensionDict _dict;
  final DeclensionHtmlParser _parser;
  final DeclensionApi _api;

  Declensioner(this._parser, this._api, this._dict);

  Future<DeclensionSet?> getDeclension(String word) async {
    var html = await _api.getHtml(word);
    var declension = _parser.processHtml(html);

    if (declension == null) {
      color("Couldn't find proper declension", front: Styles.YELLOW);
      return null;
    }

    _dict.upsert(declension);

    return declension;
  }
}
