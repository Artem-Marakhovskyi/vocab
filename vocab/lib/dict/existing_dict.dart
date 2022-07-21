import 'dart:convert';

import 'package:vocab/dict/word_entity.dart';
import 'package:vocab/yaml/yaml.dart';
import 'package:yaml/yaml.dart';

class ExistingDict {
  final Yaml _yaml = Yaml();
  final String _filePath;

  List<WordEntity> words = [];
  String? lastUpdated;
  ExistingDict(this._filePath);

  Future load() async {
    var yaml = await Yaml().load(_filePath);

    if (yaml == null) {
      return;
    }

    lastUpdated = yaml['lastUpdated'];
    var wordList = (yaml['words'] as YamlList);
    for (var word in wordList) {
      var meanings = <Meaning>[];
      for (var meaningYaml in word['meanings'] as YamlList) {
        var src = meaningYaml['src'].toString();
        var mark = meaningYaml['mark'].toString();
        var engs = <String>[];
        for (var eng in meaningYaml['engs']) {
          engs.add(eng);
        }
        meanings.add(Meaning(src, engs, mark));
      }

      words.add(WordEntity(word['de'], meanings));
    }
  }

  void flushToJson() {
    var wordsList = [];
    for (var word in words) {
      wordsList.add({
        'de': word.de,
        'meanings': word.meanings.map((e) => {
              'src': e.de,
              'mark': e.mark,
              'dest': e.engs,
            })
      });
    }
    _yaml.write(_filePath,
        {'lastUpdated': DateTime.now().toString(), 'words': wordsList});
  }
}
