import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:vocab/cases/case_runner.dart';
import 'package:vocab/model/existing_dict.dart';
import 'package:vocab/yaml/yaml.dart';

import '../lib/cases/args/args_parser.dart';
import '../lib/context.dart';

void main(List<String> arguments) async {
  var runner = CaseRunner(arguments);
  await runner.run();
}
