import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:angular/angular.dart';
import 'package:youtube_iframe_interop/youtube_iframe_interop.dart';
import 'youtube_provider.dart';

@Component(
  selector: 'youtube-player',
  template: '<div #player></div>',
  providers: [
    ClassProvider(YoutubeProvider),
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
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

  int _width = 0;

  @Input()
  set width(int w) {
    _width = w;

    _player?.setSize(_width, _height);
  }

  int _height = 0;

  @Input()
  set height(int h) {
    _height = h;

    _player?.setSize(_width, _height);
  }

  late String _videoId;

  @Input()
  set videoId(String id) {
    _videoId = id;

    _player?.cueVideoById(id);
  }

  @ViewChild('player')
  DivElement? playerElement;

  Player? _player;
  Player? get player => _player;

  YoutubePlayerComponent(this.provider);

  Player _initPlayer() => Player(
        playerElement,
        PlayerOptions(
          width: _width,
          height: _height,
          videoId: _videoId,
          events: Events(
            onReady: allowInterop(_onReady.add),
            onError: allowInterop(_onError.add),
            onApiChange: allowInterop(_onApiChange.add),
            onPlaybackQualityChange: allowInterop(_onPlaybackQualityChange.add),
            onPlaybackRateChange: allowInterop(_onPlaybackRateChange.add),
            onStateChange: allowInterop(_onStateChange.add),
          ),
        ),
      );

  @override
  Future<void> ngOnInit() async {
    await provider.init();
    _player = _initPlayer();
  }

  @override
  void ngOnDestroy() {
    _onReady.close();
    _onStateChange.close();
    _onPlaybackQualityChange.close();
    _onPlaybackRateChange.close();
    _onError.close();
    _onApiChange.close();
    _player?.destroy();
    _player = null;
  }

  void play() => _player?..playVideo();

  void pause() => _player?.pauseVideo();

  void stop() => _player?.stopVideo();
}
