import 'package:vocab/cases/query_word_use_case.dart';
import 'package:vocab/cases/use_case.dart';

import 'args/args.dart';

class QueryWordsUseCase extends UseCase {
  QueryWordsArgs get arguments => args as QueryWordsArgs;
  QueryWordsUseCase(super.args);

  @override
  Future execute() async {
    for (var word in arguments.words) {
      await QueryWordUseCase(QueryWordArgs(word)).execute();
    }
  }
}
