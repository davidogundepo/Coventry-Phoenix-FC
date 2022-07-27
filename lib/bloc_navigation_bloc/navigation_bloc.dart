
import 'package:flutter_bloc/flutter_bloc.dart';
import '../thrown_pages/management_thrown_page.dart';
import '../thrown_pages/coaches_thrown_page.dart';
import '../thrown_pages/first_team_thrown_page.dart';
import '../thrown_pages/second_team_thrown_page.dart';
import '../thrown_pages/third_team_thrown_page.dart';
import '../thrown_pages/captains_thrown_page.dart';

enum NavigationEvents {
  myFirstTeamClassPageClickedEvent,
  mySecondTeamClassPageClickedEvent,
  myThirdTeamClassPageClickedEvent,
  myCoachesPageClickedEvent,
  myManagementBodyPageClickedEvent,
  myCaptainsPageClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {

  NavigationBloc() : super(MyFirstTeamClassPage());


  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.myFirstTeamClassPageClickedEvent:
        yield MyFirstTeamClassPage();
        break;
      case NavigationEvents.mySecondTeamClassPageClickedEvent:
        yield MySecondTeamClassPage();
        break;
      case NavigationEvents.myThirdTeamClassPageClickedEvent:
        yield MyThirdTeamClassPage();
        break;
      case NavigationEvents.myCoachesPageClickedEvent:
        yield MyCoachesPage();
        break;
      case NavigationEvents.myManagementBodyPageClickedEvent:
        yield MyManagementBodyPage();
        break;
      case NavigationEvents.myCaptainsPageClickedEvent:
        yield MyCaptainsPage();
        break;
    }
  }


}
