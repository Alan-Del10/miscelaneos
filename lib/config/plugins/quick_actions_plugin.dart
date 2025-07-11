import 'package:miscelaneos/config/config.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsPlugin {
  static registerActions() {
    final QuickActions quickActions = const QuickActions();

    quickActions.initialize((shortcutType) {
      switch (shortcutType) {
        case 'biometrics':
          router.push('/biometrics');
          break;
        case 'compass':
          router.push('/compass');
          break;
        case 'pokemons':
          router.push('/pokedex');
          break;
        case 'maps':
          router.push('/controlled-map');
          break;
        default:
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'biometrics',
        localizedTitle: 'Biometrics',
        icon: 'finger',
      ),
      const ShortcutItem(
        type: 'compass',
        localizedTitle: 'Compass',
        icon: 'compass',
      ),
      const ShortcutItem(
        type: 'pokemons',
        localizedTitle: 'Pokemons',
        icon: 'pokemons',
      ),
      const ShortcutItem(
        type: 'maps',
        localizedTitle: 'Maps',
        icon: 'charmander',
      ),
    ]);
  }
}
