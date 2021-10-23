import 'dart:async';
import 'dart:js';

import 'package:youtube_iframe_interop/youtube_iframe_interop.dart';

class YoutubeProvider {
  static final _instance = YoutubeProvider._();

  factory YoutubeProvider() => _instance;

  YoutubeProvider._();


  final _completer = Completer<void>();

  bool _isInit = false;

  Future<void> init() async {
    if (_isInit) return onYoutubeReady;
    _isInit = true;

    onYouTubeIframeAPIReady = allowInterop(() => _completer.complete(null));

    loadYoutubeIframeApi();

    return onYoutubeReady;
  }

  Future<void> get onYoutubeReady => _completer.future;
}
