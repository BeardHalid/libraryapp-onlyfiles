import 'package:mobx/mobx.dart';

part 'MobxOrderAmount.g.dart';

class OrderAmount = MobxOrderAmount with _$OrderAmount;

abstract class MobxOrderAmount with Store {
  @observable
  int orderAmount = 0;

  @action
  void increaseAmount() {
    orderAmount += 1;
  }

  @action
  void decreaseAmount() {
    if (orderAmount > 0) {
      orderAmount -= 1;
    }
  }
}
