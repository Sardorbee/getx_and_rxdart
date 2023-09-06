import 'package:rxdart/rxdart.dart';

class MultiplicationController {
  final _firstNumber = BehaviorSubject<int>();
  final _secondNumber = BehaviorSubject<int>();
  final _result = BehaviorSubject<int>();
  MultiplicationController() {
    Rx.combineLatest2(_firstNumber, _secondNumber, (a, b) => a * b)
        .listen((result) {
      _result.add(result);
    });
  }

  void updateFirstNumber(int number) {
    _firstNumber.add(number);
  }

  void updateSecondNumber(int number) {
    _secondNumber.add(number);
  }

  Stream<int> get resultStream => _result.stream;
  void dispose() {
    _firstNumber.close();
    _secondNumber.close();
    _result.close();
  }
}
