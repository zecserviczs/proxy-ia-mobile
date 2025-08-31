#!/bin/bash

echo "📱 Démarrage de l'application mobile Commerce Proxi-IA..."

set -e

# Couleurs pour les logs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Vérification des prérequis
check_prerequisites() {
    log_info "Vérification des prérequis..."
    
    if ! command -v flutter &> /dev/null; then
        log_error "Flutter n'est pas installé. Veuillez l'installer depuis https://flutter.dev"
        exit 1
    fi
    
    if ! command -v dart &> /dev/null; then
        log_error "Dart n'est pas installé avec Flutter"
        exit 1
    fi
    
    # Vérifier la version de Flutter
    FLUTTER_VERSION=$(flutter --version | grep "Flutter" | awk '{print $2}')
    log_info "Version Flutter détectée: $FLUTTER_VERSION"
    
    # Vérifier les appareils connectés
    log_info "Vérification des appareils connectés..."
    DEVICES=$(flutter devices)
    echo "$DEVICES"
    
    if ! echo "$DEVICES" | grep -q "connected"; then
        log_warning "Aucun appareil connecté. Lancement de l'émulateur..."
        start_emulator
    fi
    
    log_success "Prérequis vérifiés"
}

# Démarrer un émulateur
start_emulator() {
    log_info "Démarrage d'un émulateur..."
    
    # Vérifier si Android Studio est installé
    if command -v emulator &> /dev/null; then
        # Lister les émulateurs disponibles
        AVAILABLE_EMULATORS=$(emulator -list-avds)
        if [ -n "$AVAILABLE_EMULATORS" ]; then
            FIRST_EMULATOR=$(echo "$AVAILABLE_EMULATORS" | head -n 1)
            log_info "Démarrage de l'émulateur: $FIRST_EMULATOR"
            emulator -avd "$FIRST_EMULATOR" &
            sleep 30  # Attendre que l'émulateur démarre
        else
            log_warning "Aucun émulateur Android disponible"
        fi
    else
        log_warning "Émulateur Android non trouvé. Veuillez installer Android Studio"
    fi
}

# Installation des dépendances
install_dependencies() {
    log_info "Installation des dépendances Flutter..."
    
    cd "$(dirname "$0")/.."
    
    # Nettoyer et obtenir les dépendances
    flutter clean
    flutter pub get
    
    log_success "Dépendances installées"
}

# Vérification de la configuration
check_configuration() {
    log_info "Vérification de la configuration..."
    
    # Vérifier la configuration Android
    if [ -d "android" ]; then
        log_info "Configuration Android détectée"
    fi
    
    # Vérifier la configuration iOS
    if [ -d "ios" ]; then
        log_info "Configuration iOS détectée"
    fi
    
    # Vérifier les variables d'environnement
    if [ -f ".env" ]; then
        log_info "Fichier .env détecté"
    else
        log_warning "Fichier .env non trouvé. Création d'un fichier d'exemple..."
        create_env_file
    fi
    
    log_success "Configuration vérifiée"
}

# Créer un fichier .env d'exemple
create_env_file() {
    cat > .env << EOF
# Configuration API Commerce Proxi-IA
API_BASE_URL=http://localhost:8080
API_TIMEOUT=30000

# Configuration des services
ENABLE_NOTIFICATIONS=true
ENABLE_BIOMETRICS=true
ENABLE_CAMERA=true

# Configuration de l'application
APP_NAME=Commerce Proxi-IA
APP_VERSION=1.0.0
DEBUG_MODE=true
EOF
    
    log_info "Fichier .env créé avec la configuration par défaut"
}

# Démarrage de l'application
start_application() {
    log_info "Démarrage de l'application..."
    
    # Vérifier les appareils à nouveau
    DEVICES=$(flutter devices)
    if echo "$DEVICES" | grep -q "connected"; then
        log_success "Appareil connecté détecté"
        
        # Lancer l'application
        log_info "Lancement de l'application sur l'appareil..."
        flutter run --hot
    else
        log_error "Aucun appareil connecté. Impossible de lancer l'application"
        log_info "Conseils:"
        log_info "1. Connectez un appareil physique via USB"
        log_info "2. Démarrez un émulateur Android"
        log_info "3. Démarrez un simulateur iOS (macOS uniquement)"
        exit 1
    fi
}

# Fonction principale
main() {
    echo "=================================="
    echo "  Démarrage Mobile Commerce Proxi-IA"
    echo "=================================="
    
    check_prerequisites
    install_dependencies
    check_configuration
    start_application
}

# Gestion des erreurs
trap 'log_error "Erreur lors du démarrage. Code: $?"' ERR

# Exécution du script
main "$@"







