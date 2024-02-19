import 'dart:io';


class CheckInternet {


// Method to check connectivity
  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

// Stream that emits network status changes
  Stream<bool> networkStatusStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 3)); // Polling interval
      yield await checkConnection();
    }
  }


}