import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/pages/home/transition/states/TransitionStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class CustomBottomNav extends ConsumerWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrv = ref.watch(colorProvider);
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              alignment: Alignment.center,
              width: screenWidth(context),
              height: screenHeight(context) * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orangeAccent),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        iconTexts.length,
                        (index) => CustomNavigationBarItem(
                              onTap: () {
                                ref.read(transitionProvider.notifier).state =
                                    index;

                                ref.read(colorProvider.notifier).state = index;
                              },
                              icon: icons[index],
                              iconText: iconTexts[index],
                              selectedColor: colorPrv == index
                                  ? Colors.white
                                  : Colors.black,
                            ))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var iconTexts = ["Anasayfa", "Kütüphanem", "Kategoriler", "Ayarlar"];
var icons = [Icons.home, Icons.library_books, Icons.category, Icons.settings];

class CustomNavigationBarItem extends StatelessWidget {
  const CustomNavigationBarItem(
      {required this.onTap,
      required this.icon,
      required this.iconText,
      required this.selectedColor,
      super.key});

  final IconData icon;
  final String iconText;
  final VoidCallback? onTap;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              icon,
              color: selectedColor,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomText(
            text: iconText,
            color: selectedColor,
          ),
        ],
      ),
    );
  }
}
