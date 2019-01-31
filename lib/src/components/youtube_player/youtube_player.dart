import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_youtube_player/src/interop/player.dart';
import 'package:angular_youtube_player/src/provider/youtube_provider.dart';

@Component(
  selector: 'youtube-player',
  template: '<div #player></div>',
  providers: [
    ClassProvider(YoutubeProvider),
  ],
)
class YoutubePlayerComponent implements OnInit, OnDestroy {
  final YoutubeProvider provider;

  int _width;

  @Input()
  set width(int w) {
    _width = w;

    _player?.setSize(_width, _height);
  }

  int _height;

  @Input()
  set height(int h) {
    _height = h;

    _player?.setSize(_width, _height);
  }

  String _videoId;

  @Input()
  set videoId(String id) {
    _videoId = id;

    _player?.cueVideoById(id);
  }

  @ViewChild('player')
  DivElement player;

  Player _player;
  StreamSubscription<void> _onReadySubscription;

  YoutubePlayerComponent(this.provider);

  Player _initPlayer() => Player(
        player,
        options: PlayerOptions(
          width: _width,
          height: _height,
          videoId: _videoId,
        ),
      );

  @override
  void ngOnInit() {
    provider.init();
    _onReadySubscription = provider.onYoutubeReady.listen((_) {
      _player = _initPlayer();
    });
  }

  @override
  void ngOnDestroy() {
    _onReadySubscription.cancel();
  }

  void play() => _player.play();

  void pause() => _player.pause();

  void stop() => _player.stop();
}
