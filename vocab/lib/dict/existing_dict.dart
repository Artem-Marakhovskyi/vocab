import 'dart:convert';

import 'package:vocab/dict/word_entity.dart';
import 'package:vocab/yaml/yaml.dart';
import 'package:yaml/yaml.dart';

class ExistingDict {
  final Yaml _yaml = Yaml();
  final String _filePath;
  final List<WordEntity> _words = [];
  final List<String> _brokenWords = [];
  String? lastUpdated;
  ExistingDict(this._filePath);

  List<String> get brokenWords => [..._brokenWords];

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
        _brokenWords.add(brokenWord.toString());
      }
    }

    var wordList = (yaml['words'] as YamlList);
    for (var word in wordList) {
      var meanings = <Meaning>[];
      for (var meaningYaml in word['meanings'] as YamlList) {
        var src = meaningYaml['src'].toString();
        var mark = meaningYaml['mark'].toString();
        var engs = <String>[];
        try {
          for (var eng in meaningYaml['dest']) {
            engs.add(eng);
          }
        } catch (r) {
          print(r);
        }
        meanings.add(Meaning(src, engs, mark));
      }

      _words.add(WordEntity(word['de'], meanings));
    }
  }

  void addBroken(String term) {
    if (_brokenWords.contains(term)) {
      return;
    }

    _brokenWords.add(term);
  }

  void addWord(WordEntity wordEntity) {
    _brokenWords.remove(wordEntity.de);
    _words.add(wordEntity);
  }

  bool containsTerm(String term) =>
      _words.any((element) => element.de == term) ||
      _brokenWords.contains(term);

  void flushToJson() {
    var wordsList = [];
    for (var word in _words) {
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
      'broken': _brokenWords
    });
  }
}
