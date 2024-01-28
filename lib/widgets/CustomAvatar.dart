import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libraryapp/screenTools/screenTools.dart';

final imageProvider = StateProvider<File?>((ref) => null);

class CustomAvatar extends ConsumerWidget {
  CustomAvatar({required this.photo, super.key});
  final String photo;

  final picker = ImagePicker();
  File? galleryFile;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePrv = ref.watch(imageProvider);
    return SizedBox(
      width: screenWidth(context) * 0.3,
      height: screenHeight(context) * 0.15,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const ShapeDecoration(
                shape: CircleBorder(
                    side: BorderSide(width: 4.0, color: Colors.redAccent))),
            child: galleryFile == null
                ? const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/libraryapp-36a24.appspot.com/o/manager_photo%2FIMG_0036.JPG?alt=media&token=e4ec46fa-434b-4449-ae0d-9e4b5c454209'),
                  )
                : ClipOval(
                    child: Image.file(
                      imagePrv!,
                      fit: BoxFit.fill,
                      width: 100,
                      height: 100,
                    ),
                  ),
          ),
          Positioned(
            top: 90,
            left: 85,
            child: GestureDetector(
              child: const Icon(
                Icons.photo_camera_outlined,
                color: Colors.redAccent,
                size: 30,
              ),
              onTap: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Foto seçimine tıklandı!')));
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SafeArea(
                        child: Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text('Telefondan'),
                          onTap: () {
                            getImage(ImageSource.gallery, ref);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_camera),
                          title: Text('Kameradan'),
                          onTap: () {
                            getImage(ImageSource.camera, ref);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future getImage(ImageSource img, WidgetRef ref) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xFile = pickedFile;
    if (xFile != null) {
      galleryFile = File(pickedFile!.path);
      ref.read(imageProvider.notifier).state = galleryFile;
    } else {
      log('Hiçbir foto seçilmedi!');
    }
  }
}
