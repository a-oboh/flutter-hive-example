import 'package:auto_route/auto_route_annotations.dart';
import 'package:hive_reminder_app/UI/views/home/home_view.dart';


@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: HomeView, initial: true),
  ],
)
class $Router {}
