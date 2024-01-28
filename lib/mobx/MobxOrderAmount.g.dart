// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MobxOrderAmount.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderAmount on MobxOrderAmount, Store {
  late final _$orderAmountAtom =
      Atom(name: 'MobxOrderAmount.orderAmount', context: context);

  @override
  int get orderAmount {
    _$orderAmountAtom.reportRead();
    return super.orderAmount;
  }

  @override
  set orderAmount(int value) {
    _$orderAmountAtom.reportWrite(value, super.orderAmount, () {
      super.orderAmount = value;
    });
  }

  late final _$MobxOrderAmountActionController =
      ActionController(name: 'MobxOrderAmount', context: context);

  @override
  void increaseAmount() {
    final _$actionInfo = _$MobxOrderAmountActionController.startAction(
        name: 'MobxOrderAmount.increaseAmount');
    try {
      return super.increaseAmount();
    } finally {
      _$MobxOrderAmountActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decreaseAmount() {
    final _$actionInfo = _$MobxOrderAmountActionController.startAction(
        name: 'MobxOrderAmount.decreaseAmount');
    try {
      return super.decreaseAmount();
    } finally {
      _$MobxOrderAmountActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orderAmount: ${orderAmount}
    ''';
  }
}
