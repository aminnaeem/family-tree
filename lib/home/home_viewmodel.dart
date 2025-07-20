import 'package:family_tree/app/app.locator.dart';
import 'package:family_tree/app/app.router.dart';
import 'package:family_tree/bottomsheet/addmemberbottomsheet_view.dart';
import 'package:family_tree/model/family_member.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  late final Box<FamilyMember> _box;

  final List<FamilyMember> _members = [];
  List<FamilyMember> get members => _members;

  HomeViewModel() {
    _init();
  }

  Future<void> _init() async {
    _box = Hive.box<FamilyMember>('members');
    _members.clear();
    _members.addAll(_box.values);
    notifyListeners();
  }

  int calculateAge(String birthDate) {
    final birth = DateTime.tryParse(birthDate);
    if (birth == null) return 0;
    final today = DateTime.now();
    int age = today.year - birth.year;
    if (today.month < birth.month || (today.month == birth.month && today.day < birth.day)) {
      age--;
    }
    return age;
  }

  void addFamilyMember(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddMemberBottomSheetView(
        onSave: (member) {
          _members.add(member);
          _box.add(member); // Save to Hive
          notifyListeners();
        },
      ),
    );
  }

  void deleteMember(int index) {
    members.removeAt(index);
    notifyListeners();
  }

  void openMemberDetail(int index) {
    _navigationService.navigateToMemberDetailView(
      index: index,
      member: _members[index],
      onUpdate: (i, updatedMember) {
        _members[i] = updatedMember;
        _box.putAt(i, updatedMember); // Update Hive too
        notifyListeners();
      },
    );
  }
}
