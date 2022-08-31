import 'package:firebase_tutorial/views/components/dialogs/dialog_notification_template.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogUnknownNotification extends ConsumerWidget {
  String title;
  String content;
  DialogUnknownNotification({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogNotificationTemplate(title: title, content: content, color: const Color(0xFF999999), imgLink: 'assets/images/Unknown.png');
  }
}