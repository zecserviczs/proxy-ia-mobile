import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/api_service.dart';

class PricingScreen extends ConsumerStatefulWidget {
  const PricingScreen({super.key});

  @override
  ConsumerState<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends ConsumerState<PricingScreen> {
  List<Map<String, dynamic>> pricing = [];
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadPricing();
  }

  Future<void> _loadPricing() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      await Future.delayed(Duration(seconds: 1));
      
      setState(() {
        pricing = [
          {
            'id': 1,
            'productName': 'iPhone 15 Pro',
            'currentPrice': 1199.99,
            'previousPrice': 1299.99,
            'discount': 7.7,
            'category': 'Électronique',
            'lastUpdated': '2024-01-15T10:30:00Z'
          },
          {
            'id': 2,
            'productName': 'MacBook Pro M3',
            'currentPrice': 2499.99,
            'previousPrice': 2499.99,
            'discount': 0.0,
            'category': 'Électronique',
            'lastUpdated': '2024-01-14T14:20:00Z'
          },
          {
            'id': 3,
            'productName': 'AirPods Pro',
            'currentPrice': 249.99,
            'previousPrice': 279.99,
            'discount': 10.7,
            'category': 'Audio',
            'lastUpdated': '2024-01-15T16:45:00Z'
          },
          {
            'id': 4,
            'productName': 'iPad Air',
            'currentPrice': 599.99,
            'previousPrice': 599.99,
            'discount': 0.0,
            'category': 'Tablette',
            'lastUpdated': '2024-01-13T09:15:00Z'
          },
          {
            'id': 5,
            'productName': 'Apple Watch Series 9',
            'currentPrice': 399.99,
            'previousPrice': 429.99,
            'discount': 7.0,
            'category': 'Montre connectée',
            'lastUpdated': '2024-01-15T11:30:00Z'
          }
        ];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Erreur lors du chargement des prix: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Tarification'),
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(error!, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _loadPricing, child: const Text('Réessayer')),
          ],
        ),
      );
    }

    if (pricing.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.price_check_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Aucun prix trouvé', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadPricing,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pricing.length,
        itemBuilder: (context, index) {
          final price = pricing[index];
          final discount = price['discount'] as double;
          final hasDiscount = discount > 0;
          
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          price['productName'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (hasDiscount)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red.withOpacity(0.3)),
                          ),
                          child: Text(
                            '-${discount.toStringAsFixed(1)}%',
                            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${price['currentPrice'].toStringAsFixed(2)}€',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                            if (hasDiscount)
                              Text(
                                '${price['previousPrice'].toStringAsFixed(2)}€',
                                style: TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: _buildInfoChip(Icons.category, price['category'], Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildInfoChip(Icons.update, 'Mis à jour: ${_formatDate(price['lastUpdated'])}', Colors.purple),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
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
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètres'),
            onTap: () {
              Navigator.pop(context);
              context.go( '/settings');
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
