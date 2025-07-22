// ignore_for_file: sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sptimer/config/localization/localization_cubit.dart';
import 'package:sptimer/config/theme/themes.dart';
import 'package:sptimer/common/constants/constants.dart';
import 'package:sptimer/common/database/database.dart';

final class ThemeCubit extends Cubit<ThemeState> {
  static ThemeCubit create(SimpleDatabase themeDatabase) {
    final storedThemeIndex = themeDatabase.get(_themeKey);
    ThemeState initialState;

    if (storedThemeIndex != null) {
      initialState = ThemeState.values[storedThemeIndex as int];
    } else {
      final systemBrightness = PlatformDispatcher.instance.platformBrightness;
      initialState = systemBrightness == Brightness.dark ? ThemeState.dark : ThemeState.light;
      themeDatabase.save(_themeKey, initialState.index);
    }

    initialState._setSystemOverlayStyle();

    return ThemeCubit._(initialState, themeDatabase);
  }

  ThemeCubit._(
    super.initialState,
    this._themeDatabase,
  );

  final SimpleDatabase _themeDatabase;

  void toggle() {
    if (state == ThemeState.dark) {
      _changeTheme(ThemeState.light);
    } else {
      _changeTheme(ThemeState.dark);
    }
  }

  void _changeTheme(ThemeState themeState) {
    emit(themeState);
    themeState._setSystemOverlayStyle();
    _save(themeState);
  }

  Future<void> _save(ThemeState theme) async {
    _themeDatabase.save(_themeKey, theme.index);
  }

  static const _themeKey = 'theme';
}

enum ThemeState {
  light,
  dark;
}

extension ThemeStateX on ThemeState {
  ThemeData createThemeData(Locale locale) {
    final fontFamily = locale.isEnglish ? Constants.sansproFont : Constants.vazirFont;

    return switch (this) {
      ThemeState.light => createLightTheme(fontFamily),
      ThemeState.dark => createDarkTheme(fontFamily),
    };
  }

  void _setSystemOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      switch (this) {
        ThemeState.light => const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
        ThemeState.dark => const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
      },
    );
  }
}
