import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/firebase/FirebaseOpts.dart';
import 'package:libraryapp/pages/register/states/RegisterStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomButton.dart';
import 'package:libraryapp/widgets/CustomHeader.dart';
import 'package:libraryapp/widgets/CustomText.dart';
import 'package:libraryapp/widgets/CustomTextField.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final TextEditingController tfEmail = TextEditingController();
  final TextEditingController tfPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final showHidePasswordPrv = ref.watch(showHidePasswordProvider);
    return Scaffold(
        appBar: CustomHeader(
          width: screenWidth(context),
          height: 120,
          hasSearch: false,
          headText: 'Kayıt Ol',
          showBackButton: true,
          showActions: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              verticalGap(20),
              const CustomText(
                text: '...Kayıt Ol...',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              verticalGap(80),
              CustomTextField(
                controller: tfEmail,
                hintText: 'E-Mail',
              ),
              verticalGap(50),
              CustomTextField(
                controller: tfPassword,
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
                    buttonText: 'Kayıt Ol',
                    width: screenWidth(context) * 0.4,
                    radius: 16,
                    onTap: () {
                      FirebaseOpts.signUp(
                          tfEmail.text, tfPassword.text, context);
                    },
                  ),
                  CustomButton(
                    buttonText: 'Temizle',
                    width: screenWidth(context) * 0.4,
                    radius: 16,
                    onTap: () {
                      setState(() {
                        tfEmail.text = '';
                        tfPassword.text = '';
                        ref.read(showHidePasswordProvider.notifier).state =
                            true;
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}
