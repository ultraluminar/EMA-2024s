// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Fridge Manager`
  String get appTitle {
    return Intl.message(
      'Fridge Manager',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get productsPageNavigationBarLabel {
    return Intl.message(
      'Products',
      name: 'productsPageNavigationBarLabel',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overviewPageNavigationBarLabel {
    return Intl.message(
      'Overview',
      name: 'overviewPageNavigationBarLabel',
      desc: '',
      args: [],
    );
  }

  /// `Recipes`
  String get recipesPageNavigationBarLabel {
    return Intl.message(
      'Recipes',
      name: 'recipesPageNavigationBarLabel',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get productsAppBarTitle {
    return Intl.message(
      'Products',
      name: 'productsAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Fridge Manager`
  String get overviewAppBarTitle {
    return Intl.message(
      'Fridge Manager',
      name: 'overviewAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recipes`
  String get recipesAppBarTitle {
    return Intl.message(
      'Recipes',
      name: 'recipesAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while loading todos.`
  String get productsErrorSnackbarText {
    return Intl.message(
      'An error occurred while loading todos.',
      name: 'productsErrorSnackbarText',
      desc: '',
      args: [],
    );
  }

  /// `No todos found with the selected filters.`
  String get productsEmptyView {
    return Intl.message(
      'No todos found with the selected filters.',
      name: 'productsEmptyView',
      desc: '',
      args: [],
    );
  }

  /// `Products Page`
  String get productsPageLink {
    return Intl.message(
      'Products Page',
      name: 'productsPageLink',
      desc: '',
      args: [],
    );
  }

  /// `Nothing to see here yet!`
  String get nothingToSeeHereYet {
    return Intl.message(
      'Nothing to see here yet!',
      name: 'nothingToSeeHereYet',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get editProductAddAppBarTitle {
    return Intl.message(
      'Add Product',
      name: 'editProductAddAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProductEditAppBarTitle {
    return Intl.message(
      'Edit Product',
      name: 'editProductEditAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save Product`
  String get editProductSaveButtonTooltip {
    return Intl.message(
      'Save Product',
      name: 'editProductSaveButtonTooltip',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{expired 1 day ago} other{expired {count} days ago}}`
  String productListTileDescriptionExpired(int count) {
    return Intl.plural(
      count,
      one: 'expired 1 day ago',
      other: 'expired $count days ago',
      name: 'productListTileDescriptionExpired',
      desc: 'productListTileDescriptionExpired',
      args: [count],
    );
  }

  /// `{count, plural, zero{expires today} one{expires in 1 day} other{expires in {count} days}}`
  String productListTileDescriptionNotExpired(int count) {
    return Intl.plural(
      count,
      zero: 'expires today',
      one: 'expires in 1 day',
      other: 'expires in $count days',
      name: 'productListTileDescriptionNotExpired',
      desc: 'productListTileDescriptionNotExpired',
      args: [count],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
