import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:libraryapp/classes/Petitions.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomButton.dart';
import 'package:libraryapp/widgets/CustomDropDownButton.dart';
import 'package:libraryapp/widgets/CustomText.dart';
import 'package:libraryapp/widgets/CustomTextField.dart';
import 'package:libraryapp/firebase/FirebaseOpts.dart';

class CreatePetition extends StatefulWidget {
  const CreatePetition({super.key});

  @override
  State<CreatePetition> createState() => _CreatePetitionState();
}

class _CreatePetitionState extends State<CreatePetition> {
  late TextEditingController sendTypeController;
  late TextEditingController textController;
  @override
  void initState() {
    super.initState();

    sendTypeController = TextEditingController();
    textController = TextEditingController();
  }

  String? petitionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gönderi Oluştur'),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Gönderi Tipi : ',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomDropDownButton(
                    items: const ['Öneri', 'Şikayet', 'Dilek'],
                    hint: 'Seçiniz...',
                    initialValue: petitionType,
                    width: screenWidth(context) * 0.50,
                    onChanged: (p0) {
                      setState(() {
                        petitionType = p0;
                      });
                    },
                  ),
                ],
              ),
            ),
            CustomTextField(
                controller: sendTypeController, hintText: 'Gönderen'),
            const Padding(
              padding: EdgeInsets.all(35.0),
              child: CustomText(
                text: 'Gönderi : ',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
              child: TextField(
                controller: textController,
                minLines: 5,
                maxLines: 20,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: CustomButton(
                    buttonText: 'Gönder',
                    onTap: () {
                      log(textController.text);
                      final pet = Petitions(
                          petitionType: petitionType!,
                          status: 'Bekleyen',
                          sender: sendTypeController.text,
                          petition: textController.text,
                          deviceToken: Hive.box('tokenBox').values.first);
                      FirebaseOpts.createDocument(
                          colName: 'petitions',
                          docId: petitionType!,
                          data: pet.toJson());
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
