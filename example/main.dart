import 'package:angular/angular.dart';

import 'src/app_component.dart';

import 'package:angular_youtube_player/angular_youtube_player.dart';

Future<void> main() async {
  await loadYoutubeIframApi();
  onYoutubeReady.listen((_) {
    runApp(appNgFactory);
  });
}
