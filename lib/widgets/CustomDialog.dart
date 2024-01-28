import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;
  final double animationBegin;
  final double animationEnd;
  final int duration;

  const CustomDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.actions,
      this.animationBegin = -800.0,
      this.animationEnd = 0.0,
      this.duration = 200});

  @override
  State<CustomDialog> createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> translate;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    translate = Tween(begin: -800.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, translate.value),
      child: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Center(child: Text(widget.title)),
        content: widget.content,
        actions: widget.actions,
        actionsAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
