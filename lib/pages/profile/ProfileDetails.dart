import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/classes/Address.dart';
import 'package:libraryapp/classes/Users.dart';
import 'package:libraryapp/firebase/FirebaseOpts.dart';
import 'package:libraryapp/mobx/MobxCbCheck.dart';
import 'package:libraryapp/pages/profile/states/ProfileStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomAvatar.dart';
import 'package:libraryapp/widgets/CustomButton.dart';
import 'package:libraryapp/widgets/CustomDropDownButton.dart';
import 'package:libraryapp/widgets/CustomText.dart';
import 'package:libraryapp/widgets/CustomTextFormField.dart';

class ProfileDetails extends ConsumerStatefulWidget {
  final Users user;
  final String userId;
  ProfileDetails({super.key, required this.user, required this.userId});

  @override
  ConsumerState<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends ConsumerState<ProfileDetails> {
  var cbCheck = CbCheck();

  var genders = ["Erkek", "Kadın"];

  var formKey = GlobalKey<FormState>();

  late TextEditingController _name;
  late TextEditingController _surname;
  late TextEditingController _username;
  late TextEditingController _fullAddress;
  late TextEditingController _zipcode;
  late TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _surname = TextEditingController();
    _username = TextEditingController();
    _fullAddress = TextEditingController();
    _zipcode = TextEditingController();
    _email = TextEditingController();

    _name.text = widget.user.firstName!;
    _surname.text = widget.user.surname!;
    _username.text = widget.user.username!;
    _email.text = widget.user.email!;
    _fullAddress.text = widget.user.address!.full_address;
    _zipcode.text = widget.user.address!.postal_code;
  }

  @override
  Widget build(BuildContext context) {
    final getCitiesPrv = ref.watch(getCitiesProvider);
    final getCountiesPrv = ref.watch(getCountiesProvider);

    final changeGenderPrv =
        ref.watch(changeGenderProvider(widget.user.gender!));
    final changeCityPrv =
        ref.watch(changeCityProvider(widget.user.address!.city_name));
    final changeCountyPrv =
        ref.watch(changeCountyProvider(widget.user.address!.county_name));
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalGap(20),
          CustomAvatar(
            photo: '',
          ),
          verticalGap(40),
          Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _name,
                    hintText: 'İsim',
                    keyboardType: TextInputType.text,
                  ),
                  verticalGap(15),
                  CustomTextFormField(
                    controller: _surname,
                    hintText: 'Soyisim',
                    keyboardType: TextInputType.text,
                  ),
                  verticalGap(15),
                  CustomTextFormField(
                    controller: _username,
                    hintText: 'Kullanıcı Adı',
                    keyboardType: TextInputType.text,
                  ),
                  verticalGap(15),
                  CustomTextFormField(
                    controller: _email,
                    hintText: 'Email',
                    enabled: false,
                  ),
                  verticalGap(15),
                  CustomTextFormField(
                    controller: _fullAddress,
                    hintText: 'Tam Adres',
                    keyboardType: TextInputType.text,
                  ),
                  verticalGap(15),
                  CustomTextFormField(
                    controller: _zipcode,
                    hintText: 'Posta Kodu',
                    keyboardType: TextInputType.number,
                  ),
                  verticalGap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomText(
                          text: 'İl : ',
                          fontSize: 18,
                        ),
                      ),
                      getCitiesPrv.when(
                        data: (data) {
                          return CustomDropDownButton(
                            initialValue: data
                                    .where((element) =>
                                        element.city_name == changeCityPrv)
                                    .isNotEmpty
                                ? changeCityPrv
                                : null,
                            width: screenWidth(context) * 0.65,
                            hint: 'İl',
                            items: List.generate(
                                data.length, (index) => data[index].city_name),
                            onChanged: (p0) {
                              ref
                                  .read(changeCityProvider(
                                          widget.user.address!.city_name)
                                      .notifier)
                                  .state = p0;
                              ref.read(choosedCityProvider.notifier).state = p0;
                            },
                          );
                        },
                        error: (error, stackTrace) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                  verticalGap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomText(
                          text: 'İlçe : ',
                          fontSize: 18,
                        ),
                      ),
                      getCountiesPrv.when(
                        data: (data) {
                          return CustomDropDownButton(
                            initialValue: data
                                    .where((element) =>
                                        element.county_name == changeCountyPrv)
                                    .isNotEmpty
                                ? changeCountyPrv
                                : null,
                            width: screenWidth(context) * 0.65,
                            hint: 'İlçe',
                            items: List.generate(data.length,
                                (index) => data[index].county_name),
                            onChanged: (p0) {
                              ref
                                  .read(changeCountyProvider(
                                          widget.user.address!.county_name)
                                      .notifier)
                                  .state = p0;
                            },
                          );
                        },
                        error: (error, stackTrace) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                  verticalGap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomText(
                          text: 'Cinsiyet : ',
                          fontSize: 18,
                        ),
                      ),
                      CustomDropDownButton(
                        initialValue: genders.contains(changeGenderPrv)
                            ? changeGenderPrv
                            : null,
                        width: screenWidth(context) * 0.65,
                        hint: 'Cinsiyet',
                        items: genders,
                        onChanged: (p0) {
                          ref
                              .read(changeGenderProvider(widget.user.gender!)
                                  .notifier)
                              .state = p0;
                        },
                      ),
                    ],
                  ),
                  verticalGap(25),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          buttonText: 'Güncelle',
                          radius: 16,
                          width: screenWidth(context) * 0.45,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              log('Başarılı!');
                              var us = Users(
                                  firstName: _name.text,
                                  surname: _surname.text,
                                  username: _username.text,
                                  gender: changeGenderPrv,
                                  email: _email.text,
                                  address: Address(
                                      full_address: _fullAddress.text,
                                      postal_code: _zipcode.text,
                                      city_name: changeCityPrv,
                                      county_name: changeCountyPrv));
                              FirebaseOpts.updateDocument(
                                  colName: 'users',
                                  docId: widget.userId,
                                  data: us.toJson());
                            }
                          },
                        ),
                        CustomButton(
                          buttonText: 'Çıkış Yap',
                          width: screenWidth(context) * 0.45,
                          radius: 16,
                          onTap: () {
                            FirebaseOpts.userSignOut().then((value) =>
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(8.0),
                                        content: CustomText(
                                          text: 'Başarıyla çıkış yapıldı!',
                                          color: Colors.white,
                                        ))));
                          },
                        )
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
