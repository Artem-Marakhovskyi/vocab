import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:vocab/cases/case_runner.dart';
import 'package:vocab/model/existing_dict.dart';

import '../lib/cases/args/args_parser.dart';
import 'context.dart';

Context context = Context();

void main(List<String> arguments) async {
  await context.load();

  // var inputDict =
  //     InputDict('${Directory.current.path}/../vocabulary/input.yaml');
  // await inputDict.load();

  var runner = CaseRunner(arguments);
  await runner.run();
}
