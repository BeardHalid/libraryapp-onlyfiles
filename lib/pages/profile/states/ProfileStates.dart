import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/classes/Users.dart';
import 'package:libraryapp/firebase/FirebaseOpts.dart';

import 'package:libraryapp/http/HttpOpts.dart';

final httpOptsProvider = Provider((ref) {
  return HttpOpts();
});

final getCitiesProvider = FutureProvider((ref) async {
  final httpOptsPrv = ref.read(httpOptsProvider);
  return httpOptsPrv.getCities();
});

final getCountiesProvider = FutureProvider((ref) async {
  final httpOptsPrv = ref.read(httpOptsProvider);
  final choosedCityPrv = ref.watch(choosedCityProvider);
  if (choosedCityPrv.isNotEmpty) {
    return httpOptsPrv.getCountiesOfCity(choosedCityPrv);
  } else {
    return httpOptsPrv.getCounties();
  }
});

final showHidePasswordProvider = StateProvider<bool>((ref) {
  return true;
});

final choosedCityProvider = StateProvider<String>((ref) {
  return '';
});

final profileDetailsProvider =
    FutureProvider.family<Users, String>((ref, id) async {
  final user = await FirebaseOpts.getUserProps(id);
  return user!;
});

final changeGenderProvider = StateProvider.family((ref, String gender) {
  return gender;
});

final changeCityProvider = StateProvider.family((ref, String city) {
  return city;
});

final changeCountyProvider = StateProvider.family((ref, String county) {
  return county;
});
