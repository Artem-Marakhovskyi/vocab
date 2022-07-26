import 'package:vocab/cases/args/args.dart';

abstract class UseCase {
  final Args args;
  UseCase(this.args);
  Future execute();
}
