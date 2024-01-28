import 'package:mobx/mobx.dart';

part 'MobxCbCheck.g.dart';

class CbCheck = MobxCbCheck with _$CbCheck;

abstract class MobxCbCheck with Store {
  @observable
  bool cbValue = false;
  @observable
  bool tfValue = true;

  @action
  void showPass() {
    cbValue = true;
    tfValue = false;
  }

  @action
  void hidePass() {
    cbValue = false;
    tfValue = true;
  }
}
