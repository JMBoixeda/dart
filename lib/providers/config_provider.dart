import 'package:flutter/material.dart';

import 'package:emc2/helpers/db_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:emc2/models/config.dart';

class ConfigProvider with ChangeNotifier {
  Config config = Config(
    id: '',
    showEngagement: true,
  );

  List<Config> _items = [];

  bool showEngagement() {
    return config.showEngagement;
  }

  Future<void> addConfig(
    bool showEngagement,
  ) async {
    final newConfig = Config(
      id: DateTime.now().toString(),
      showEngagement: showEngagement,
    );

    String showInDB = showEngagement ? 'TRUE' : 'FALSE';
    config = newConfig;
    notifyListeners();
    DBHelper.insert('config', {
      'id': newConfig.id,
      'showengage': showInDB,
    });
  }

  Future<void> fetchAndSetConfig() async {
    final dataList = await DBHelper.getData('config');
    _items = dataList
        .map(
          (item) => Config(
            id: item['id'],
            showEngagement: item['showengage'] == 'TRUE' ? true : false,
          ),
        )
        .toList();
    config = _items[0];
    notifyListeners();
  }
}
