import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:libraryapp/AppRoutes.dart';
import 'package:libraryapp/firebase/FirebaseOpts.dart';
import 'package:libraryapp/firebase/states/FirebaseStates.dart';
import 'package:libraryapp/pages/home/home/states/HomeStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomText.dart';
import 'package:libraryapp/widgets/CustomTextField.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomHeader extends StatelessWidget implements PreferredSize {
  final double width;
  final double height;
  final bool hasSearch;
  final TextEditingController? controller;
  final String? hintText;
  final String headText;
  final VoidCallback? suffixIconTap;
  final bool showBackButton;
  final bool showActions;
  const CustomHeader(
      {required this.width,
      required this.height,
      required this.hasSearch,
      this.controller,
      this.hintText,
      required this.headText,
      this.suffixIconTap,
      this.showBackButton = false,
      this.showActions = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: hasSearch ? height + 50 : height,
      child: Stack(
        children: [
          Container(
            width: width,
            height: hasSearch ? height : height - 25,
            padding: hasSearch ? null : const EdgeInsets.only(top: 30),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
              color: Colors.orangeAccent,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showBackButton
                      ? IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ))
                      : horizontalGap(100),
                  Text(
                    headText,

                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  showActions
                      ? Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.shoppingBox);
                                },
                                icon: const Icon(
                                  Icons.shopping_basket,
                                  color: Colors.white,
                                )),
                            Consumer(
                              builder: (context, ref, child) {
                                final userAuthPrv = ref.watch(userAuthProvider);
                                if (userAuthPrv.value != null) {
                                  return PopupMenuButton(
                                      onSelected: (value) {
                                        switch (value) {
                                          case 0:
                                            Navigator.pushNamed(
                                                context, AppRoutes.profile);
                                            break;
                                          case 2:
                                            FirebaseOpts.userSignOut();
                                            break;
                                          default:
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      itemBuilder: (context) {
                                        var popupList = <PopupMenuEntry>[];

                                        popupList.addAll([
                                          PopupMenuItem(
                                              value: 0,
                                              child: Row(children: [
                                                const Icon(
                                                    Icons.account_circle),
                                                horizontalGap(20),
                                                const CustomText(
                                                    text: 'Hesabı Görüntüle')
                                              ])),
                                          PopupMenuItem(
                                              value: 1,
                                              child: Row(children: [
                                                const Icon(Icons
                                                    .manage_accounts_sharp),
                                                horizontalGap(20),
                                                const CustomText(
                                                    text: 'Hesap Ayarları')
                                              ])),
                                          PopupMenuItem(
                                              value: 2,
                                              child: Row(children: [
                                                const Icon(Icons.no_accounts),
                                                horizontalGap(20),
                                                const CustomText(
                                                  text: 'Çıkış Yap',
                                                )
                                              ]))
                                        ]);
                                        return popupList;
                                      });
                                } else {
                                  return PopupMenuButton(
                                      onSelected: (value) {
                                        log(value.toString());
                                        Navigator.pushNamed(
                                            context, AppRoutes.profile);
                                      },
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      itemBuilder: (context) {
                                        var popupList = <PopupMenuEntry>[];

                                        popupList.addAll([
                                          PopupMenuItem(
                                              value: 0,
                                              child: Row(children: [
                                                const Icon(Icons
                                                    .account_circle_rounded),
                                                horizontalGap(20),
                                                const CustomText(
                                                  text: 'Giriş Yap',
                                                )
                                              ]))
                                        ]);
                                        return popupList;
                                      });
                                }
                              },
                            )
                          ],
                        )
                      : verticalGap(100),
                ]),
          ),
          hasSearch
              ? Positioned(
                  top: 85,
                  child: SizedBox(
                    width: screenWidth(context),
                    child: Consumer(
                      builder: (context, ref, child) {
                        return CustomTextField(
                          controller: controller!,
                          hintText: hintText!,
                          isSearch: true,
                          elevation: 5,
                          onChanged: (p0) {
                            ref.read(searchProvider.notifier).state = p0;
                          },
                          suffixIconTap: suffixIconTap,
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(width, height);
}
