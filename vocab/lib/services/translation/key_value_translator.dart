import 'package:vocab/model/input/input_dict_key_value.dart';
import 'package:vocab/model/translation/existing_dict.dart';
import 'package:vocab/model/translation/word_entity.dart';

class KeyValueTranslator {
  final ExistingTranslationDict _existingDict;

  KeyValueTranslator(this._existingDict) {}

  Future loadTranslations(InputDictKeyValue inputDict) async {
    for (var key in inputDict.dict.keys) {
      var meaning = Meaning(key, inputDict.dict[key]!, '');
      _existingDict.add(
          TranslationWordEntity(key, [meaning],
              DateTime.fromMicrosecondsSinceEpoch(0), 0, 0, DateTime.now()),
          key);
    }
    await _existingDict.commit();
  }
}
