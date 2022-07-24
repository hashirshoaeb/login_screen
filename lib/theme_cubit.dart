import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// -- State
enum ThemeCubitState { light, dark }

// to make my life easy
extension XThemeCubitStateon on ThemeCubitState {
  bool get isLight => this == ThemeCubitState.light;

  bool get isDark => this == ThemeCubitState.dark;

  ThemeMode get toThemeMode {
    return this == ThemeCubitState.light ? ThemeMode.light : ThemeMode.dark;
  }
}

// -- Cubit

class ThemeModeCubit extends Cubit<ThemeCubitState> {
  ThemeModeCubit() : super(ThemeCubitState.light);

  @override
  void onChange(Change<ThemeCubitState> change) {
    // for testing
    //print('changed to ${change.nextState}');
    super.onChange(change);
  }

  void toggle() => emit(state == ThemeCubitState.light ? ThemeCubitState.dark : ThemeCubitState.light);
}
