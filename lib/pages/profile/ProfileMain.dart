import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/firebase/states/FirebaseStates.dart';
import 'package:libraryapp/pages/profile/Login.dart';
import 'package:libraryapp/pages/profile/ProfileDetails.dart';
import 'package:libraryapp/pages/profile/states/ProfileStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomHeader.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class ProfileMain extends ConsumerWidget {
  const ProfileMain({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAuthPrv = ref.watch(userAuthProvider);
    return PopScope(
      onPopInvoked: (didPop) {
        if (userAuthPrv.value != null) {
          ref.invalidate(profileDetailsProvider);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profil Bilgileri',
          ),
          toolbarHeight: screenHeight(context) * 0.09,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: userAuthPrv.when(
            data: (data) {
              if (data != null) {
                final userDet = ref.watch(profileDetailsProvider(data.uid));
                log(userDet.hasValue.toString());
                return userDet.when(
                  data: (user) {
                    return ProfileDetails(user: user, userId: data.uid);
                  },
                  error: (error, stackTrace) => const Center(
                    child: CustomText(text: 'Bir hata meydana geldi!'),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Login();
              }
            },
            error: (error, stackTrace) => Center(
                  child: CustomText(
                    text: error.toString(),
                    fontSize: 20,
                  ),
                ),
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
