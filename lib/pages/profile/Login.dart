import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/AppRoutes.dart';
import 'package:libraryapp/firebase/FirebaseOpts.dart';
import 'package:libraryapp/pages/profile/states/ProfileStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomButton.dart';
import 'package:libraryapp/widgets/CustomProgressIndicator.dart';
import 'package:libraryapp/widgets/CustomSnackBar.dart';
import 'package:libraryapp/widgets/CustomText.dart';
import 'package:libraryapp/widgets/CustomTextField.dart';

class Login extends ConsumerStatefulWidget {
  Login({super.key});

  @override
  ConsumerState<Login> createState() => _ConsumerStateLogin();
}

class _ConsumerStateLogin extends ConsumerState<Login> {
  late TextEditingController _signUpEmail;
  late TextEditingController _password;
  @override
  void initState() {
    super.initState();
    _signUpEmail = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final showHidePasswordPrv = ref.watch(showHidePasswordProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalGap(20),
          const CustomText(
            text: '...Giriş Yap...',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          verticalGap(80),
          CustomTextField(
            controller: _signUpEmail,
            hintText: 'E-Mail',
          ),
          verticalGap(50),
          CustomTextField(
            controller: _password,
            hintText: 'Şifre',
            suffixIcon: Icons.remove_red_eye_rounded,
            obsecureText: showHidePasswordPrv,
            suffixIconTap: () {
              ref.read(showHidePasswordProvider.notifier).state =
                  !showHidePasswordPrv;
            },
          ),
          verticalGap(70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                buttonText: 'Giriş Yap',
                width: screenWidth(context) * 0.4,
                radius: 16,
                onTap: () {
                  BuildContext? dialogContext;
                  showDialog(
                      barrierColor: Colors.transparent,
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        dialogContext = context;
                        return const CustomProgressIndicator();
                      });
                  Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      FirebaseOpts.signIn(_signUpEmail.text, _password.text)
                          .then((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(8.0),
                                content: CustomText(
                                  text: 'Başarıyla giriş yapıldı!',
                                  color: Colors.white,
                                )));
                      }).catchError((error) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(8.0),
                                content: CustomText(
                                  text: 'Bir hata meydana geldi!',
                                  color: Colors.white,
                                )));
                      });
                      if (dialogContext != null) {
                        Navigator.pop(dialogContext!);
                      }
                    },
                  );
                },
              ),
              CustomButton(
                buttonText: 'Şifremi Unuttum',
                width: screenWidth(context) * 0.4,
                radius: 16,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.renewPassword);
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: CustomButton(
              buttonText: 'Kayıt Ol',
              width: screenWidth(context),
              radius: 16,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.register);
              },
            ),
          ),
        ],
      ),
    );
  }
}
