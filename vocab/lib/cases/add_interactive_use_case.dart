import 'package:vocab/cases/query_word_use_case.dart';
import 'package:vocab/cases/use_case.dart';

class AddInteractiveUseCase extends UseCase {
  AddInteractiveUseCase(args) : super(args);

  @override
  Future execute() {
    return QueryWordUseCase(args).execute();
  }
}
