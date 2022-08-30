import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_example_mobile_app/web_socket/fake_web_socket_client.dart';

final webSocketClientProvider = Provider((ref) {
  return FakeWebSocketClient();
});

final counterProvider =
    StreamProvider.autoDispose.family<int, int>((ref, start) {
  final wsClient = ref.watch(webSocketClientProvider);
  return wsClient.getCounterStream(start);
});

class CounterPage extends ConsumerWidget {
  const CounterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final AsyncValue<int> counter = ref.watch(counterProvider(5));

    return Scaffold(
      appBar: AppBar(
        title: const Text('CounterPage'),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(counterProvider(5));
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
          )
        ],
      ),
      body: Center(
        child: Text(
          counter
              .when(
                data: (int value) => value,
                error: (Object e, _) => e,
                loading: () => 0,
              )
              .toString(),
          style: textTheme.displayMedium,
        ),
      ),
    );
  }
}
