import 'package:mobx/mobx.dart';

part 'PetitionDropDown.g.dart';

class PetitionDD = PetitionDropDown with _$PetitionDD;

abstract class PetitionDropDown with Store {
  @observable
  String? value;

  @action
  void changeValue(String newValue) {
    value = newValue;
  }
}
