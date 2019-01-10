@JS()
library youtube_player_interop;

import 'dart:async';

import 'package:js/js.dart';

@JS('onYouTubeIframeAPIReady')
external void set _onYouTubeIframeAPIReady(Function f);

bool _isAlreadyLoaded = false;
Stream<void> get onYoutubeReady {
  final _youtubeReadyController = StreamController<void>();
  if (_isAlreadyLoaded) {
    _youtubeReadyController.add(null);
    _youtubeReadyController.close();
    return _youtubeReadyController.stream;
  }
  _onYouTubeIframeAPIReady = allowInterop((_) {
    _isAlreadyLoaded = true;
    _youtubeReadyController.add(null);
    _youtubeReadyController.close();
  });
  return _youtubeReadyController.stream;
}

@JS()
@anonymous
class _PlayerOptions {
  external String get height;
  external String get width;
  external String get videoId;

  external factory _PlayerOptions(
      {String height, String width, String videoId});
}

class PlayerOptions {
  _PlayerOptions _optionsInterop;

  PlayerOptions({String width, String height, String videoId})
      : _optionsInterop =
            _PlayerOptions(width: width, height: height, videoId: videoId);
}

@JS('YT.Player')
class _Player {
  external _Player(String id, [_PlayerOptions options]);
}

class Player {
  _Player _playerInterop;

  Player(String id, {PlayerOptions options})
      : _playerInterop = _Player(id, options._optionsInterop);
}
