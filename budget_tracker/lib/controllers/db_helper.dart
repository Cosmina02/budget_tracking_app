import 'package:hive/hive.dart';

class DbHelper {
  late Box box;

  DbHelper() {
    openBox();
  }

  openBox() {
    box = Hive.box('money');
  }

  Future addData(
      int amount, DateTime date, String category, String type) async {
    var value = {
      'amount': amount,
      'date': date,
      'type': type,
      'category': category
    };
    box.add(value);
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
}
