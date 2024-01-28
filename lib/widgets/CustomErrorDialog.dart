import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class CustomErrorDialog extends StatefulWidget {
  final Widget content;
  const CustomErrorDialog({super.key, required this.content});

  @override
  State<CustomErrorDialog> createState() => CustomErrorDialogState();
}

class CustomErrorDialogState extends State<CustomErrorDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 20));

    scale = Tween(begin: -20.0, end: 20.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.mirror();
    Future.delayed(const Duration(milliseconds: 300), () {
      controller.reset();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(controller.isDismissed ? 0.0 : scale.value, 0.0),
      child: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: const Center(child: Text('Hata')),
        content: widget.content,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tamam'))
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
