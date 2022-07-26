import 'dart:io';

import 'package:args/args.dart';
import 'package:vocab/cases/doctor_use_case.dart';
import 'package:vocab/cases/incorrect_args_use_case.dart';
import 'package:vocab/cases/query_word_use_case.dart';
import 'package:vocab/cases/query_words_use_case.dart';
import 'package:vocab/cases/training_words_count_use_case.dart';
import 'package:vocab/cases/use_case.dart';

import 'add_filepath_use_case.dart';
import 'add_interactive_use_case.dart';
import 'args/args.dart';
import 'args/args_parser.dart';
import 'doctor_specific_use_case.dart';
import 'exit_use_case.dart';

class CaseRunner {
  final ArgsParser _parser = ArgsParser();
  List<String> _args = [];
  final Map<Type, UseCase Function(Args)> _argsMap = {
    DoctorArgs: (args) => DoctorUseCase(args),
    DoctorSpecificArgs: (args) => DoctorSpecificUseCase(args),
    IncorrectArgs: (args) => IncorrectArgsUseCase(args),
    AddInteractiveArgs: (args) => AddInteractiveUseCase(args),
    AddFilepathArgs: (args) => AddFilepathUseCase(args),
    QueryWordArgs: (args) => QueryWordUseCase(args),
    QueryWordsArgs: (args) => QueryWordsUseCase(args),
    TrainingWordsCountArgs: (args) => TrainingWordsCountUseCase(args),
  };

  CaseRunner(List<String> initialArgs) {
    _args = initialArgs;
  }
  Future run() async {
    do {
      var argsResult = _parser.parse(_args);
      var useCase = _argsMap[argsResult.runtimeType]!(argsResult);

      await useCase.execute();

      var input = stdin.readLineSync();
      if (input != null) {
        _args = input.split(' ');
      } else {
        break;
      }
    } while (true);
  }
}
