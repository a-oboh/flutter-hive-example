import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_reminder_app/core/models/inventory_model.dart';

class HomeModel with ChangeNotifier {
  String _inventoryBox = 'inventory';

  List _inventoryList = <Inventory>[];

  List get inventoryList => _inventoryList;

  addItem(Inventory inventory) async {
    var box = await Hive.openBox<Inventory>(_inventoryBox);

    box.add(inventory);

    print('added');

    notifyListeners();
  }

  getItem() async {
    final box = await Hive.openBox<Inventory>(_inventoryBox);

    _inventoryList = box.values.toList();

    notifyListeners();
  }

  updateItem(int index, Inventory inventory) {
    final box = Hive.box<Inventory>(_inventoryBox);

    box.putAt(index, inventory);

    notifyListeners();
  }

  deleteItem(int index) {
    final box = Hive.box<Inventory>(_inventoryBox);

    box.deleteAt(index);

    getItem();

    notifyListeners();
  }
}
