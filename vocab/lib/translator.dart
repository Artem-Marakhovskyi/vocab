import 'dart:convert';

import 'package:vocab/dict/existing_dict.dart';
import 'package:yaml/yaml.dart';
import 'package:http/http.dart' as http;

import 'yaml/yaml.dart';

class Translator {
  final Yaml _yaml;
  final String _baseUrl = 'http://www.wordreference.com/{src}{dest}/{word}';
  final Map<String, String> _partOfSpeeches = <String, String>{
    "noun": "NOUN",
    "verb": "VERB",
    "adj": "ADJ",
    "adv": "ADVERB"
  };

  final ExistingDict existingDict;

  Translator(this._yaml, this.existingDict) {}

  Future loadTranslations(String filepath) async {
    var yaml = await _yaml.load(filepath);

    var langReadyUrl = _baseUrl
        .replaceAll("{src}", yaml['src'] as String)
        .replaceAll('{dest}', yaml['dest'] as String);

    YamlList verbs = yaml['words']['verbs'];

    for (var item in verbs) {
      print(item);
      var response =
          await http.get(Uri.parse(langReadyUrl.replaceAll('{word}', item)));

      print(response.body);
      var s = response.body;
      break;
      // for (var j in jObj) {
      //   existingDict.addVerb(j);
      // }
    }

    // existingDict.flushToJson();
  }
}
