import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider example

// 1ずつ値を増加させるためのカウンターProvider
final counterProvider = StateProvider<int>((ref) => 0);

// カウンターの値を2倍にした値を提供するProvider
final doubleCounterProvider = Provider<int>((ref) {
  final count = ref.watch(counterProvider);
  return count * 2;
});

// Widget Example
class ProviderPage extends ConsumerWidget {
  const ProviderPage({
    super.key,
  });

  static const String title = 'ProviderPage';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // doubleCounterProvider を読み取る
    // counterProvider の状態が更新されるとdoubleCounterProvider も変更され、再構築される
    final doubleCount = ref.watch(doubleCounterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: SafeArea(
          child: Center(
        child: Column(children: [
          Text(
            '2倍されたカウント値:',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          // doubleConterProvider の値を表示
          Text(
            '$doubleCount',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          ElevatedButton(
            // counterProviderの値を+1する
            onPressed: () => ref.read(counterProvider.notifier).update(
                  (state) => state + 1,
                ),
            child: const Text('Increase Count'),
          ),
        ]),
      )),
    );
  }
}
