import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'notification_item.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final List<NotificationItem> notifications = [];

  Future<void> initialise() async {
    // Demander la permission de recevoir des notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Utilisateur autorisé à recevoir des notifications');
    } else {
      print('L\'utilisateur n\'a pas autorisé les notifications');
    }

    // Abonner au topic 'adminNotifications' uniquement si ce n'est pas sur le web
    if (!kIsWeb) {
      _firebaseMessaging.subscribeToTopic('adminNotifications');
    }

    // Gérer les messages reçus lorsque l'application est en premier plan
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notifications.add(NotificationItem(
        title: message.notification?.title ?? "Nouveau Client",
        message: message.notification?.body ?? "Un nouveau client s'est inscrit.",
      ));
    });

    // Gérer les messages reçus lorsque l'application est en arrière-plan ou terminée
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      notifications.add(NotificationItem(
        title: message.notification?.title ?? "Nouveau Client",
        message: message.notification?.body ?? "Un nouveau client s'est inscrit.",
      ));
    });
  }

  List<NotificationItem> getNotifications() {
    return notifications;
  }
}
