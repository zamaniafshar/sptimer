import 'dart:async';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptimer/utils/constants/constants.dart';
import 'package:sptimer/utils/database.dart';

final class LocalizationCubit extends Cubit<Locale> {
  static Future<LocalizationCubit> create(Database localizationDatabase) async {
    final savedLanguageCode = await localizationDatabase.get(_localeKey);

    final locale = switch (savedLanguageCode) {
      String() => Locale(savedLanguageCode),
      _ => _getLanguageBasedOnSystem(),
    };

    return LocalizationCubit._(locale, localizationDatabase);
  }

  LocalizationCubit._(
    super.initialState,
    this._localizationDatabase,
  );

  final Database _localizationDatabase;

  static const _localeKey = 'locale';

  void changeLocale(Locale locale) {
    final isSupported = Constants.supportedLocales.any(
      (e) => e.languageCode == locale.languageCode,
    );
    if (!isSupported) throw ArgumentError('Unsupported locale');
    emit(locale);
    _saveLocale();
  }

  Future<void> _saveLocale() async {
    await _localizationDatabase.save(_localeKey, state.languageCode);
  }

  static Locale _getLanguageBasedOnSystem() {
    final systemLocale = PlatformDispatcher.instance.locales.first;
    if (systemLocale.languageCode == Constants.persianLocale.languageCode) {
      return Constants.persianLocale;
    }

    return Constants.englishLocale;
  }
}
