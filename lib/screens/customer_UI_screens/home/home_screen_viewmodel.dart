import 'dart:developer';

import 'package:bookario/app.locator.dart';
import 'package:bookario/app.router.dart';
import 'package:bookario/components/enum.dart';
import 'package:bookario/models/event_model.dart';
import 'package:bookario/services/firebase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeScreenViewModel extends BaseViewModel {
  final FirebaseService _firebaseService = locator<FirebaseService>();

  List<EventModel> allEvents = [];
  List<EventModel> filteredEvents = [];
  List location = [];
  List<String> allLocations = [];
  bool hasEvents = false;
  String? selectedLocation;

  EventType eventType = EventType.home;

  Future getAllEvents(EventType eventType) async {
    try {
      setBusy(true);
      this.eventType = eventType;
      allEvents.addAll(await _firebaseService.getEvents(eventType));
      hasEvents = allEvents.isNotEmpty;
      filteredEvents = allEvents;
      getAllLocations();
      setBusy(false);
    } catch (e) {
      log(e.toString());
      setBusy(false);
    }
  }

  Future<void> getAllLocations() async {
    try {
      allLocations = ["All", ...await _firebaseService.getAllLocations()];
    } catch (e) {
      log(e.toString());
    }
  }

  void getEventsByLocation() {
    if (selectedLocation != "All") {
      filteredEvents = allEvents
          .where((element) => element.location == selectedLocation)
          .toList();
    } else {
      filteredEvents = allEvents;
    }

    notifyListeners();
  }

  Future showEventDetails(EventModel event) async {
    await locator<NavigationService>().navigateTo(
      Routes.detailsScreen,
      arguments: DetailsScreenArguments(event: event),
    );
  }
}
