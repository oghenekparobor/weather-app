import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app_test_foodcourt/core/extension/context.dart';
import 'package:weather_app_test_foodcourt/core/storage/secure.dart';
import 'package:weather_app_test_foodcourt/core/widgets/notification.dart';
import 'package:weather_app_test_foodcourt/main.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
  StreamSubscription<ConnectivityResult> getConnectivity();
  void cancelInternetChecker();
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl({
    required this.storage,
  });

  final SecureStorage storage;

  @override
  Future<bool> isConnected() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  late StreamSubscription internetCheckerSubscription;
  bool isDeviceConnected = false;

  @override
  StreamSubscription<ConnectivityResult> getConnectivity() =>
      internetCheckerSubscription =
          Connectivity().onConnectivityChanged.listen((event) async {
        isDeviceConnected = await isConnected();
        final networkStatus = storage.getFrom('WEATHER_APP_NETWORK_STATUS');

        if (!isDeviceConnected) {
          if (networkStatus != 'NO_NETWORK') {
            storage.setTo('WEATHER_APP_NETWORK_STATUS', 'NO_NETWORK');
            navkey.currentContext!.notify.addNotification(
              const NotificationTile(
                message: 'Oops! It looks like you\'ve lost your connection',
                type: NotificationType.error,
              ),
            );
          }
        } else {
          if (networkStatus == 'NO_NETWORK') {
            storage.setTo('WEATHER_APP_NETWORK_STATUS', 'NETWORK_AVAILABLE');
            navkey.currentContext!.notify.removeNotification();

            navkey.currentContext!.notify.addNotification(
              const NotificationTile(
                message: 'Great news! Your connection is back',
              ),
            );
          }
        }
      });

  @override
  void cancelInternetChecker() {
    internetCheckerSubscription.cancel();
  }
}
