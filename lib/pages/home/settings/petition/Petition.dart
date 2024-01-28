import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/AppRoutes.dart';
import 'package:libraryapp/classes/Petitions.dart';
import 'package:libraryapp/pages/home/settings/petition/mobx/PetitionDropDown.dart';
import 'package:libraryapp/pages/home/settings/petition/states/PetitionStates.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomDropDownButton.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class Petition extends ConsumerStatefulWidget {
  const Petition({super.key});

  @override
  ConsumerState<Petition> createState() => _PetitionState();
}

class _PetitionState extends ConsumerState<Petition> {
  final petitionTypeList = ['Okunmuş', 'Bekleyen', 'Okunmamış'];

  final petitionMobx = PetitionDD();

  @override
  void initState() {
    super.initState();
  }

  /* Future<QuerySnapshot> getPetitions(String? petitionType) async {
    return petitionType != null
        ? await FirebaseFirestore.instance
            .collection('petitions')
            .where('petition_type', isEqualTo: petitionType)
            .get()
        : await FirebaseFirestore.instance.collection('petitions').get();
  }
 */
  @override
  Widget build(BuildContext context) {
    final petitionPrv = ref.watch(petitionProvider(null));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gönderiler'),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Column(children: [
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
              Observer(
                builder: (context) => CustomDropDownButton(
                  items: petitionTypeList,
                  hint: 'Seçiniz...',
                  width: screenWidth(context) * 0.50,
                  initialValue: petitionMobx.value,
                  onChanged: (p0) {
                    petitionMobx.changeValue(p0);
                    return ref
                        .refresh(petitionProvider(petitionMobx.value).future);
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () =>
                ref.refresh(petitionProvider(petitionMobx.value).future),
            child: petitionPrv.when(
              data: (data) {
                return ListView.builder(
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    var petition = Petitions.fromJson(data.docs[index].data());
                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(petition.petition),
                          Text(petition.petitionType)
                        ],
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) => Center(
                child: CustomText(text: error.toString()),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.createPetition);
        },
        label: const CustomText(text: 'Yeni Gönderi'),
        icon: const Icon(Icons.add_comment),
      ),
    );
  }
}
