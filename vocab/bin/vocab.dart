import 'package:vocab/cases/case_runner.dart';

void main(List<String> arguments) async {
  var runner = CaseRunner(arguments);
  await runner.run();
}
