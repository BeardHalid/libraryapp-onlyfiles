import 'package:mobx/mobx.dart';

part 'MobxGenderChange.g.dart';

class GenderChange = MobxGenderChange with _$GenderChange;

abstract class MobxGenderChange with Store {
  @observable
  String gender = "Erkek";

  @action
  void changeGender(String gender) {
    this.gender = gender;
  }
}
