import 'package:flutter_riverpod_example_mobile_app/web_socket/web_socket_client.dart';

class FakeWebSocketClient implements WebSocketClient {
  @override
  Stream<int> getCounterStream([int start = 0]) async* {
    int i = start;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      yield i++;
    }
  }
}
