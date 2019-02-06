import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:youtube_iframe_interop/youtube_iframe_interop.dart';
import 'youtube_provider.dart';

@Component(
  selector: 'youtube-player',
  template: '<div #player></div>',
  providers: [
    ClassProvider(YoutubeProvider),
  ],
)
class YoutubePlayerComponent implements OnInit, OnDestroy {
  final YoutubeProvider provider;

  @Output('ready')
  Stream<PlayerEvent> get onReady => _onReady.stream;
  final _onReady = StreamController<PlayerEvent>.broadcast();

  @Output('stateChange')
  Stream<PlayerEvent> get onStateChange => _onStateChange.stream;
  final _onStateChange = StreamController<PlayerEvent>.broadcast();

  @Output('playbackQualityChange')
  Stream<PlayerEvent> get onPlaybackQualityChange =>
      _onPlaybackQualityChange.stream;
  final _onPlaybackQualityChange = StreamController<PlayerEvent>.broadcast();

  @Output('playbackRateChange')
  Stream<PlayerEvent> get onPlaybackRateChange => _onPlaybackRateChange.stream;
  final _onPlaybackRateChange = StreamController<PlayerEvent>.broadcast();

  @Output('error')
  Stream<PlayerEvent> get onError => _onError.stream;
  final _onError = StreamController<PlayerEvent>.broadcast();

  @Output('apiChange')
  Stream<PlayerEvent> get onApiChange => _onApiChange.stream;
  final _onApiChange = StreamController<PlayerEvent>.broadcast();

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
          events: PlayerEvents(
            onReady: _onReady.add,
          ),
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
    _onReady.close();
    _onStateChange.close();
    _onPlaybackQualityChange.close();
    _onPlaybackRateChange.close();
    _onError.close();
    _onApiChange.close();
    _onReadySubscription.cancel();
    _player?.dispose();
    _player = null;
  }

  void play() => _player.play();

  void pause() => _player.pause();

  void stop() => _player.stop();
}
