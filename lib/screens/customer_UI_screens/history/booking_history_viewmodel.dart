import 'dart:developer';

import 'package:bookario/app.locator.dart';
import 'package:bookario/models/event_pass_model.dart';
import 'package:bookario/services/authentication_service.dart';
import 'package:bookario/services/firebase_service.dart';
import 'package:bookario/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';

class BookingHistoryViewModel extends BaseViewModel {
  List<bool> isExpanded = [];
  // int limit, offset;
  List<EventPass> eventPasses = [];
  bool hasBookings = false;
  bool screenLoading = true;
  bool loadMore = false;
  bool loadingMore = false;
  List bookingDetails = [];
  List moreBookingDetails = [];

  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void updateIsExpanded(int index) {
    isExpanded[index] = !isExpanded[index];
    notifyListeners();
  }

  Future getBookingData() async {
    final String uid = _authenticationService.currentUser!.id!;

    setBusy(true);
    eventPasses = await _firebaseService.getPasses(uid);
    for (final i in eventPasses) {
      isExpanded.add(false);
    }
    if (eventPasses.isNotEmpty) {
      hasBookings = true;
    }
    eventPasses
        .sort((EventPass a, EventPass b) => b.timeStamp.compareTo(a.timeStamp));
    setBusy(false);
  }
}
