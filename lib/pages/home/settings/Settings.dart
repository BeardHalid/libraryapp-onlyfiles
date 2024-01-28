import 'package:flutter/material.dart';
import 'package:libraryapp/AppRoutes.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomInfoDialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var settingsList = {
    0: "Uygulama Ayarları",
    1: "Biz Kimiz?",
    2: "Bize Ulaşın",
    3: "Dilek, şikayet veya öneride bulunun",
    4: "Hakkında"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Ayarlar'),
        toolbarHeight: screenHeight(context) * 0.09,
      ),
      body: ListView(
          children: List.generate(settingsList.length, (index) {
        return ListTile(
          title: Text(settingsList.values.elementAt(index)),
          onTap: () {
            switch (settingsList.keys.elementAt(index)) {
              case 4:
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("${settingsList.values.elementAt(4)} tıklandı!")));
                break;
              case 2:
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const CustomInfoDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("E-mail : sorsan_yeter@gmail.com"),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Telefon : +90 550 545 45 45")
                            ],
                          ),
                          title: '...İletişim...');
                    });
                break;
              case 1:
                Navigator.pushNamed(context, AppRoutes.whoAreUs);
                break;
              case 3:
                Navigator.pushNamed(context, AppRoutes.petition);
                break;
              default:
                break;
            }
          },
        );
      })),
    );
  }
}
