import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/api_service.dart';

class SalesScreen extends ConsumerStatefulWidget {
  const SalesScreen({super.key});

  @override
  ConsumerState<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends ConsumerState<SalesScreen> {
  List<Map<String, dynamic>> sales = [];
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadSales();
  }

  Future<void> _loadSales() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      await Future.delayed(Duration(seconds: 1));
      
      setState(() {
        sales = [
          {
            'id': 1,
            'productName': 'iPhone 15 Pro',
            'quantity': 5,
            'unitPrice': 1199.99,
            'totalAmount': 5999.95,
            'saleDate': '2024-01-15T10:30:00Z',
            'customerName': 'Jean Dupont'
          },
          {
            'id': 2,
            'productName': 'MacBook Pro M3',
            'quantity': 2,
            'unitPrice': 2499.99,
            'totalAmount': 4999.98,
            'saleDate': '2024-01-14T14:20:00Z',
            'customerName': 'Marie Martin'
          },
          {
            'id': 3,
            'productName': 'AirPods Pro',
            'quantity': 10,
            'unitPrice': 249.99,
            'totalAmount': 2499.90,
            'saleDate': '2024-01-15T16:45:00Z',
            'customerName': 'Pierre Durand'
          },
          {
            'id': 4,
            'productName': 'iPad Air',
            'quantity': 3,
            'unitPrice': 599.99,
            'totalAmount': 1799.97,
            'saleDate': '2024-01-13T09:15:00Z',
            'customerName': 'Sophie Leroy'
          },
          {
            'id': 5,
            'productName': 'Apple Watch Series 9',
            'quantity': 8,
            'unitPrice': 399.99,
            'totalAmount': 3199.92,
            'saleDate': '2024-01-15T11:30:00Z',
            'customerName': 'Thomas Moreau'
          }
        ];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Erreur lors du chargement des ventes: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Ventes'),
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
            ElevatedButton(onPressed: _loadSales, child: const Text('Réessayer')),
          ],
        ),
      );
    }

    if (sales.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Aucune vente trouvée', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadSales,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sales.length,
        itemBuilder: (context, index) {
          final sale = sales[index];
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
                          sale['productName'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.withOpacity(0.3)),
                        ),
                        child: Text(
                          '${sale['totalAmount'].toStringAsFixed(2)}€',
                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoChip(Icons.person, sale['customerName'], Colors.blue),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildInfoChip(Icons.inventory_2, '${sale['quantity']} unités', Colors.orange),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoChip(Icons.euro, '${sale['unitPrice'].toStringAsFixed(2)}€/unité', Colors.green),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildInfoChip(Icons.calendar_today, _formatDate(sale['saleDate']), Colors.purple),
                      ),
                    ],
                  ),
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
