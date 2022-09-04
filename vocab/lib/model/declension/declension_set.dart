import 'package:vocab/yaml/yaml.dart';
import 'package:vocab/yaml/yaml_loader.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

class DeclensionSet {
  final String word;
  final String presentThirdFormSingle;
  final String pastThirdFormSingle;
  final String past;
  final List<String> translation;
  final List<String> present;
  final List<String> imperfect;
  final List<String> imperative;
  final List<String> presentSubj;
  final List<String> imperfSubj;
  final List<String> infinitiv;
  final List<String> participle;

  final Yaml _yaml = new Yaml();

  DeclensionSet(
      this.word,
      this.presentThirdFormSingle,
      this.pastThirdFormSingle,
      this.past,
      this.present,
      this.translation,
      this.imperative,
      this.imperfect,
      this.presentSubj,
      this.imperfSubj,
      this.infinitiv,
      this.participle);

  static DeclensionSet fromYaml(yaml) {
    return DeclensionSet(
        yaml['word'].toString(),
        yaml['presentThirdFormSingle'].toString(),
        yaml['pastThirdFormSingle'].toString(),
        yaml['past'].toString(),
        (yaml['present'] as YamlList)
            .map((element) => element.toString())
            .toList(),
        (yaml['translation'] as YamlList)
            .map((element) => element.toString())
            .toList(),
        (yaml['imperative'] as YamlList)
            .map((element) => element.toString())
            .toList(),
        (yaml['imperfect'] as YamlList)
            .map((element) => element.toString())
            .toList(),
        (yaml['presentSubj'] as YamlList)
            .map((element) => element.toString())
            .toList(),
        (yaml['imperfSubj'] as YamlList)
            .map((element) => element.toString())
            .toList(),
        (yaml['infinitiv'] as YamlList)
            .map((element) => element.toString())
            .toList(),
        (yaml['participle'] as YamlList)
            .map((element) => element.toString())
            .toList());
  }

  String toYaml() {
    return YAMLWriter().write({
      'word': word,
      'presentThirdFormSingle': presentThirdFormSingle,
      'pastThirdFormSingle': pastThirdFormSingle,
      'past': past,
      'present': present.toList(),
      'translation': translation,
      'imperative': imperative,
      'imperfect': imperfect,
      'presentSubj': presentSubj,
      'imperfSubj': imperfSubj,
      'infinitiv': infinitiv,
      'participle': participle
    });
  }
}
