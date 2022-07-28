import 'dart:convert';

import 'package:vocab/model/word_entity.dart';
import 'package:vocab/yaml/yaml.dart';
import 'package:yaml/yaml.dart';

class ExistingDict {
  final Yaml _yaml = Yaml();
  final String _filePath;
  final List<WordEntity> words = [];
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

      var lastAttempt = DateTime.fromMicrosecondsSinceEpoch(0);
      if (word['last_attempt'] != null) {
        DateTime.parse(word['last_attempt']);
      }
      var success = word['success_attempts'] ?? 0;
      var totalAttempts = word['total_attempts'] ?? 0;

      words.add(WordEntity(
          word['de'], meanings, lastAttempt, success, totalAttempts));
    }
  }

  void replace(WordEntity word) {
    if (words.any((x) => x.de == word.de)) {
      words.removeAt(words.indexWhere((element) => element.de == word.de));
      words.add(word);
    }
  }

  void addBroken(String term) {
    if (_brokenWords.contains(term)) {
      return;
    }

    _brokenWords.add(term);
  }

  void add(WordEntity? wordEntity, String term) {
    if (wordEntity == null) {
      addBroken(term);
    } else {
      addWord(wordEntity);
    }
  }

  void addWord(WordEntity wordEntity) {
    _brokenWords.remove(wordEntity.de);
    words.add(wordEntity);
  }

  bool containsTerm(String term) =>
      words.any((element) => element.de == term) || _brokenWords.contains(term);

  Future commit() {
    var wordsList = [];

    for (var word in words) {
      wordsList.add({
        'de': word.de,
        'last_attempt': word.lastAttempt.toString(),
        'success_attempts': word.success,
        'total_attempts': word.totalAttempts,
        'meanings': word.meanings
            .map((e) => {
                  'src': e.src,
                  'mark': e.mark,
                  'dest': e.dests,
                })
            .toList()
      });
    }
    return _yaml.write(_filePath, {
      'lastUpdated': DateTime.now().toString(),
      'words': wordsList,
      'broken': _brokenWords
    });
  }
}
