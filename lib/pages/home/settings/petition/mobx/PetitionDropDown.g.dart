// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PetitionDropDown.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetitionDD on PetitionDropDown, Store {
  late final _$valueAtom =
      Atom(name: 'PetitionDropDown.value', context: context);

  @override
  String? get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(String? value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$PetitionDropDownActionController =
      ActionController(name: 'PetitionDropDown', context: context);

  @override
  void changeValue(String newValue) {
    final _$actionInfo = _$PetitionDropDownActionController.startAction(
        name: 'PetitionDropDown.changeValue');
    try {
      return super.changeValue(newValue);
    } finally {
      _$PetitionDropDownActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
