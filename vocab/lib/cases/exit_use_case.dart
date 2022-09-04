import 'dart:io';

import 'package:vocab/cases/use_case.dart';

class ExitUseCase extends UseCase {
  ExitUseCase(args) : super(args);

  @override
  Future execute() {
    exit(0);
  }
}
