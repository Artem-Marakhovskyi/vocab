import 'dart:io';

import 'package:args/args.dart';
import 'package:vocab/cases/args/args.dart';

class ArgsParser {
  static const String exitCommand = 'exit';
  static const String addCommand = 'add';
  static const String doctorCommand = 'doctor';
  static const String queryCommand = 'query';
  static const String helpCommand = 'help';
  static const String trainingCommand = 'training';
  static const String word = 'word';
  static const String words = 'words';
  static const String interactive = 'interactive';
  static const String file = 'file';
  static const String wordscount = 'wordscount';
  final ArgParser _parser = ArgParser();

  late final Map<String, String> _commandsHelp = <String, String>{};
  late final Map<String, Args? Function(ArgResults)> _matcher =
      <String, Args? Function(ArgResults)>{};

  ArgsParser() {
    _parser.addCommand(exitCommand);
    _commandsHelp[exitCommand] = "exit -> Type to exit";
    _matcher[exitCommand] = (args) {
      return ExitArgs();
    };

    _parser.addCommand(helpCommand);
    _matcher[helpCommand] = (args) {
      return IncorrectArgs(args, _commandsHelp.values.join('\r\n'));
    };

    var doctorParser = _parser.addCommand(doctorCommand);
    doctorParser.addOption(word, abbr: 'w', help: "Give a word to be fixed");
    _commandsHelp[doctorCommand] =
        '\r\n$doctorCommand -> Type to fix specific (all) terms \r\n${doctorParser.usage}';
    _matcher[doctorCommand] = (args) {
      if (!args.command!.wasParsed(word)) {
        return DoctorArgs();
      } else {
        return DoctorSpecificArgs(args.command![word]);
      }
    };

    var addParser = _parser.addCommand(addCommand);
    addParser.addOption(file,
        abbr: 'f',
        defaultsTo: 'input/input.yaml',
        help: 'Filepath to YAML file - batch method');
    addParser.addOption(interactive,
        abbr: 'i',
        valueHelp: 'Provide the word you would like to search for',
        help: 'Single word to be searched for');
    _commandsHelp[addCommand] =
        '\r\n$addCommand -> Type to add single (batch) words \r\n${addParser.usage}';
    _matcher[addCommand] = (args) {
      if (args.command!.wasParsed(file)) {
        return AddFilepathArgs(args.command![file]);
      }
      if (args.command!.wasParsed(interactive)) {
        return AddInteractiveArgs(args.command![interactive]);
      }
      return null;
    };

    var queryParser = _parser.addCommand(queryCommand);
    queryParser.addOption(word,
        abbr: 'w',
        help:
            'Search locally and show the word on the screen. If the word does not exist locally -> search on the Web');
    queryParser.addOption(words,
        help:
            'Search locally and show the words on the screen. If the word does not exist locally -> search on the Web');
    _commandsHelp[queryCommand] =
        '\r\n$queryCommand -> Type to query for a word(s) \r\n${queryParser.usage}';
    _matcher[queryCommand] = (args) {
      if (args.command!.wasParsed(word)) {
        return QueryWordArgs(args.command![word]);
      } else if (args.command!.wasParsed(words)) {
        return QueryWordsArgs(args.command![words].split(','));
      }
      return null;
    };

    var trainingParser = _parser.addCommand(trainingCommand);
    trainingParser.addOption(wordscount,
        abbr: 'w',
        defaultsTo: '30',
        help: 'Words count in this training session');
    _commandsHelp[trainingCommand] =
        '\r\n$trainingCommand -> Type to start training \r\n${trainingParser.usage}';
    _matcher[trainingCommand] = (args) {
      if (args.wasParsed(wordscount)) {
        var count = int.tryParse(args.command?[wordscount]);
        if (count != null) {
          return TrainingWordsCountArgs(count);
        }
      }
      return null;
    };
  }

  Args parse(List<String> args) {
    var result = _parser.parse(args);
    if (result.command?.name != null &&
        _matcher.containsKey(result.command!.name)) {
      var args = _matcher[result.command!.name]!.call(result);

      if (args != null) {
        return args;
      }
    }

    return IncorrectArgs(result, _commandsHelp.values.join('\r\n'));
  }
}
