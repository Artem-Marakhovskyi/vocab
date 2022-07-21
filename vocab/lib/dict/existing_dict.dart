import 'dart:convert';

import 'package:vocab/dict/word_entity.dart';
import 'package:vocab/yaml/yaml.dart';
import 'package:yaml/yaml.dart';

class ExistingDict {
  final Yaml _yaml = Yaml();
  final String _filePath;
  final List<WordEntity> words = [];
  final List<String> brokenWords = [];
  String? lastUpdated;
  ExistingDict(this._filePath);

  Future load() async {
    var yaml = await Yaml().load(_filePath);

    if (yaml == null) {
      return;
    }

    lastUpdated = yaml['lastUpdated'];

    var brokensYaml = yaml['broken'];
    if (brokensYaml != null) {
      var brokens = (brokensYaml as YamlList);
      for (var brokenWord in brokens) {
        brokenWords.add(brokenWord.toString());
      }
    }

    var wordList = (yaml['words'] as YamlList);
    for (var word in wordList) {
      var meanings = <Meaning>[];
      for (var meaningYaml in word['meanings'] as YamlList) {
        var src = meaningYaml['src'].toString();
        var mark = meaningYaml['mark'].toString();
        var engs = <String>[];
        for (var eng in meaningYaml['dest']) {
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
        'meanings': word.meanings
            .map((e) => {
                  'src': e.src,
                  'mark': e.mark,
                  'dest': e.dests,
                })
            .toList()
      });
    }
    _yaml.write(_filePath, {
      'lastUpdated': DateTime.now().toString(),
      'words': wordsList,
      'broken': brokenWords
    });
  }
}
