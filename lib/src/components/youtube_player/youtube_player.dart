import 'package:angular/angular.dart';
import 'package:angular_youtube_player/src/interop/player.dart';

@Component(
  selector: 'youtube-player',
  template: '<div id="player"></div>',
)
class YoutubePlayerComponent implements OnInit {
  @Input()
  String width;

  @Input()
  String height;

  @Input()
  String videoId;

  Player _player;

  @override
  void ngOnInit() {
    _player = Player(
      'player',
      options: PlayerOptions(
        width: width,
        height: height,
        videoId: videoId,
      ),
    );
  }
}
