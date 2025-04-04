# Currency Convert

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

---

## Инструкция по развертыванию и тестированию: 🚀

Flutter версия, самая свежая стабильная на 04.04.2025: 3.29.2

Шаг первый: клонируйте репозиторий либо скачайте как [zip](https://github.com/Numka/currency_convert/archive/refs/heads/main.zip) <- (кликабельно) и разархивируйте
```sh
$ git clone https://github.com/Numka/currency_convert.git
```
Шаг второй: загрузите зависимости из корня проекта, где находится pubspec.yaml
```sh
$ flutter pub get
```
Шаг третий: запуск приложения, если у вас VsCode, то стандартный F5 или ваш хоткей для "Run" -> "Start Debugging", если нет то
```sh
$ flutter run --flavor development --target lib/main_development.dart
```
Шаг четвертый (PWA): сбилдите flutter web
```sh
$ flutter build web --target=lib/main_development.dart
```
Шаг пятый (PWA): любым удобным вам способом задеплойте lib/build/web, я буду использовать firebase, вы можете использовать surge или любой другой метод
```sh
$ firebase login
$ firebase init hosting
# выбрать create new firebase project или use existing one
# далее отвечайте на вопросы как указано через "-"
? What do you want to use as your public directory? - build/web
? Configure as a single-page app (rewrite all urls to /index.html)? - Yes
? Set up automatic builds and deploys with GitHub? - No
? File build/web/index.html already exists. Overwrite? - No
```
Шаг шестой (PWA): сам деплой
```sh
firebase deploy --only hosting
```
Пример уже задеплоеного PWA проекта тут: https://flutter-converter-pwa.web.app/
---

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
