// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MobxSearch.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Search on MobxSearch, Store {
  late final _$wordAtom = Atom(name: 'MobxSearch.word', context: context);

  @override
  String get word {
    _$wordAtom.reportRead();
    return super.word;
  }

  @override
  set word(String value) {
    _$wordAtom.reportWrite(value, super.word, () {
      super.word = value;
    });
  }

  late final _$MobxSearchActionController =
      ActionController(name: 'MobxSearch', context: context);

  @override
  void setWord(String word) {
    final _$actionInfo =
        _$MobxSearchActionController.startAction(name: 'MobxSearch.setWord');
    try {
      return super.setWord(word);
    } finally {
      _$MobxSearchActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getWord() {
    final _$actionInfo =
        _$MobxSearchActionController.startAction(name: 'MobxSearch.getWord');
    try {
      return super.getWord();
    } finally {
      _$MobxSearchActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
word: ${word}
    ''';
  }
}
