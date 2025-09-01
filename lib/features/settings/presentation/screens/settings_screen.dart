import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Paramètres'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: const Center(
        child: Text(
          'Page Paramètres',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Commerce Proxi-IA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Tableau de bord'),
            onTap: () {
              Navigator.pop(context);
              context.go('/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2),
            title: const Text('Produits'),
            onTap: () {
              Navigator.pop(context);
              context.go('/products');
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Inventaire'),
            onTap: () {
              Navigator.pop(context);
              context.go('/inventory');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Commandes'),
            onTap: () {
              Navigator.pop(context);
              context.go( '/orders');
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Ventes'),
            onTap: () {
              Navigator.pop(context);
              context.go( '/sales');
            },
          ),
          ListTile(
            leading: const Icon(Icons.price_check),
            title: const Text('Tarification'),
            onTap: () {
              Navigator.pop(context);
              context.go( '/pricing');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètres'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: () {
              Navigator.pop(context);
              context.go( '/login');
            },
          ),
        ],
      ),
    );
  }
}
