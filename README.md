# 📱 Commerce Proxi-IA Mobile

Application mobile Flutter pour l'automatisation commerciale avec IA, complémentaire à la version web Angular.

## 🚀 **Fonctionnalités Principales**

### 🔐 **Authentification & Sécurité**
- Connexion sécurisée avec email/mot de passe
- Authentification biométrique (Face ID, Touch ID, empreinte)
- Gestion des sessions et tokens JWT
- Chiffrement local des données sensibles

### 📊 **Tableau de Bord Mobile**
- Statistiques en temps réel (ventes, produits, stock)
- Graphiques interactifs des performances
- Actions rapides (scanner, ajout produit, inventaire)
- Notifications push pour alertes importantes

### 📱 **Fonctionnalités Mobiles**
- Scanner de codes-barres et QR codes
- Prise de photos de produits
- Géolocalisation des magasins
- Mode hors ligne avec synchronisation
- Notifications push intelligentes

### 🤖 **Assistant IA Mobile**
- Chat conversationnel avec l'assistant IA
- Reconnaissance vocale pour les commandes
- Suggestions contextuelles
- Aide à la prise de décision

## 🛠️ **Technologies Utilisées**

- **Framework**: Flutter 3.10+
- **Langage**: Dart 3.0+
- **State Management**: Riverpod + Provider
- **Navigation**: Go Router
- **Stockage Local**: Hive + SharedPreferences
- **HTTP Client**: Dio + Retrofit
- **Charts**: FL Chart
- **UI Components**: Material Design 3
- **Biométrie**: Local Auth
- **Caméra**: Image Picker + Camera
- **QR Code**: Mobile Scanner

## 📋 **Prérequis**

### **Développement**
- Flutter SDK 3.10+
- Dart SDK 3.0+
- Android Studio (pour Android)
- Xcode (pour iOS, macOS uniquement)
- Git

### **Appareils Supportés**
- **Android**: API 21+ (Android 5.0+)
- **iOS**: iOS 12.0+
- **Tablettes**: Support complet iPad et Android

## 🚀 **Installation & Démarrage**

### 1. **Cloner le Projet**
```bash
git clone <repository>
cd mobile
```

### 2. **Installation des Dépendances**
```bash
flutter pub get
```

### 3. **Configuration**
```bash
# Créer le fichier .env (automatique avec le script)
cp .env.example .env
# Modifier les variables selon votre environnement
```

### 4. **Démarrage Automatique**
```bash
# Rendre le script exécutable
chmod +x scripts/start-mobile.sh

# Démarrer l'application
./scripts/start-mobile.sh
```

### 5. **Démarrage Manuel**
```bash
# Vérifier les appareils connectés
flutter devices

# Lancer sur un appareil spécifique
flutter run -d <device-id>

# Lancer avec hot reload
flutter run --hot
```

## 📱 **Structure du Projet**

```
lib/
├── core/                    # Code partagé
│   ├── theme/             # Thèmes et styles
│   ├── providers/         # Providers Riverpod
│   ├── services/          # Services (API, stockage, etc.)
│   ├── widgets/           # Widgets personnalisés
│   └── utils/             # Utilitaires
├── features/               # Fonctionnalités métier
│   ├── auth/              # Authentification
│   ├── dashboard/         # Tableau de bord
│   ├── products/          # Gestion des produits
│   ├── inventory/         # Gestion des stocks
│   ├── sales/             # Gestion des ventes
│   ├── scanner/           # Scanner de codes
│   └── assistant/         # Assistant IA
└── main.dart              # Point d'entrée
```

## 🔧 **Configuration**

### **Variables d'Environnement (.env)**
```env
# API Backend
API_BASE_URL=http://localhost:8080
API_TIMEOUT=30000

# Services
ENABLE_NOTIFICATIONS=true
ENABLE_BIOMETRICS=true
ENABLE_CAMERA=true

# Application
APP_NAME=Commerce Proxi-IA
APP_VERSION=1.0.0
DEBUG_MODE=true
```

### **Configuration Android**
- `android/app/build.gradle` : Configuration de build
- `android/app/src/main/AndroidManifest.xml` : Permissions
- Support API 21+ pour la compatibilité maximale

### **Configuration iOS**
- `ios/Runner/Info.plist` : Permissions et configuration
- Support iOS 12.0+
- Configuration Face ID et Touch ID

## 📊 **Fonctionnalités Détaillées**

### **Dashboard Mobile**
- **Statistiques en Temps Réel**
  - Ventes du jour
  - Produits vendus
  - Stock faible
  - Commandes en cours

- **Graphiques Interactifs**
  - Évolution des ventes
  - Performance par période
  - Comparaisons

- **Actions Rapides**
  - Scanner produit
  - Ajouter produit
  - Vérifier inventaire
  - Assistant IA

### **Scanner de Produits**
- **Codes-Barres**
  - Support EAN-13, UPC, Code 128
  - Reconnaissance automatique
  - Historique des scans

- **QR Codes**
  - Liens vers fiches produits
  - Informations de traçabilité
  - Actions rapides

- **Caméra**
  - Prise de photos haute qualité
  - Reconnaissance d'images
  - Stockage optimisé

### **Gestion des Stocks**
- **Inventaire Mobile**
  - Vérification rapide des stocks
  - Alertes de niveau bas
  - Suggestions de réapprovisionnement

- **Réception de Marchandises**
  - Scan des colis
  - Validation des quantités
  - Mise à jour automatique

### **Assistant IA Mobile**
- **Chat Conversationnel**
  - Interface intuitive
  - Historique des conversations
  - Suggestions contextuelles

- **Reconnaissance Vocale**
  - Commandes vocales
  - Dictée de notes
  - Recherche vocale

## 🧪 **Tests**

### **Tests Unitaires**
```bash
flutter test
```

### **Tests d'Intégration**
```bash
flutter test integration_test/
```

### **Tests de Performance**
```bash
flutter run --profile
flutter drive --profile --target=test_driver/app.dart
```

## 📦 **Build & Déploiement**

### **Build Android**
```bash
# Build debug
flutter build apk --debug

# Build release
flutter build apk --release

# Build bundle (recommandé)
flutter build appbundle --release
```

### **Build iOS**
```bash
# Build debug
flutter build ios --debug

# Build release
flutter build ios --release
```

### **Code Signing**
- **Android**: Configuration dans `android/app/build.gradle`
- **iOS**: Configuration dans `ios/Runner.xcodeproj`

## 🔍 **Débogage**

### **Flutter Inspector**
```bash
flutter run --debug
# Ouvrir Flutter Inspector dans VS Code ou Android Studio
```

### **Logs**
```bash
# Logs Flutter
flutter logs

# Logs spécifiques à l'appareil
adb logcat  # Android
xcrun simctl spawn booted log stream  # iOS
```

## 📚 **Documentation API**

L'application mobile communique avec le backend Spring Boot via REST API :

- **Base URL**: Configurée dans `.env`
- **Authentification**: JWT Bearer Token
- **Format**: JSON
- **Timeout**: 30 secondes par défaut

## 🤝 **Contribution**

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📄 **Licence**

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 🆘 **Support**

- **Issues**: GitHub Issues
- **Documentation**: Ce README
- **Wiki**: Documentation détaillée sur GitHub
- **Discussions**: GitHub Discussions

## 🔮 **Roadmap**

### **v1.1 (Q2 2024)**
- [ ] Mode hors ligne avancé
- [ ] Synchronisation multi-appareils
- [ ] Notifications push avancées

### **v1.2 (Q3 2024)**
- [ ] Support des tablettes
- [ ] Mode sombre personnalisé
- [ ] Widgets Android/iOS

### **v2.0 (Q4 2024)**
- [ ] Réalité augmentée pour l'inventaire
- [ ] Intelligence artificielle locale
- [ ] Support multi-langues

---

**Commerce Proxi-IA Mobile** - Votre commerce intelligent dans votre poche ! 📱✨







