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

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
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
  String get productsAppBarTitle {
    return Intl.message(
      'Products',
      name: 'productsAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `No products found with the selected filters.`
  String get productsEmptyView {
    return Intl.message(
      'No products found with the selected filters.',
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

  /// `Expiration Date`
  String get editProductExpirationDateInputLabel {
    return Intl.message(
      'Expiration Date',
      name: 'editProductExpirationDateInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid expiration date.`
  String get editProductExpirationDateInputError {
    return Intl.message(
      'Please enter a valid expiration date.',
      name: 'editProductExpirationDateInputError',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get editProductNameInputLabel {
    return Intl.message(
      'Name',
      name: 'editProductNameInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a name.`
  String get editProductNameInputError {
    return Intl.message(
      'Please enter a name.',
      name: 'editProductNameInputError',
      desc: '',
      args: [],
    );
  }

  /// `Add Manually`
  String get productsPageAddManuallyFAB {
    return Intl.message(
      'Add Manually',
      name: 'productsPageAddManuallyFAB',
      desc: '',
      args: [],
    );
  }

  /// `Barcode Scanner`
  String get productsPageScanBarcodeFAB {
    return Intl.message(
      'Barcode Scanner',
      name: 'productsPageScanBarcodeFAB',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get productsFilterButtonAll {
    return Intl.message(
      'All',
      name: 'productsFilterButtonAll',
      desc: '',
      args: [],
    );
  }

  /// `Not Expired`
  String get productsFilterButtonNotExpired {
    return Intl.message(
      'Not Expired',
      name: 'productsFilterButtonNotExpired',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get productsFilterButtonExpired {
    return Intl.message(
      'Expired',
      name: 'productsFilterButtonExpired',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get productsSortButtonName {
    return Intl.message(
      'Name',
      name: 'productsSortButtonName',
      desc: '',
      args: [],
    );
  }

  /// `Expiration Date`
  String get productsSortButtonExpirationDate {
    return Intl.message(
      'Expiration Date',
      name: 'productsSortButtonExpirationDate',
      desc: '',
      args: [],
    );
  }

  /// `Barcode Scanner`
  String get scannerAppBarTitle {
    return Intl.message(
      'Barcode Scanner',
      name: 'scannerAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan a barcode to add a product.`
  String get scannerPageDisplayText {
    return Intl.message(
      'Scan a barcode to add a product.',
      name: 'scannerPageDisplayText',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get scannerLoadingStateText {
    return Intl.message(
      'Loading...',
      name: 'scannerLoadingStateText',
      desc: '',
      args: [],
    );
  }

  /// `This is not a valid product-barcode.`
  String get scannerInvalidBarcodeText {
    return Intl.message(
      'This is not a valid product-barcode.',
      name: 'scannerInvalidBarcodeText',
      desc: '',
      args: [],
    );
  }

  /// `Product not found.`
  String get scannerProductNotFoundText {
    return Intl.message(
      'Product not found.',
      name: 'scannerProductNotFoundText',
      desc: '',
      args: [],
    );
  }

  /// `Scanner took too long to respond.`
  String get scannerTimeoutText {
    return Intl.message(
      'Scanner took too long to respond.',
      name: 'scannerTimeoutText',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsPageAppBarTitle {
    return Intl.message(
      'Settings',
      name: 'settingsPageAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Daily Notification Time`
  String get settingsPageDailyNotificationTime {
    return Intl.message(
      'Daily Notification Time',
      name: 'settingsPageDailyNotificationTime',
      desc: '',
      args: [],
    );
  }

  /// `Nothing here`
  String get settingsPageErrorText {
    return Intl.message(
      'Nothing here',
      name: 'settingsPageErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settingsPageThemeDialogTitle {
    return Intl.message(
      'Theme',
      name: 'settingsPageThemeDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get settingsPageThemeListTileSystem {
    return Intl.message(
      'System',
      name: 'settingsPageThemeListTileSystem',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get settingsPageThemeListTileLight {
    return Intl.message(
      'Light',
      name: 'settingsPageThemeListTileLight',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get settingsPageThemeListTileDark {
    return Intl.message(
      'Dark',
      name: 'settingsPageThemeListTileDark',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settingsPageThemeListTileTitle {
    return Intl.message(
      'Theme',
      name: 'settingsPageThemeListTileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOutDialogTitle {
    return Intl.message(
      'Sign Out',
      name: 'signOutDialogTitle',
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
