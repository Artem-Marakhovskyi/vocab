import 'package:vocab/cases/use_case.dart';

class AddInteractiveUseCase extends UseCase {
  AddInteractiveUseCase(args) : super(args);

  @override
  Future execute() {
    return AddInteractiveUseCase(args).execute();
  }
}
