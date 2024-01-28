import 'package:flutter/material.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomHeader.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class WhoAreUs extends StatelessWidget {
  const WhoAreUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Biz Kimiz?',
        ),
        toolbarHeight: screenHeight(context) * 0.09,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: CustomText(
            align: TextAlign.center,
            fontSize: 20,
            text:
                'Tek kişilik dev kadro olarak biz, kendimizden emin adımlarla geleceğe dönük projelerin hayata geçirilmesi noktasında gereken çabayı göstermeyi kendine amaç edinmiş bir grub olarak faaliyet göstermekteyiz. '),
      ),
    );
  }
}
