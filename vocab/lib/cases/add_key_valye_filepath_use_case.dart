import 'dart:io';

import 'package:vocab/cases/args/args.dart';
import 'package:vocab/cases/use_case.dart';
import 'package:vocab/model/input_dict_key_value.dart';
import 'package:vocab/services/key_value_translator.dart';

class AddKeyValueFilepathUseCase extends UseCase {
  AddKeyValueFilepathArgs get arguments => args as AddKeyValueFilepathArgs;
  AddKeyValueFilepathUseCase(Args args) : super(args);
  @override
  Future execute() async {
    var inputDict =
        InputDictKeyValue('${Directory.current.path}/../${arguments.filepath}');
    await inputDict.load();

    await KeyValueTranslator(context.existingDict).loadTranslations(inputDict);
  }
}
