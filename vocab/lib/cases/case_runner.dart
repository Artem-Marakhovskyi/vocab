import 'dart:io';

import 'package:args/args.dart';
import 'package:vocab/cases/add_key_valye_filepath_use_case.dart';
import 'package:vocab/cases/doctor_use_case.dart';
import 'package:vocab/cases/incorrect_args_use_case.dart';
import 'package:vocab/cases/query_word_use_case.dart';
import 'package:vocab/cases/query_words_use_case.dart';
import 'package:vocab/cases/training_words_count_use_case.dart';
import 'package:vocab/cases/use_case.dart';

import '../context.dart';
import 'add_filepath_use_case.dart';
import 'add_interactive_use_case.dart';
import 'args/args.dart';
import 'args/args_parser.dart';
import 'doctor_force_use_case.dart';
import 'doctor_specific_use_case.dart';
import 'exit_use_case.dart';
import 'list_use_case.dart';

class CaseRunner {
  static final Context context = Context();
  final ArgsParser _parser = ArgsParser();
  List<String> _args = [];
  final Map<Type, UseCase Function(Args)> _argsMap = {
    ExitArgs: (args) => ExitUseCase(args),
    ListArgs: (args) => ListUseCase(args),
    AddKeyValueFilepathArgs: (args) => AddKeyValueFilepathUseCase(args),
    DoctorArgs: (args) => DoctorUseCase(args),
    DoctorForceArgs: (args) => DoctorForceUseCase(args),
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
    await context.load();

    do {
      var argsResult = _parser.parse(_args);
      var useCase = _argsMap[argsResult.runtimeType]!(argsResult);

      await useCase.execute();

      //var input = stdin.readLineSync();
      var input = 'exit';
      if (input != null) {
        _args = input.split(' ');
      } else {
        break;
      }
    } while (true);
  }
}
