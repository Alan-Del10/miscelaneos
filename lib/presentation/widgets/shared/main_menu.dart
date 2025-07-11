import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem(this.title, this.icon, this.route);
}

final menuItems = <MenuItem>[
  MenuItem('Giróscopio', Icons.download, '/gyroscope'),
  MenuItem('Acelerómetro', Icons.speed, '/accelerometer'),
  MenuItem('Magnetometro', Icons.explore_rounded, '/magnetometer'),
  MenuItem('Giróscopio Ball', Icons.sports_basketball, '/gyroscope-ball'),
  MenuItem('Brújula', Icons.explore, '/compass'),
  MenuItem('Pokedex', Icons.catching_pokemon, '/pokedex'),
  MenuItem('Background Process', Icons.storage_rounded, '/db-pokemons'),
  MenuItem('Biometrics', Icons.fingerprint, '/biometrics'),
  MenuItem('Location', Icons.pin_drop_outlined, '/location'),
  MenuItem('Map', Icons.map_outlined, '/map'),
  MenuItem('Controlled Map', Icons.control_camera_rounded, '/controlled-map'),
  MenuItem('Badge', Icons.notifications_active, '/badge'),
  MenuItem('Ad Full', Icons.ad_units_rounded, '/ad-fullscreen'),
  MenuItem('Ad Reward', Icons.price_change, '/ad-rewarded'),
];

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children:
          menuItems
              .map(
                (item) => HomeMenuItem(
                  title: item.title,
                  icon: item.icon,
                  route: item.route,
                ),
              )
              .toList(),
    );
  }
}

class HomeMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final List<Color> bgColors;

  const HomeMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
    this.bgColors = const [Colors.amberAccent, Colors.orange],
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: bgColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
