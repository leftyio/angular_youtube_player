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
class YoutubePlayerComponent implements OnInit {
  final YoutubeProvider provider;

  @Input()
  String width;

  @Input()
  String height;

  @Input()
  String videoId;

  @ViewChild('player')
  DivElement player;

  Player _player;

  YoutubePlayerComponent(this.provider);

  @override
  void ngOnInit() {
    provider.init();
    provider.onYoutubeReady.listen((_) {
      _player = Player(
        player,
        options: PlayerOptions(
          width: width,
          height: height,
          videoId: videoId,
        ),
      );
    });
  }
}
