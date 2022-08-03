import 'package:yaml/yaml.dart';

import '../yaml/yaml.dart';

class InputDict {
  final String filePath;
  final List<String> terms = [];

  String destLang = '';
  String srcLang = '';

  InputDict(this.filePath);

  Future load() async {
    var yaml = await Yaml().load(filePath);
    YamlList words = yaml['words'];
    for (var word in words) {
      terms.add(word);
    }
    srcLang = yaml['src'] as String;
    destLang = yaml['dest'] as String;

    assert(destLang.isNotEmpty);
    assert(srcLang.isNotEmpty);
    assert(terms.isNotEmpty);
  }
}
