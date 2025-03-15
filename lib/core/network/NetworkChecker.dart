import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class NetWorkChecker {
  Future<bool> get isConntected;
}

class Networkcheckerimpl implements NetWorkChecker {
  final InternetConnection internetConnection;

  Networkcheckerimpl(this.internetConnection);
  @override
  // TODO: implement isConntected
  Future<bool> get isConntected async =>
      await internetConnection.hasInternetAccess;
}
