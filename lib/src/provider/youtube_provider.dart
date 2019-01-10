import 'dart:async';

import 'package:angular_youtube_player/src/interop/player.dart';
import 'package:angular_youtube_player/src/utils/load_script.dart';

class YoutubeProvider {
  static YoutubeProvider youtubeProvider;

  Future<void> isReady;
  bool _isInit = false;
  StreamController<void> _youtubeReadyController;
  Stream<void> _ready;

  factory YoutubeProvider() {
    youtubeProvider ??= YoutubeProvider._();
    return youtubeProvider;
  }

  YoutubeProvider._() {
    _youtubeReadyController = StreamController<void>(onListen: () {
      if (_isInit) {
        _youtubeReadyController.add(null);
      }
    });
  }

  Future<void> init() async {
    final completer = Completer<void>();
    isReady = completer.future;
    onYouTubeIframeAPIReady = (_) {
      _isInit = true;
      _youtubeReadyController.add(null);
      completer.complete(null);
    };
    await loadYoutubeIframApi();
  }

  Stream<void> get onYoutubeReady {
    isReady.then((_) {
      if (_isInit) {
        _youtubeReadyController.add(null);
        return _youtubeReadyController.stream;
      }
    });
    return _ready ??= _youtubeReadyController.stream.asBroadcastStream();
  }
}
