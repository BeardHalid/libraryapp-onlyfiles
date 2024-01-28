// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MobxCbCheck.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CbCheck on MobxCbCheck, Store {
  late final _$cbValueAtom =
      Atom(name: 'MobxCbCheck.cbValue', context: context);

  @override
  bool get cbValue {
    _$cbValueAtom.reportRead();
    return super.cbValue;
  }

  @override
  set cbValue(bool value) {
    _$cbValueAtom.reportWrite(value, super.cbValue, () {
      super.cbValue = value;
    });
  }

  late final _$tfValueAtom =
      Atom(name: 'MobxCbCheck.tfValue', context: context);

  @override
  bool get tfValue {
    _$tfValueAtom.reportRead();
    return super.tfValue;
  }

  @override
  set tfValue(bool value) {
    _$tfValueAtom.reportWrite(value, super.tfValue, () {
      super.tfValue = value;
    });
  }

  late final _$MobxCbCheckActionController =
      ActionController(name: 'MobxCbCheck', context: context);

  @override
  void showPass() {
    final _$actionInfo =
        _$MobxCbCheckActionController.startAction(name: 'MobxCbCheck.showPass');
    try {
      return super.showPass();
    } finally {
      _$MobxCbCheckActionController.endAction(_$actionInfo);
    }
  }

  @override
  void hidePass() {
    final _$actionInfo =
        _$MobxCbCheckActionController.startAction(name: 'MobxCbCheck.hidePass');
    try {
      return super.hidePass();
    } finally {
      _$MobxCbCheckActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cbValue: ${cbValue},
tfValue: ${tfValue}
    ''';
  }
}
