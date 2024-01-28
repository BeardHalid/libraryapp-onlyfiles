import 'package:mobx/mobx.dart';

part 'MobxSearch.g.dart';

class Search = MobxSearch with _$Search;

abstract class MobxSearch with Store {
  @observable
  late String word;

  @action
  void setWord(String word) {
    this.word = word;
  }

  @action
  String getWord() {
    return word;
  }
}
