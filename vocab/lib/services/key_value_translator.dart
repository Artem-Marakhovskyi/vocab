import 'package:colorize/colorize.dart';
import 'package:vocab/model/input_dict.dart';
import 'package:vocab/model/word_entity.dart';
import 'package:vocab/services/wordreference.api.dart';

import '../model/existing_dict.dart';
import '../model/input_dict_key_value.dart';

class KeyValueTranslator {
  final ExistingDict _existingDict;

  KeyValueTranslator(this._existingDict) {}

  Future loadTranslations(InputDictKeyValue inputDict) async {
    for (var key in inputDict.dict.keys) {
      var meaning = Meaning(key, inputDict.dict[key]!, '');
      _existingDict.add(
          WordEntity(key, [meaning], DateTime.fromMicrosecondsSinceEpoch(0), 0,
              0, DateTime.now()),
          key);
    }
    await _existingDict.commit();
  }
}
