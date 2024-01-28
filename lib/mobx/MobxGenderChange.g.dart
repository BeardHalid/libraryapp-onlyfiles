// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MobxGenderChange.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GenderChange on MobxGenderChange, Store {
  late final _$genderAtom =
      Atom(name: 'MobxGenderChange.gender', context: context);

  @override
  String get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(String value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$MobxGenderChangeActionController =
      ActionController(name: 'MobxGenderChange', context: context);

  @override
  void changeGender(String gender) {
    final _$actionInfo = _$MobxGenderChangeActionController.startAction(
        name: 'MobxGenderChange.changeGender');
    try {
      return super.changeGender(gender);
    } finally {
      _$MobxGenderChangeActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gender: ${gender}
    ''';
  }
}
