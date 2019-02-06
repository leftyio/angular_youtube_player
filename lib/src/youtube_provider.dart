import 'dart:async';

import 'package:youtube_iframe_interop/youtube_iframe_interop.dart';

class YoutubeProvider {
  static YoutubeProvider _youtubeSingleton;

  Future<void> _isReady;
  bool _isInit = false;
  StreamController<void> _youtubeReadyController;
  Stream<void> _ready;

  factory YoutubeProvider() => _youtubeSingleton ??= YoutubeProvider._();

  YoutubeProvider._() {
    _youtubeReadyController = StreamController<void>.broadcast(onListen: () {
      if (_isInit) {
        _youtubeReadyController.add(null);
      }
    });
  }

  Future<void> init() async {
    if (_isReady == null) {
      final completer = Completer<void>();
      _isReady = completer.future;
      onYouTubeIframeAPIReady = () {
        _isInit = true;
        _youtubeReadyController.add(null);
        completer.complete(null);
      };
      await loadYoutubeIframApi();
    }
  }

  Stream<void> get onYoutubeReady {
    if (_ready == null) {
      _ready = _youtubeReadyController.stream;

      _isReady.then((_) {
        if (_isInit) {
          _youtubeReadyController.add(null);
        }
      });
    }
    return _ready;
  }
}
