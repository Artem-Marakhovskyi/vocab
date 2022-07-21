import 'package:vocab/dict/verb_entity.dart';
import 'package:vocab/yaml/yaml.dart';
import 'package:yaml/yaml.dart';

class ExistingDict {
  final Yaml _yaml = Yaml();
  final String _filePath;

  List<WordEntity> verbs = [];
  String? lastUpdated;
  ExistingDict(this._filePath);

  Future load() async {
    var yaml = await Yaml().load(_filePath);

    if (yaml == null) {
      return;
    }

    lastUpdated = yaml['lastUpdated'];
    var verbList = (yaml['verbs'] as YamlList);
    for (var verb in verbList) {
      var syns = <String>[];
      for (var syn in verb['synonyms'] as YamlList) {
        syns.add(syn);
      }
      verbs.add(
          WordEntity(verb['de'], verb['en'], verb['part_of_speech'], syns));
    }
  }

  void addVerb(dynamic j) {
    var de = j['l1_text'];
    var en = j['l2_text'];

    if (verbs
        .where((element) => element.en == en && element.de == de)
        .isEmpty) {
      verbs.add(WordEntity(j['l1_text'], j['l2_text'], j['wortart'],
          j['synonyme1'].toString().split(',')));
    }
  }

  void flushToJson() {
    var verbsList = [];
    for (var verb in verbs) {
      verbsList.add({
        'de': verb.de,
        'en': verb.en,
        'part_of_speech': verb.partOfSpeech,
        'synonyms': verb.synonyms,
      });
    }
    _yaml.write(_filePath,
        {'lastUpdated': DateTime.now().toString(), 'verbs': verbsList});
  }
}
