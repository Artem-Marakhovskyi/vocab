import 'package:vocab/model/declension/declension_set.dart';
import 'package:vocab/yaml/yaml.dart';
import 'package:yaml/yaml.dart';

class DeclensionDict {
  final _yaml = new Yaml();
  final String filePath;
  final List<DeclensionSet> terms = [];

  DeclensionDict(this.filePath);

  Future load() async {
    var yaml = await Yaml().load(filePath);
    YamlList words = yaml['dict'];
    for (var word in words) {
      terms.add(DeclensionSet.fromYaml(word));
    }
  }

  void upsert(DeclensionSet set) {
    if (!terms.any((element) => element.word == set.word)) {
      terms.add(set);
    }

    _yaml.write(filePath, {
      'lastUpdated': DateTime.now().toString(),
      'dict': terms.map((e) => e.toYaml()).toList()
    });
  }
}
