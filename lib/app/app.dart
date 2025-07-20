import 'package:family_tree/home/home_view.dart';
import 'package:family_tree/memberdetails/memberdetails_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';


@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: MemberDetailView,)

  ],
  dependencies: [
    Singleton(classType: NavigationService)
  ],
)
class App {}