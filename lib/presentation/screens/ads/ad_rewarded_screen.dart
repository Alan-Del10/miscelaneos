import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AdRewardedScreen extends ConsumerWidget {
  const AdRewardedScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final rewardedAdAsync = ref.watch(adRewardedProvider);
    final adPoints = ref.watch(adPointsProvider);

    ref.listen(adRewardedProvider, (previouse, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;

      next.value!.show(
        onUserEarnedReward: (ad, reward) {
          ref
              .read(adPointsProvider.notifier)
              .update((state) => state + reward.amount.toInt());
        },
      );
    });

    if (rewardedAdAsync.isLoading) {
      return const Scaffold(body: Center(child: Text('Cargando anuncio')));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Ad Rewarded Screen')),
      body: Center(child: Text('Puntos actuales: $adPoints')),
    );
  }
}
