import 'package:angular/angular.dart';

import 'src/app_component.dart';

import 'package:angular_youtube_player/angular_youtube_player.dart';

Future<void> main() async {
  onYoutubeReady.listen((_) {
    runApp(appNgFactory);
  });
  await loadYoutubeIframApi();
}
