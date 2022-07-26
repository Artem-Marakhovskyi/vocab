import 'package:colorize/colorize.dart';
import 'package:vocab/cases/args/args.dart';
import 'package:vocab/cases/use_case.dart';

class IncorrectArgsUseCase extends UseCase {
  IncorrectArgsUseCase(super.args);

  @override
  Future execute() {
    color((args as IncorrectArgs).usage, front: Styles.YELLOW);

    return Future.value();
  }
}
