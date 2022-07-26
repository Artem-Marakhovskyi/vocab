import 'dart:io';

import 'package:vocab/cases/args/args.dart';
import 'package:vocab/cases/use_case.dart';

import '../model/input_dict.dart';

class AddFilepathUseCase extends UseCase {
  AddFilepathArgs get arguments => args as AddFilepathArgs;
  AddFilepathUseCase(super.args);

  @override
  Future execute() async {
    var inputDict =
        InputDict('${Directory.current.path}/../${arguments.filepath}');
    await inputDict.load();

    await context.translator.loadTranslations(inputDict);
  }
}
