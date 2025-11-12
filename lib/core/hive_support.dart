import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:wldd/features/developers/model/offline_user_model.dart';
import 'package:wldd/features/developers/model/user_model.dart';

class HiveSupport {
  static const String userBoxName = "userBox";
  static const String favBoxName = "favouriteBox";

  static late Box<OfflineUserModel> userBox;
  static late Box<String> favouriteBox;

  static Future<void> initHive() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(OfflineUserModelAdapter());


    }

    userBox = await Hive.openBox<OfflineUserModel>(userBoxName);
    favouriteBox = await Hive.openBox<String>(favBoxName);
  }


  static Future<void> toggleFavourite(String id) async {
    if (favouriteBox.containsKey(id)) {
      await favouriteBox.delete(id);
    } else {
      await favouriteBox.put(id, id);
    }
  }

  static bool isFavourite(String id) {
    return favouriteBox.containsKey(id);
  }

  static List<String> getAllFavouriteIds() {
    return favouriteBox.values.toList();
  }

  static Future<void> clearAll() async {
    await userBox.clear();
    await favouriteBox.clear();
  }
}
