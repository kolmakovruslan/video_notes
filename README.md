# Video notes

Приложение для видеозаметок на [Flutter](https://flutter.dev).

### Зависимости

[Flutter sdk](https://github.com/flutter/flutter) >=2.1.0 <3.0.0 - фреймворк.  
[camrera](https://pub.dartlang.org/packages/camera) 0.4.2 - библиоткеа предоставляющая доступ к камере устройства. Использутеся для записи видео.  
[path_provider](https://pub.dartlang.org/packages/path_provider) 0.5.0 - библиотка предоставляющая путь к паке для хранения внутренних файлов приложения.  
[uuid](https://pub.dartlang.org/packages/uuid) 2.0.0 - библиотека для генерации uuid. Используется для генерации имени новой заметки.  
[video_player](https://pub.dartlang.org/packages/video_player) 0.10.0+2 - библиотека для воспроизведения видео (обёртка над ExoPlayer на Android).  
[flutter_range_slider](https://pub.dartlang.org/packages/flutter_range_slider) 1.1.0 - библиотке предоставляющая виджет слайдера по диапозону. Используется для обрезки видео.  
[flutter_ffmpeg](https://pub.dartlang.org/packages/flutter_ffmpeg) v0.1.1 -
используется пакет packages/flutter_ffmpeg_video_lts. Библиотка даёт достпу к собранной по мобильную платформу версии FFmpeg (софт для работы с медиафайлами). Используется для обрезки видео.  

### Структура приложения

/lib/pages - содержит файлы с описание экранов приложения.  
/lib/wigets - вспомоательные виджеты.  
/lib/model - содержит файлы содержащие логику работы и объекты данных приложения.  
/lib/main.dart - точка входа.  
/lib/routes.dart - набор маршрутов.  

### Функции приложения

- создание видео заметок
- обрезка видео
- шаринг.