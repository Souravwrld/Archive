import 'package:flutter/material.dart';

import 'notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationServices notificationServices = NotificationServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: (){
                  notificationServices.sendNotification('This is a Tittle', 'This is a body');
                },
                child: const Text('Send Notification')
            ),
            ElevatedButton(
                onPressed: () async{
                  debugPrint('Notification Scheduled for ${DateTime.now().add(Duration(minutes: 1))}');
                  await NotificationServices().zonedScheduleNotification(
                      title: 'Scheduled Notification 333',
                      body: '${DateTime.now().add(Duration(minutes: 1))}',
                      scheduledNotificationDateTime: DateTime.now().add(Duration(minutes: 1)));                },
                child: const Text('Schedule Notification')
            ),
            ElevatedButton(
                onPressed: (){
                  notificationServices.stopNotifications(0);
                },
                child: const Text('Stop Notification')
            ),
          ],
        ),
      ),
    );
  }
}
