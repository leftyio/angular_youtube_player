import 'dart:async';

import 'package:angular_youtube_player/src/interop/player.dart';
import 'package:angular_youtube_player/src/utils/load_script.dart';

class YoutubeProvider {
  static YoutubeProvider _youtubeSingleton;

  Future<void> _isReady;
  bool _isInit = false;
  StreamController<void> _youtubeReadyController;
  Stream<void> _ready;

  factory YoutubeProvider() {
    if (_youtubeSingleton == null) {
      _youtubeSingleton = YoutubeProvider._();
    }
    return _youtubeSingleton;
  }

  YoutubeProvider._() {
    _youtubeReadyController = StreamController<void>(onListen: () {
      if (_isInit) {
        _youtubeReadyController.add(null);
      }
    });
  }

  Future<void> init() async {
    if (_isReady == null) {
      final completer = Completer<void>();
      _isReady = completer.future;
      onYouTubeIframeAPIReady = (_) {
        _isInit = true;
        _youtubeReadyController.add(null);
        completer.complete(null);
      };
      await loadYoutubeIframApi();
    }
  }

  Stream<void> get onYoutubeReady {
    _isReady.then((_) {
      if (_isInit) {
        _youtubeReadyController.add(null);
      }
    });
    return _ready ??= _youtubeReadyController.stream.asBroadcastStream();
  }
}
