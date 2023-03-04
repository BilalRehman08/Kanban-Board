import 'package:stacked/stacked.dart';

class TimerViewModel extends StreamViewModel {
  DateTime? start;

  Stream<int> get duration async* {
    while (true) {
      if (start != null) {
        await Future.delayed(const Duration(seconds: 1));
        DateTime now = DateTime.now();

        yield start != null?now.difference(start!).inSeconds:0;
      } else {
        yield 0;
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  @override
  Stream<int> get stream => duration;
}
