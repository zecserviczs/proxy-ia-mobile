import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications = 
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notifications.initialize(initializationSettings);
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'commerce_channel',
      'Commerce Notifications',
      channelDescription: 'Notifications pour l\'application Commerce Proxi-IA',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notifications.show(id, title, body, platformChannelSpecifics);
  }

  static Future<void> showStockAlert(String productName, int quantity) async {
    await showNotification(
      id: 1,
      title: 'Stock faible',
      body: 'Le produit $productName a un stock de $quantity unités',
    );
  }

  static Future<void> showOrderNotification(String orderId) async {
    await showNotification(
      id: 2,
      title: 'Nouvelle commande',
      body: 'Commande #$orderId reçue',
    );
  }

  static Future<void> showSalesNotification(double amount) async {
    await showNotification(
      id: 3,
      title: 'Vente enregistrée',
      body: 'Vente de €${amount.toStringAsFixed(2)} enregistrée',
    );
  }
}
