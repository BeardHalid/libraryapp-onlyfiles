import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/pages/renewPassword/states/RenewPasswordStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomButton.dart';
import 'package:libraryapp/widgets/CustomHeader.dart';
import 'package:libraryapp/widgets/CustomTextFormField.dart';

class RenewPassword extends ConsumerStatefulWidget {
  const RenewPassword({super.key});

  @override
  ConsumerState<RenewPassword> createState() => _RenewPasswordState();
}

class _RenewPasswordState extends ConsumerState<RenewPassword> {
  var formKey = GlobalKey<FormState>();
  var emailTf = TextEditingController();
  var newPass = TextEditingController();
  var newPassConfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final newPassObsPrv = ref.watch(newPassObsProvider);
    final newPassObsPrvCnf = ref.watch(newPassObsProviderCnf);
    return Scaffold(
      appBar: CustomHeader(
        width: screenWidth(context),
        height: 120,
        hasSearch: false,
        headText: 'Şifremi Unuttum',
        showBackButton: true,
      ),
      body: Column(
        children: [
          verticalGap(50),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFormField(controller: emailTf, hintText: 'Email'),
                verticalGap(20),
                CustomTextFormField(
                  controller: newPass,
                  hintText: 'Yeni Şifre',
                  obsecureText: newPassObsPrv,
                  showPasswordIcon: true,
                  keyboardType: TextInputType.text,
                  onTap: () {
                    ref.read(newPassObsProvider.notifier).state =
                        !newPassObsPrv;
                  },
                ),
                verticalGap(20),
                CustomTextFormField(
                  controller: newPassConfirm,
                  hintText: 'Yeni Şifre Tekrar',
                  obsecureText: newPassObsPrvCnf,
                  showPasswordIcon: true,
                  keyboardType: TextInputType.text,
                  onTap: () {
                    ref.read(newPassObsProviderCnf.notifier).state =
                        !newPassObsPrvCnf;
                  },
                ),
              ],
            ),
          ),
          verticalGap(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  width: screenWidth(context) * 0.4,
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .where("email", isEqualTo: emailTf.text)
                        .get()
                        .then((users) {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: emailTf.text);
                    }).catchError((onError) {
                      print("Bir hata meydana geldi : $onError");
                    });
                  },
                  buttonText: "Şifreyi Yenile"),
              CustomButton(
                  width: screenWidth(context) * 0.4,
                  onTap: () {
                    setState(() {
                      emailTf.text = "";
                      newPass.text = "";
                      newPassConfirm.text = "";
                    });
                  },
                  buttonText: "Temizle")
            ],
          )
        ],
      ),
    );
  }
}
