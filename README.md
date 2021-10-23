[![Dart](https://github.com/leftyio/angular_youtube_player/actions/workflows/dart.yml/badge.svg)](https://github.com/leftyio/angular_youtube_player/actions/workflows/dart.yml)

# Angular Youtube iframe component

### Example

```dart
import 'package:angular/angular.dart';
import 'package:angular_youtube_player/angular_youtube_player.dart';

@Component(
  selector: 'youtube-player-app',
  templateUrl: 'app_component.html',
  directives: [
    YoutubePlayerComponent,
  ],
)
class App {
  void onReady(PlayerEvent event) {
    event.target.playVideo();
  }
}
```

```html
<youtube-player [width]="800"
                [height]="600"
                videoId="nGlh4SVrsFg"
                (ready)="onReady($event)"></youtube-player>
```