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
  external int get height;
  external int get width;
  external String get videoId;

  external factory _PlayerOptions({
    int height,
    int width,
    String videoId,
  });
}

class PlayerOptions {
  _PlayerOptions _optionsInterop;

  PlayerOptions({int width, int height, String videoId})
      : _optionsInterop =
            _PlayerOptions(width: width, height: height, videoId: videoId);
}

@JS('YT.Player')
class _Player {
  external _Player(dynamic id, [_PlayerOptions options]);

  external void playVideo();

  external void pauseVideo();

  external void stopVideo();

  external void loadVideoById(
    String id, [
    num startSeconds,
    String suggestedQuality,
  ]);

  external void cueVideoById(
    String id, [
    num startSeconds,
    String suggestedQuality,
  ]);

  external void setSize(int width, int height);

  external void destroy();
}

class Player {
  _Player _playerInterop;

  Player(
    dynamic id, {
    PlayerOptions options,
  }) : _playerInterop = _Player(
          id,
          options._optionsInterop,
        );

  void play() => _playerInterop.playVideo();

  void pause() => _playerInterop.pauseVideo();

  void stop() => _playerInterop.stopVideo();

  void loadVideoById(
    String id, {
    num startSeconds,
    String suggestedQuality,
  }) =>
      _playerInterop.loadVideoById(id, startSeconds, suggestedQuality);

  void cueVideoById(
    String id, {
    num startSeconds,
    String suggestedQuality,
  }) =>
      _playerInterop.cueVideoById(id, startSeconds, suggestedQuality);

  void setSize(int width, int height) => _playerInterop.setSize(width, height);

  void dispose() => _playerInterop.destroy();
}
