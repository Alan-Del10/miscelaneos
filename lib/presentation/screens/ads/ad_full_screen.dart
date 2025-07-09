import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AdFullScreen extends ConsumerWidget {
  const AdFullScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final interstitialAdAsync = ref.watch(adInterstitalProvider);

    ref.listen(adInterstitalProvider, (previous, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;

      next.value!.show();
    });

    if (interstitialAdAsync.isLoading) {
      return const Scaffold(body: Center(child: Text('Cargando anuncio')));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Ad Full Screen')),
      body: Center(child: Text('Ya puedes regresar o ver esta pantalla')),
    );
  }
}
