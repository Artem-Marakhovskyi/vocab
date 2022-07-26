import 'package:vocab/cases/args/args.dart';
import 'package:vocab/cases/case_runner.dart';
import 'package:vocab/context.dart';

abstract class UseCase {
  final Args args;
  late final Context context;
  UseCase(this.args) {
    context = CaseRunner.context;
  }
  Future execute();
}
