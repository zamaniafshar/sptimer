// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'tones.dart';

class TonesMapper extends EnumMapper<Tones> {
  TonesMapper._();

  static TonesMapper? _instance;
  static TonesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TonesMapper._());
    }
    return _instance!;
  }

  static Tones fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Tones decode(dynamic value) {
    switch (value) {
      case 'none':
        return Tones.none;
      case 'alert':
        return Tones.alert;
      case 'ding':
        return Tones.ding;
      case 'doorbell':
        return Tones.doorbell;
      case 'doubleBell':
        return Tones.doubleBell;
      case 'hello':
        return Tones.hello;
      case 'greetings':
        return Tones.greetings;
      case 'happyBells':
        return Tones.happyBells;
      case 'harp':
        return Tones.harp;
      case 'loudBeeps':
        return Tones.loudBeeps;
      case 'magical':
        return Tones.magical;
      case 'marbles':
        return Tones.marbles;
      case 'messageOld':
        return Tones.messageOld;
      case 'message':
        return Tones.message;
      case 'musicalAlert':
        return Tones.musicalAlert;
      case 'positive':
        return Tones.positive;
      case 'pristine':
        return Tones.pristine;
      case 'quickChime':
        return Tones.quickChime;
      case 'relax':
        return Tones.relax;
      case 'twinkle':
        return Tones.twinkle;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Tones self) {
    switch (self) {
      case Tones.none:
        return 'none';
      case Tones.alert:
        return 'alert';
      case Tones.ding:
        return 'ding';
      case Tones.doorbell:
        return 'doorbell';
      case Tones.doubleBell:
        return 'doubleBell';
      case Tones.hello:
        return 'hello';
      case Tones.greetings:
        return 'greetings';
      case Tones.happyBells:
        return 'happyBells';
      case Tones.harp:
        return 'harp';
      case Tones.loudBeeps:
        return 'loudBeeps';
      case Tones.magical:
        return 'magical';
      case Tones.marbles:
        return 'marbles';
      case Tones.messageOld:
        return 'messageOld';
      case Tones.message:
        return 'message';
      case Tones.musicalAlert:
        return 'musicalAlert';
      case Tones.positive:
        return 'positive';
      case Tones.pristine:
        return 'pristine';
      case Tones.quickChime:
        return 'quickChime';
      case Tones.relax:
        return 'relax';
      case Tones.twinkle:
        return 'twinkle';
    }
  }
}

extension TonesMapperExtension on Tones {
  String toValue() {
    TonesMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Tones>(this) as String;
  }
}
