import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:family_tree/model/family_member.dart';
import 'package:hive/hive.dart';

class MemberDetailViewModel extends BaseViewModel {
  final int index;
  final FamilyMember member;
  final void Function(int, FamilyMember) onUpdate;

  late final TextEditingController nameController;
  late final TextEditingController relationshipController;
  late final TextEditingController birthDateController;
  late final TextEditingController deathDateController;

  bool isAlive = true;

  File? selectedImage;
  String? imagePath;

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

  Future<void> save(BuildContext context) async {
    final updated = FamilyMember(
      name: nameController.text,
      relationship: relationshipController.text,
      birthDate: birthDateController.text,
      deathDate: isAlive ? null : deathDateController.text,
      isAlive: isAlive,
    );

    onUpdate(index, updated);

    // Save to Hive
    final box = await Hive.openBox<FamilyMember>('familyBox');
    if (index < box.length) {
      await box.putAt(index, updated);
    } else {
      await box.add(updated);
    } // update record at index

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
