import 'package:angular/angular.dart';
import 'package:angular_youtube_player/angular_youtube_player.dart';

// ignore: uri_has_not_been_generated
import 'app_component.template.dart' as app;

final appNgFactory = app.AppNgFactory;

@Component(
  selector: 'youtube-player-app',
  templateUrl: 'app_component.html',
  directives: [
    YoutubePlayerComponent,
  ],
)
class App {}
