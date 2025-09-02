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
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  bool autoSyncEnabled = true;
  String selectedLanguage = 'Français';
  String selectedCurrency = 'EUR';
  double fontSize = 16.0;
  
  // Configuration de la boutique
  String shopName = 'Ma Boutique';
  String shopDescription = 'Boutique de commerce électronique';
  String shopAddress = '123 Rue de la Paix, 75001 Paris';
  String shopPhone = '+33 1 23 45 67 89';
  String shopEmail = 'contact@maboutique.com';
  String shopWebsite = 'www.maboutique.com';
  String shopLogo = '';
  String shopCategory = 'Électronique';
  bool shopOnline = true;
  String shopOpeningHours = '9h00 - 18h00';
  String shopTaxNumber = 'FR12345678901';
  String shopBankAccount = 'FR76 1234 5678 9012 3456 7890 123';

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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Configuration de la Boutique'),
          _buildShopConfigurationCard(),
          const SizedBox(height: 24),
          
          _buildSectionHeader('Informations de la Boutique'),
          _buildShopInfoSettings(),
          const SizedBox(height: 24),
          
          _buildSectionHeader('Contact et Localisation'),
          _buildContactSettings(),
          const SizedBox(height: 24),
          
          _buildSectionHeader('Paramètres Commerciaux'),
          _buildCommercialSettings(),
          const SizedBox(height: 24),
          
          _buildSectionHeader('Profil Utilisateur'),
          _buildUserProfileCard(),
          const SizedBox(height: 24),
          
          _buildSectionHeader('Préférences Générales'),
          _buildGeneralSettings(),
          const SizedBox(height: 24),
          
          _buildSectionHeader('Notifications'),
          _buildNotificationSettings(),
          const SizedBox(height: 24),
          
          _buildSectionHeader('Apparence'),
          _buildAppearanceSettings(),
          const SizedBox(height: 24),
          
          _buildSectionHeader('Données et Synchronisation'),
          _buildDataSettings(),
          const SizedBox(height: 24),
          
          _buildSectionHeader('Sécurité'),
          _buildSecuritySettings(),
          const SizedBox(height: 24),
          
          _buildSectionHeader('Support'),
          _buildSupportSettings(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildShopConfigurationCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.orange[100],
                  child: const Icon(Icons.store, size: 30, color: Colors.orange),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shopName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        shopDescription,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: shopOnline ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: shopOnline ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3)),
                        ),
                        child: Text(
                          shopOnline ? 'En ligne' : 'Hors ligne',
                          style: TextStyle(
                            color: shopOnline ? Colors.green : Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _editShopConfiguration,
                  icon: const Icon(Icons.edit, color: Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInfoChip(Icons.category, shopCategory, Colors.blue),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildInfoChip(Icons.access_time, shopOpeningHours, Colors.purple),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopInfoSettings() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildSettingTile(
            icon: Icons.store,
            title: 'Nom de la boutique',
            subtitle: shopName,
            onTap: _editShopName,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.description,
            title: 'Description',
            subtitle: shopDescription,
            onTap: _editShopDescription,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.category,
            title: 'Catégorie',
            subtitle: shopCategory,
            onTap: _selectShopCategory,
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            icon: Icons.online_prediction,
            title: 'Boutique en ligne',
            subtitle: 'Activer la vente en ligne',
            value: shopOnline,
            onChanged: (value) {
              setState(() {
                shopOnline = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactSettings() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildSettingTile(
            icon: Icons.location_on,
            title: 'Adresse',
            subtitle: shopAddress,
            onTap: _editShopAddress,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.phone,
            title: 'Téléphone',
            subtitle: shopPhone,
            onTap: _editShopPhone,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.email,
            title: 'Email',
            subtitle: shopEmail,
            onTap: _editShopEmail,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.language,
            title: 'Site web',
            subtitle: shopWebsite,
            onTap: _editShopWebsite,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.access_time,
            title: 'Heures d\'ouverture',
            subtitle: shopOpeningHours,
            onTap: _editOpeningHours,
          ),
        ],
      ),
    );
  }

  Widget _buildCommercialSettings() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildSettingTile(
            icon: Icons.receipt_long,
            title: 'Numéro de TVA',
            subtitle: shopTaxNumber,
            onTap: _editTaxNumber,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.account_balance,
            title: 'Compte bancaire',
            subtitle: '****7890',
            onTap: _editBankAccount,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.image,
            title: 'Logo de la boutique',
            subtitle: shopLogo.isEmpty ? 'Aucun logo' : 'Logo configuré',
            onTap: _uploadShopLogo,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.palette,
            title: 'Thème de la boutique',
            subtitle: 'Personnaliser l\'apparence',
            onTap: _customizeShopTheme,
          ),
        ],
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

  Widget _buildUserProfileCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue[100],
              child: const Icon(Icons.person, size: 30, color: Colors.blue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Admin Commerce',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'admin@commerce-proxi-ia.com',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: const Text(
                      'Administrateur',
                      style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _editProfile,
              icon: const Icon(Icons.edit, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildSettingTile(
            icon: Icons.language,
            title: 'Langue',
            subtitle: selectedLanguage,
            onTap: _selectLanguage,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.attach_money,
            title: 'Devise',
            subtitle: selectedCurrency,
            onTap: _selectCurrency,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.text_fields, color: Colors.blue),
            title: const Text('Taille de police'),
            subtitle: Text('${fontSize.toInt()}px'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Slider(
              value: fontSize,
              min: 12,
              max: 20,
              divisions: 8,
              onChanged: (value) {
                setState(() {
                  fontSize = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildSwitchTile(
            icon: Icons.notifications,
            title: 'Notifications push',
            subtitle: 'Recevoir des notifications',
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            icon: Icons.email,
            title: 'Notifications email',
            subtitle: 'Recevoir des emails',
            value: true,
            onChanged: (value) {},
          ),
          const Divider(height: 1),
          _buildSwitchTile(
            icon: Icons.sms,
            title: 'Notifications SMS',
            subtitle: 'Recevoir des SMS',
            value: false,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceSettings() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildSwitchTile(
            icon: Icons.dark_mode,
            title: 'Mode sombre',
            subtitle: 'Activer le thème sombre',
            value: darkModeEnabled,
            onChanged: (value) {
              setState(() {
                darkModeEnabled = value;
              });
            },
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.palette,
            title: 'Couleur du thème',
            subtitle: 'Bleu',
            onTap: _selectThemeColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDataSettings() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildSwitchTile(
            icon: Icons.sync,
            title: 'Synchronisation automatique',
            subtitle: 'Synchroniser les données automatiquement',
            value: autoSyncEnabled,
            onChanged: (value) {
              setState(() {
                autoSyncEnabled = value;
              });
            },
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.download,
            title: 'Sauvegarde des données',
            subtitle: 'Dernière sauvegarde: Aujourd\'hui',
            onTap: _backupData,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.delete_sweep,
            title: 'Effacer le cache',
            subtitle: 'Libérer l\'espace de stockage',
            onTap: _clearCache,
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildSettingTile(
            icon: Icons.lock,
            title: 'Changer le mot de passe',
            subtitle: 'Modifier votre mot de passe',
            onTap: _changePassword,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.fingerprint,
            title: 'Authentification biométrique',
            subtitle: 'Utiliser l\'empreinte digitale',
            onTap: _setupBiometric,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.security,
            title: 'Sécurité avancée',
            subtitle: 'Paramètres de sécurité',
            onTap: _securitySettings,
          ),
        ],
      ),
    );
  }

  Widget _buildSupportSettings() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildSettingTile(
            icon: Icons.help,
            title: 'Centre d\'aide',
            subtitle: 'FAQ et guides',
            onTap: _openHelp,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.contact_support,
            title: 'Contacter le support',
            subtitle: 'Obtenir de l\'aide',
            onTap: _contactSupport,
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.info,
            title: 'À propos',
            subtitle: 'Version 1.0.0',
            onTap: _showAbout,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  // Actions methods pour la boutique
  void _editShopConfiguration() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configuration rapide'),
        content: const Text('Configuration rapide de la boutique'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _editShopName() {
    _showEditDialog(
      'Nom de la boutique',
      shopName,
      (value) {
        setState(() {
          shopName = value;
        });
      },
    );
  }

  void _editShopDescription() {
    _showEditDialog(
      'Description de la boutique',
      shopDescription,
      (value) {
        setState(() {
          shopDescription = value;
        });
      },
    );
  }

  void _selectShopCategory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sélectionner la catégorie'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Électronique', 'Mode', 'Maison & Jardin', 'Sport', 'Livre', 'Automobile', 'Santé & Beauté'].map((category) {
            return ListTile(
              title: Text(category),
              leading: Radio<String>(
                value: category,
                groupValue: shopCategory,
                onChanged: (value) {
                  setState(() {
                    shopCategory = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _editShopAddress() {
    _showEditDialog(
      'Adresse de la boutique',
      shopAddress,
      (value) {
        setState(() {
          shopAddress = value;
        });
      },
    );
  }

  void _editShopPhone() {
    _showEditDialog(
      'Téléphone de la boutique',
      shopPhone,
      (value) {
        setState(() {
          shopPhone = value;
        });
      },
    );
  }

  void _editShopEmail() {
    _showEditDialog(
      'Email de la boutique',
      shopEmail,
      (value) {
        setState(() {
          shopEmail = value;
        });
      },
    );
  }

  void _editShopWebsite() {
    _showEditDialog(
      'Site web de la boutique',
      shopWebsite,
      (value) {
        setState(() {
          shopWebsite = value;
        });
      },
    );
  }

  void _editOpeningHours() {
    _showEditDialog(
      'Heures d\'ouverture',
      shopOpeningHours,
      (value) {
        setState(() {
          shopOpeningHours = value;
        });
      },
    );
  }

  void _editTaxNumber() {
    _showEditDialog(
      'Numéro de TVA',
      shopTaxNumber,
      (value) {
        setState(() {
          shopTaxNumber = value;
        });
      },
    );
  }

  void _editBankAccount() {
    _showEditDialog(
      'Compte bancaire',
      shopBankAccount,
      (value) {
        setState(() {
          shopBankAccount = value;
        });
      },
    );
  }

  void _uploadShopLogo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logo de la boutique'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.image, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('Sélectionner une image pour le logo'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fonctionnalité à implémenter')),
                      );
                    },
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galerie'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fonctionnalité à implémenter')),
                      );
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Caméra'),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  void _customizeShopTheme() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thème de la boutique'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Personnaliser l\'apparence de votre boutique'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildThemeOption('Bleu', Colors.blue),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildThemeOption('Vert', Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildThemeOption('Orange', Colors.orange),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildThemeOption('Violet', Colors.purple),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(String name, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  void _showEditDialog(String title, String currentValue, Function(String) onSave) {
    final controller = TextEditingController(text: currentValue);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Entrez $title',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$title mis à jour')),
              );
            },
            child: const Text('Sauvegarder'),
          ),
        ],
      ),
    );
  }

  // Actions methods
  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le profil'),
        content: const Text('Fonctionnalité à implémenter'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _selectLanguage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sélectionner la langue'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Français', 'English', 'Español'].map((lang) {
            return ListTile(
              title: Text(lang),
              leading: Radio<String>(
                value: lang,
                groupValue: selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _selectCurrency() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sélectionner la devise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['EUR', 'USD', 'CAD'].map((currency) {
            return ListTile(
              title: Text(currency),
              leading: Radio<String>(
                value: currency,
                groupValue: selectedCurrency,
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _selectThemeColor() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité à implémenter')),
    );
  }

  void _backupData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sauvegarde en cours...')),
    );
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Effacer le cache'),
        content: const Text('Êtes-vous sûr de vouloir effacer le cache ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache effacé')),
              );
            },
            child: const Text('Effacer'),
          ),
        ],
      ),
    );
  }

  void _changePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité à implémenter')),
    );
  }

  void _setupBiometric() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité à implémenter')),
    );
  }

  void _securitySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité à implémenter')),
    );
  }

  void _openHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité à implémenter')),
    );
  }

  void _contactSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité à implémenter')),
    );
  }

  void _showAbout() {
    showAboutDialog(
      context: context,
      applicationName: 'Commerce Proxi-IA',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.business, size: 48),
      children: [
        const Text('Application de gestion commerciale avec IA'),
        const SizedBox(height: 16),
        const Text('Développé avec Flutter et Spring Boot'),
      ],
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
