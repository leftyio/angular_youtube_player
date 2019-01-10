import 'package:dart_browser_loader/dart_browser_loader.dart';

Future<void> loadYoutubeIframApi() => loadScript(
      "https://www.youtube.com/iframe_api",
      id: 'youtube_iframe_api',
    );
