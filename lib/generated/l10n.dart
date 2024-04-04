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

  /// `Далее`
  String get button_next {
    return Intl.message(
      'Далее',
      name: 'button_next',
      desc: '',
      args: [],
    );
  }

  /// `Завершить`
  String get button_end {
    return Intl.message(
      'Завершить',
      name: 'button_end',
      desc: '',
      args: [],
    );
  }

  /// `Добро пожаловать`
  String get welcome_title_0 {
    return Intl.message(
      'Добро пожаловать',
      name: 'welcome_title_0',
      desc: '',
      args: [],
    );
  }

  /// `Местоположение`
  String get welcome_title_1 {
    return Intl.message(
      'Местоположение',
      name: 'welcome_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Уведомления`
  String get welcome_title_2 {
    return Intl.message(
      'Уведомления',
      name: 'welcome_title_2',
      desc: '',
      args: [],
    );
  }

  /// `Завершено`
  String get welcome_title_3 {
    return Intl.message(
      'Завершено',
      name: 'welcome_title_3',
      desc: '',
      args: [],
    );
  }

  /// `Добро пожаловать в приложение. Для оптимальной работы ему потребуются разрешения. Дополнительная информация об этом приводится в нашей `
  String get welcome_text_0 {
    return Intl.message(
      'Добро пожаловать в приложение. Для оптимальной работы ему потребуются разрешения. Дополнительная информация об этом приводится в нашей ',
      name: 'welcome_text_0',
      desc: '',
      args: [],
    );
  }

  /// `Политике конфиденциальности.`
  String get welcome_text_0_0 {
    return Intl.message(
      'Политике конфиденциальности.',
      name: 'welcome_text_0_0',
      desc: '',
      args: [],
    );
  }

  /// `Это приложение использует разрешение на определение местоположения для расчета расстояния до каждого катаклизма, оповещений о ближайших землетрясениях, погоде и аналитики.`
  String get welcome_text_1 {
    return Intl.message(
      'Это приложение использует разрешение на определение местоположения для расчета расстояния до каждого катаклизма, оповещений о ближайших землетрясениях, погоде и аналитики.',
      name: 'welcome_text_1',
      desc: '',
      args: [],
    );
  }

  /// `Это приложение использует разрешение на отправку уведомлений, чтобы предупреждать вас о катаклизмах, которые могут повлиять на вас. Без этого разрешения вы не будете получать уведомления.`
  String get welcome_text_2 {
    return Intl.message(
      'Это приложение использует разрешение на отправку уведомлений, чтобы предупреждать вас о катаклизмах, которые могут повлиять на вас. Без этого разрешения вы не будете получать уведомления.',
      name: 'welcome_text_2',
      desc: '',
      args: [],
    );
  }

  /// `Спасибо за завершение процесса настройки. Теперь можно начать использовать приложение. Нажмите Завершить, чтобы открыть приложение.`
  String get welcome_text_3 {
    return Intl.message(
      'Спасибо за завершение процесса настройки. Теперь можно начать использовать приложение. Нажмите Завершить, чтобы открыть приложение.',
      name: 'welcome_text_3',
      desc: '',
      args: [],
    );
  }

  /// `Чтобы продолжить, нажмите Далее`
  String get welcome_text_next {
    return Intl.message(
      'Чтобы продолжить, нажмите Далее',
      name: 'welcome_text_next',
      desc: '',
      args: [],
    );
  }

  /// `Шаг {step} из 3`
  String welcome_step(int step) {
    return Intl.message(
      'Шаг $step из 3',
      name: 'welcome_step',
      desc: '',
      args: [step],
    );
  }

  /// `Найти событие`
  String get history_input {
    return Intl.message(
      'Найти событие',
      name: 'history_input',
      desc: '',
      args: [],
    );
  }

  /// `({time} часов назад)`
  String event_time_hours(int time) {
    return Intl.message(
      '($time часов назад)',
      name: 'event_time_hours',
      desc: '',
      args: [time],
    );
  }

  /// `({time} минут назад)`
  String event_time_minutes(int time) {
    return Intl.message(
      '($time минут назад)',
      name: 'event_time_minutes',
      desc: '',
      args: [time],
    );
  }

  /// `({time} секунд назад)`
  String event_time_seconds(int time) {
    return Intl.message(
      '($time секунд назад)',
      name: 'event_time_seconds',
      desc: '',
      args: [time],
    );
  }

  /// `Сортировка`
  String get sort {
    return Intl.message(
      'Сортировка',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Не найдено`
  String get event_not_found {
    return Intl.message(
      'Не найдено',
      name: 'event_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Сегодня`
  String get event_time_today {
    return Intl.message(
      'Сегодня',
      name: 'event_time_today',
      desc: '',
      args: [],
    );
  }

  /// `Вчера`
  String get event_time_yesterday {
    return Intl.message(
      'Вчера',
      name: 'event_time_yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Землетрясения`
  String get event_type_1 {
    return Intl.message(
      'Землетрясения',
      name: 'event_type_1',
      desc: '',
      args: [],
    );
  }

  /// `Пожар`
  String get event_type_2 {
    return Intl.message(
      'Пожар',
      name: 'event_type_2',
      desc: '',
      args: [],
    );
  }

  /// `Оползень`
  String get event_type_3 {
    return Intl.message(
      'Оползень',
      name: 'event_type_3',
      desc: '',
      args: [],
    );
  }

  /// `Паводки`
  String get event_type_4 {
    return Intl.message(
      'Паводки',
      name: 'event_type_4',
      desc: '',
      args: [],
    );
  }

  /// `Сель`
  String get event_type_5 {
    return Intl.message(
      'Сель',
      name: 'event_type_5',
      desc: '',
      args: [],
    );
  }

  /// `Лавина`
  String get event_type_6 {
    return Intl.message(
      'Лавина',
      name: 'event_type_6',
      desc: '',
      args: [],
    );
  }

  /// `Погода  на неделю`
  String get weather_week {
    return Intl.message(
      'Погода  на неделю',
      name: 'weather_week',
      desc: '',
      args: [],
    );
  }

  /// `Сейчас`
  String get weather_time_now {
    return Intl.message(
      'Сейчас',
      name: 'weather_time_now',
      desc: '',
      args: [],
    );
  }

  /// `Вернуться`
  String get button_back {
    return Intl.message(
      'Вернуться',
      name: 'button_back',
      desc: '',
      args: [],
    );
  }

  /// `Тип уведомлений`
  String get setting_item_1 {
    return Intl.message(
      'Тип уведомлений',
      name: 'setting_item_1',
      desc: '',
      args: [],
    );
  }

  /// `Нет`
  String get setting_item_1_1 {
    return Intl.message(
      'Нет',
      name: 'setting_item_1_1',
      desc: '',
      args: [],
    );
  }

  /// `Рядом`
  String get setting_item_1_2 {
    return Intl.message(
      'Рядом',
      name: 'setting_item_1_2',
      desc: '',
      args: [],
    );
  }

  /// `На расстоянии`
  String get setting_item_1_3 {
    return Intl.message(
      'На расстоянии',
      name: 'setting_item_1_3',
      desc: '',
      args: [],
    );
  }

  /// `Мой регион`
  String get setting_item_1_4 {
    return Intl.message(
      'Мой регион',
      name: 'setting_item_1_4',
      desc: '',
      args: [],
    );
  }

  /// `Моя страна`
  String get setting_item_1_5 {
    return Intl.message(
      'Моя страна',
      name: 'setting_item_1_5',
      desc: '',
      args: [],
    );
  }

  /// `Мой континент`
  String get setting_item_1_6 {
    return Intl.message(
      'Мой континент',
      name: 'setting_item_1_6',
      desc: '',
      args: [],
    );
  }

  /// `В мире`
  String get setting_item_1_7 {
    return Intl.message(
      'В мире',
      name: 'setting_item_1_7',
      desc: '',
      args: [],
    );
  }

  /// `Звук уведомлений`
  String get setting_item_2 {
    return Intl.message(
      'Звук уведомлений',
      name: 'setting_item_2',
      desc: '',
      args: [],
    );
  }

  /// `Разрешить все важные уведомления`
  String get setting_item_3 {
    return Intl.message(
      'Разрешить все важные уведомления',
      name: 'setting_item_3',
      desc: '',
      args: [],
    );
  }

  /// `Минимальная магнитуда`
  String get setting_item_4 {
    return Intl.message(
      'Минимальная магнитуда',
      name: 'setting_item_4',
      desc: '',
      args: [],
    );
  }

  /// `1.0 +`
  String get setting_item_4_1 {
    return Intl.message(
      '1.0 +',
      name: 'setting_item_4_1',
      desc: '',
      args: [],
    );
  }

  /// `1.5 +`
  String get setting_item_4_2 {
    return Intl.message(
      '1.5 +',
      name: 'setting_item_4_2',
      desc: '',
      args: [],
    );
  }

  /// `2.0 +`
  String get setting_item_4_3 {
    return Intl.message(
      '2.0 +',
      name: 'setting_item_4_3',
      desc: '',
      args: [],
    );
  }

  /// `2.5 +`
  String get setting_item_4_4 {
    return Intl.message(
      '2.5 +',
      name: 'setting_item_4_4',
      desc: '',
      args: [],
    );
  }

  /// `3.0 +`
  String get setting_item_4_5 {
    return Intl.message(
      '3.0 +',
      name: 'setting_item_4_5',
      desc: '',
      args: [],
    );
  }

  /// `3.5 +`
  String get setting_item_4_6 {
    return Intl.message(
      '3.5 +',
      name: 'setting_item_4_6',
      desc: '',
      args: [],
    );
  }

  /// `4.0 +`
  String get setting_item_4_7 {
    return Intl.message(
      '4.0 +',
      name: 'setting_item_4_7',
      desc: '',
      args: [],
    );
  }

  /// `4.5 +`
  String get setting_item_4_8 {
    return Intl.message(
      '4.5 +',
      name: 'setting_item_4_8',
      desc: '',
      args: [],
    );
  }

  /// `5.0 +`
  String get setting_item_4_9 {
    return Intl.message(
      '5.0 +',
      name: 'setting_item_4_9',
      desc: '',
      args: [],
    );
  }

  /// `5.5 +`
  String get setting_item_4_10 {
    return Intl.message(
      '5.5 +',
      name: 'setting_item_4_10',
      desc: '',
      args: [],
    );
  }

  /// `6.0 +`
  String get setting_item_4_11 {
    return Intl.message(
      '6.0 +',
      name: 'setting_item_4_11',
      desc: '',
      args: [],
    );
  }

  /// `6.5 +`
  String get setting_item_4_12 {
    return Intl.message(
      '6.5 +',
      name: 'setting_item_4_12',
      desc: '',
      args: [],
    );
  }

  /// `7.0 +`
  String get setting_item_4_13 {
    return Intl.message(
      '7.0 +',
      name: 'setting_item_4_13',
      desc: '',
      args: [],
    );
  }

  /// `7.5 +`
  String get setting_item_4_14 {
    return Intl.message(
      '7.5 +',
      name: 'setting_item_4_14',
      desc: '',
      args: [],
    );
  }

  /// `8.0 +`
  String get setting_item_4_15 {
    return Intl.message(
      '8.0 +',
      name: 'setting_item_4_15',
      desc: '',
      args: [],
    );
  }

  /// `8.5 +`
  String get setting_item_4_16 {
    return Intl.message(
      '8.5 +',
      name: 'setting_item_4_16',
      desc: '',
      args: [],
    );
  }

  /// `9.0 +`
  String get setting_item_4_17 {
    return Intl.message(
      '9.0 +',
      name: 'setting_item_4_17',
      desc: '',
      args: [],
    );
  }

  /// `9.5 +`
  String get setting_item_4_18 {
    return Intl.message(
      '9.5 +',
      name: 'setting_item_4_18',
      desc: '',
      args: [],
    );
  }

  /// `Система измерений`
  String get setting_item_5 {
    return Intl.message(
      'Система измерений',
      name: 'setting_item_5',
      desc: '',
      args: [],
    );
  }

  /// `Автоматически`
  String get setting_item_5_1 {
    return Intl.message(
      'Автоматически',
      name: 'setting_item_5_1',
      desc: '',
      args: [],
    );
  }

  /// `Мили`
  String get setting_item_5_2 {
    return Intl.message(
      'Мили',
      name: 'setting_item_5_2',
      desc: '',
      args: [],
    );
  }

  /// `Км`
  String get setting_item_5_3 {
    return Intl.message(
      'Км',
      name: 'setting_item_5_3',
      desc: '',
      args: [],
    );
  }

  /// `Страна`
  String get setting_item_7 {
    return Intl.message(
      'Страна',
      name: 'setting_item_7',
      desc: '',
      args: [],
    );
  }

  /// `Показ магнитуды`
  String get setting_item_8 {
    return Intl.message(
      'Показ магнитуды',
      name: 'setting_item_8',
      desc: '',
      args: [],
    );
  }

  /// `Показ региона`
  String get setting_item_9 {
    return Intl.message(
      'Показ региона',
      name: 'setting_item_9',
      desc: '',
      args: [],
    );
  }

  /// `Временные рамки`
  String get setting_item_10 {
    return Intl.message(
      'Временные рамки',
      name: 'setting_item_10',
      desc: '',
      args: [],
    );
  }

  /// `12 часов`
  String get setting_item_10_1 {
    return Intl.message(
      '12 часов',
      name: 'setting_item_10_1',
      desc: '',
      args: [],
    );
  }

  /// `24 часов`
  String get setting_item_10_2 {
    return Intl.message(
      '24 часов',
      name: 'setting_item_10_2',
      desc: '',
      args: [],
    );
  }

  /// `36 часов`
  String get setting_item_10_3 {
    return Intl.message(
      '36 часов',
      name: 'setting_item_10_3',
      desc: '',
      args: [],
    );
  }

  /// `48 часов`
  String get setting_item_10_4 {
    return Intl.message(
      '48 часов',
      name: 'setting_item_10_4',
      desc: '',
      args: [],
    );
  }

  /// `Сортировка катаклизмов`
  String get setting_item_11 {
    return Intl.message(
      'Сортировка катаклизмов',
      name: 'setting_item_11',
      desc: '',
      args: [],
    );
  }

  /// `Время`
  String get setting_item_11_1 {
    return Intl.message(
      'Время',
      name: 'setting_item_11_1',
      desc: '',
      args: [],
    );
  }

  /// `Расстояние`
  String get setting_item_11_2 {
    return Intl.message(
      'Расстояние',
      name: 'setting_item_11_2',
      desc: '',
      args: [],
    );
  }

  /// `Магнитуда`
  String get setting_item_11_3 {
    return Intl.message(
      'Магнитуда',
      name: 'setting_item_11_3',
      desc: '',
      args: [],
    );
  }

  /// `Политика конфиденциальности`
  String get setting_item_12 {
    return Intl.message(
      'Политика конфиденциальности',
      name: 'setting_item_12',
      desc: '',
      args: [],
    );
  }

  /// `Поделиться приложением`
  String get setting_item_13 {
    return Intl.message(
      'Поделиться приложением',
      name: 'setting_item_13',
      desc: '',
      args: [],
    );
  }

  /// `Оценить приложение`
  String get setting_item_14 {
    return Intl.message(
      'Оценить приложение',
      name: 'setting_item_14',
      desc: '',
      args: [],
    );
  }

  /// `Поддержка`
  String get setting_item_15 {
    return Intl.message(
      'Поддержка',
      name: 'setting_item_15',
      desc: '',
      args: [],
    );
  }

  /// `Поддержать проект`
  String get setting_item_16 {
    return Intl.message(
      'Поддержать проект',
      name: 'setting_item_16',
      desc: '',
      args: [],
    );
  }

  /// `Форумы`
  String get forum_f {
    return Intl.message(
      'Форумы',
      name: 'forum_f',
      desc: '',
      args: [],
    );
  }

  /// `Новости`
  String get forum_n {
    return Intl.message(
      'Новости',
      name: 'forum_n',
      desc: '',
      args: [],
    );
  }

  /// `Сообщений нет`
  String get forum_message_not_found {
    return Intl.message(
      'Сообщений нет',
      name: 'forum_message_not_found',
      desc: '',
      args: [],
    );
  }

  /// `с. назад`
  String get forum_message_second_ago {
    return Intl.message(
      'с. назад',
      name: 'forum_message_second_ago',
      desc: '',
      args: [],
    );
  }

  /// `м. назад`
  String get forum_message_minute_ago {
    return Intl.message(
      'м. назад',
      name: 'forum_message_minute_ago',
      desc: '',
      args: [],
    );
  }

  /// `ч. назад`
  String get forum_message_hour_ago {
    return Intl.message(
      'ч. назад',
      name: 'forum_message_hour_ago',
      desc: '',
      args: [],
    );
  }

  /// `д. назад`
  String get forum_message_day_ago {
    return Intl.message(
      'д. назад',
      name: 'forum_message_day_ago',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
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
