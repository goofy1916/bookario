import 'package:bookario/app.locator.dart';
import 'package:bookario/app.router.dart';
import 'package:bookario/models/event_model.dart';
import 'package:bookario/models/event_pass_model.dart';
import 'package:bookario/models/pass_type_model.dart';
import 'package:bookario/routes.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum passTypes { male, female, couple, table }

class BookPassViewModel extends BaseViewModel {
  final GlobalKey<FormState> bookingFormKey = GlobalKey<FormState>();
  bool booked = false;
  bool addClicked = false;
  bool isPassCoupleType = false;
  final List<Map> bookings = [];
  final List<String> errors = [];
  passTypes? passType;
  double totalPrice = 0.0;
  double discount = 0.00;
  List<String> dropDownList = [];

  Map<String, dynamic> passEntry = {};

  List<Passes> passes = [];

  late EventModel event;

  PassType? selectedPass;

  List<PassType>? applicablePasses = [];

  int maleCount = 0;

  int femaleCount = 0;

  int couplesCount = 0;

  int tableCount = 0;

  bool validateAndSave() {
    final FormState? form = bookingFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void updateDetails(
    EventModel selectedEvent,
  ) {
    event = selectedEvent;
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      errors.add(error);
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      errors.remove(error);
    }
  }

  void showPassDetailsForm(String type) {
    passEntry = {};
    passEntry['name'] = TextEditingController();
    passEntry['age'] = TextEditingController();
    if (type.contains("Male")) {
      passType = passTypes.male;
      applicablePasses = event.stagMaleEntry;
      passEntry['entryType'] = "Stag Male Entry";
      passEntry['gender'] = "Male";
    } else if (type.contains("Female")) {
      passType = passTypes.female;
      applicablePasses = event.stagFemaleEntry;
      passEntry['entryType'] = "Stag Female Entry";
      passEntry['gender'] = "Female";
    } else if (type.contains("Couple")) {
      passType = passTypes.couple;
      passEntry = {};
      passEntry['entryType'] = "Couple Entry";
      passEntry['maleName'] = TextEditingController();
      passEntry['maleAge'] = TextEditingController();
      passEntry['maleGender'] = "Male";
      passEntry['femaleName'] = TextEditingController();
      passEntry['femaleAge'] = TextEditingController();
      passEntry['femaleGender'] = "Female";
      applicablePasses = event.coupleEntry;
    } else if (type.contains("Table")) {
      passType = passTypes.table;
      passEntry['entryType'] = "Table";
      passEntry['gender'] = "table";
      applicablePasses = event.tableOption;
    } else {
      passType = null;
    }
    notifyListeners();
  }

  void updatePassEntrySelectedPass() {
    passEntry['passType'] = getPassType(selectedPass!);
  }

  String getPassType(PassType pass) {
    return "${pass.type} : ₹ ${pass.cover + pass.entry}${(pass.cover > 0.0) ? " (Cover ₹${pass.cover})" : ""} ${(pass.allowed != null) ? " Admits : ${pass.allowed}" : ""}";
  }

  void addPass() {
    if (passType == passTypes.couple) {
      maleCount++;
      femaleCount++;
      passes.add(
        Passes.fromJson({
          "entryType": passEntry['entryType'],
          "maleName": passEntry['maleName'].text,
          "maleAge": int.parse(passEntry['maleAge'].text as String),
          "maleGender": 'Male',
          "femaleName": passEntry['femaleName'].text,
          "femaleAge": int.parse(passEntry['femaleAge'].text as String),
          "passType": passEntry['passType'],
          "femaleGender": 'Female',
          "passCost": selectedPass!.cover + selectedPass!.entry
        }),
      );
    } else {
      if ((passEntry['gender'] as String).contains("Male")) {
        maleCount++;
      } else if ((passEntry['gender'] as String).contains("Female")) {
        femaleCount++;
      } else {
        tableCount++;
      }
      passes.add(
        Passes.fromJson({
          "entryType": passEntry['entryType'],
          "name": passEntry['name'].text,
          "age": int.parse(passEntry['age'].text as String),
          "passType": passEntry['passType'],
          "gender": passEntry['gender'],
          "passCost": selectedPass!.cover + selectedPass!.entry
        }),
      );
    }
    totalPrice += selectedPass!.cover + selectedPass!.entry;
    passEntry = {};
    passType = null;
    dropDownList = [];
    selectedPass = null;
    notifyListeners();
  }

  Future book() async {
    if (passes.isNotEmpty) {
      await locator<NavigationService>().navigateTo(
        Routes.confirmBookingView,
        arguments: ConfirmBookingViewArguments(
            event: event, passes: passes, totalPrice: totalPrice),
      );
    } else {
      locator<DialogService>().showDialog(
        title: "Error",
        description: "Add at least one pass to proceed!",
      );
    }
  }

  bool checkRatio() {
    if (event.femaleRatio > 0 && event.maleRatio > 0) {
      final double requiredRatio = event.femaleRatio / event.maleRatio;
      final double currentRatio = event.totalFemale / event.totalMale;
      if (currentRatio >= requiredRatio) return true;
    }
    return true;
  }
}
