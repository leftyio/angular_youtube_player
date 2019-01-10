@JS()
library youtube_player_interop;

import 'package:js/js.dart';

@JS('onYouTubeIframeAPIReady')
external void set _onYouTubeIframeAPIReady(Function f);

set onYouTubeIframeAPIReady(Function f) =>
    _onYouTubeIframeAPIReady = allowInterop(f);

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
  external _Player(dynamic id, [_PlayerOptions options]);
}

class Player {
  _Player _playerInterop;

  Player(dynamic id, {PlayerOptions options})
      : _playerInterop = _Player(id, options._optionsInterop);
}
