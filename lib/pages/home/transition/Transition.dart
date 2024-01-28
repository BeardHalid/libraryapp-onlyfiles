import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/pages/home/categories/Categories.dart';
import 'package:libraryapp/pages/home/home/Home.dart';
import 'package:libraryapp/pages/home/myLibrary/MyLibrary.dart';
import 'package:libraryapp/pages/home/settings/Settings.dart';
import 'package:libraryapp/pages/home/transition/states/TransitionStates.dart';
import 'package:libraryapp/widgets/CustomButtomNav.dart';

class Transition extends ConsumerStatefulWidget {
  const Transition({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransitionState();
}

class _TransitionState extends ConsumerState<Transition> {
  var pagesList = const [Home(), MyLibrary(), Categories(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    final transPrv = ref.watch(transitionProvider);
    return Scaffold(
      body: pagesList[transPrv],
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
