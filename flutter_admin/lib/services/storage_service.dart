import 'package:flutter_admin/models/user.dart';
import 'package:localstorage/localstorage.dart';

class StorageService {
  static final StorageService instance = StorageService._internal();

  factory StorageService() {
    return instance;
  }

  StorageService._internal();

  Future<String> getAccessToken() async {
    await LocalStorage('laf').ready;
    return LocalStorage('laf').getItem("jwt");
  }

  Future<User?> getUser() async {
    await LocalStorage('laf').ready;
    String str = LocalStorage('laf').getItem("user") ?? "";

    if (str != "") return userFromJson(str);
    return null;
  }

  void setUser(User user) {
    LocalStorage('laf').setItem("jwt", user.accessToken);
    LocalStorage('laf').setItem("user", userToJson(user));
  }

  void clear() {
    LocalStorage('laf').clear();
  }
}
