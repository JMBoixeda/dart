import 'dart:math';

const int interval = 5;

/// Sample linear data type.
class PVProduction {
  final int hour;
  final int minutes;
  var production;

  PVProduction(
    this.hour,
    this.minutes,
    this.production,
  );

  /// Create random data.
  static List<PVProduction> createRandomData() {
    final random = Random();
    final int segments = (24 * (60 / interval)).toInt();
    var lastRandom = 0;

    final data = List<PVProduction>.generate(segments, (i) {
      final h = i ~/ (60 / interval);
      final m = (((i - (h * (60 / interval))) * interval)).toInt();
      var seed = 0;
      if (h < 6) {
        seed = 3;
      } else if (h < 8) {
        seed = 10;
      } else if (h < 10) {
        seed = 60;
      } else if (h < 16) {
        seed = 100;
      } else if (h < 18) {
        seed = 20;
      } else if (h < 20) {
        seed = 10;
      } else {
        seed = 5;
      }

      var nextRandom = random.nextInt(seed);
      if (h < 6) {
        lastRandom = nextRandom;
      } else if (h < 16) {
        if (nextRandom < lastRandom) {
          lastRandom = min<int>(100, nextRandom + lastRandom);
        } else {
          lastRandom = nextRandom;
        }
      } else {
        if (nextRandom > lastRandom) {
          lastRandom = max<int>(0, (nextRandom - lastRandom) ~/ 2);
        } else {
          lastRandom = nextRandom;
        }
      }
      return PVProduction(h, m, lastRandom);
    });

    var list = List<int>.generate(10, (i) => i + 1);
    var f1, f2, f3, f4;
    list.map((i) {
      if ((i - 2) < 0) {
        f1 = 0;
      } else {
        f1 = data[i - 2].production;
      }
      if ((i - 1) < 0) {
        f2 = 0;
      } else {
        f2 = data[i - 1].production;
      }
      if ((i + 1) >= data.length) {
        f3 = 0;
      } else {
        f3 = data[i + 1].production;
      }
      if ((i + 2) >= data.length) {
        f4 = 0;
      } else {
        f4 = data[i + 2].production;
      }
      data[i].production =
          (1 / 16) * (f1 + f2 + data[i].production + f3 + f4);
    });
    return data;
  }
}
