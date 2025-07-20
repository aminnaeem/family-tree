import 'package:family_tree/model/family_member.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddMemberBottomSheetViewModel extends BaseViewModel {
  final Function(FamilyMember) onSave;

  AddMemberBottomSheetViewModel({required this.onSave});

  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final deathDateController = TextEditingController();

  // New dropdown logic
  final List<String> relationshipOptions = [
    'Father',
    'Mother',
    'Brother',
    'Sister',
    'Son',
    'Daughter',
    'Grandfather',
    'Grandmother',
    'Uncle',
    'Aunt',
    'Cousin',
    'Husband',
    'Wife',
    'Other',
  ];

  String? selectedRelationship;
  final customRelationshipController = TextEditingController();

  bool get isOtherSelected => selectedRelationship == 'Other';

  void onRelationshipChanged(String? value) {
    selectedRelationship = value;
    if (value != 'Other') {
      customRelationshipController.clear();
    }
    notifyListeners();
  }

  bool isAlive = true;

  void toggleAlive(bool? value) {
    isAlive = value ?? true;
    notifyListeners();
  }

  String getRelationship() {
    return selectedRelationship == 'Other'
        ? customRelationshipController.text.trim()
        : selectedRelationship ?? '';
  }

  void save(BuildContext context) {
    final member = FamilyMember(
      name: nameController.text.trim(),
      relationship: getRelationship(),
      birthDate: birthDateController.text,
      deathDate: isAlive ? null : deathDateController.text,
      isAlive: isAlive,
    );

    onSave(member);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    deathDateController.dispose();
    customRelationshipController.dispose();
    super.dispose();
  }
}
