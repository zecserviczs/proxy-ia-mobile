import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/stats_card.dart';
import '../../../core/widgets/quick_action_button.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Ouvrir les notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              // TODO: Ouvrir le profil utilisateur
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Salutation
            Text(
              'Bonjour, Commerçant ! 👋',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.textPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Voici un aperçu de votre activité aujourd\'hui',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Statistiques rapides
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: 'Ventes du jour',
                    value: '€2,450',
                    change: '+12%',
                    isPositive: true,
                    icon: Icons.trending_up,
                    color: AppTheme.successColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatsCard(
                    title: 'Produits vendus',
                    value: '45',
                    change: '+8%',
                    isPositive: true,
                    icon: Icons.shopping_bag,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: 'Stock faible',
                    value: '12',
                    change: '-3',
                    isPositive: false,
                    icon: Icons.warning,
                    color: AppTheme.warningColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatsCard(
                    title: 'Commandes',
                    value: '8',
                    change: '+2',
                    isPositive: true,
                    icon: Icons.shopping_cart,
                    color: AppTheme.secondaryColor,
                    ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Graphique des ventes
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ventes des 7 derniers jours',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '€${value.toInt()}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
                                return Text(
                                  days[value.toInt()],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 1200),
                              FlSpot(1, 1800),
                              FlSpot(2, 1400),
                              FlSpot(3, 2200),
                              FlSpot(4, 1900),
                              FlSpot(5, 2800),
                              FlSpot(6, 2450),
                            ],
                            isCurved: true,
                            color: AppTheme.primaryColor,
                            barWidth: 3,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: AppTheme.primaryColor.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Actions rapides
            Text(
              'Actions rapides',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                QuickActionButton(
                  title: 'Scanner produit',
                  icon: Icons.qr_code_scanner,
                  color: AppTheme.primaryColor,
                  onTap: () {
                    // TODO: Ouvrir le scanner
                  },
                ),
                QuickActionButton(
                  title: 'Ajouter produit',
                  icon: Icons.add_box,
                  color: AppTheme.successColor,
                  onTap: () {
                    // TODO: Ouvrir l'ajout de produit
                  },
                ),
                QuickActionButton(
                  title: 'Inventaire',
                  icon: Icons.inventory,
                  color: AppTheme.warningColor,
                  onTap: () {
                    // TODO: Ouvrir l'inventaire
                  },
                ),
                QuickActionButton(
                  title: 'Assistant IA',
                  icon: Icons.smart_toy,
                  color: AppTheme.accentColor,
                  onTap: () {
                    // TODO: Ouvrir l'assistant IA
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Produits populaires
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Produits populaires',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Voir tous les produits
                        },
                        child: const Text('Voir tout'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // TODO: Liste des produits populaires
                  const Text('Liste des produits à venir...'),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Action rapide (probablement scanner)
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
        ),
      ),
    );
  }
}







