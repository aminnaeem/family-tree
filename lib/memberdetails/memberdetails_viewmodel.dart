// viewmodels/member_detail_viewmodel.dart

import 'package:family_tree/model/family_member.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MemberDetailViewModel extends BaseViewModel {
  final int index;
  final FamilyMember member;
  final void Function(int, FamilyMember) onUpdate;

  late final TextEditingController nameController;
  late final TextEditingController relationshipController;
  late final TextEditingController birthDateController;
  late final TextEditingController deathDateController;

  bool isAlive = true;

  MemberDetailViewModel({
    required this.index,
    required this.member,
    required this.onUpdate,
  }) {
    nameController = TextEditingController(text: member.name);
    relationshipController = TextEditingController(text: member.relationship);
    birthDateController = TextEditingController(text: member.birthDate);
    deathDateController = TextEditingController(text: member.deathDate ?? '');
    isAlive = member.isAlive;
  }

  void toggleAlive(bool? value) {
    isAlive = value ?? true;
    notifyListeners();
  }

  void save(BuildContext context) {
    final updated = FamilyMember(
      name: nameController.text,
      relationship: relationshipController.text,
      birthDate: birthDateController.text,
      deathDate: isAlive ? null : deathDateController.text,
      isAlive: isAlive,
    );

    onUpdate(index, updated);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    nameController.dispose();
    relationshipController.dispose();
    birthDateController.dispose();
    deathDateController.dispose();
    super.dispose();
  }
}
