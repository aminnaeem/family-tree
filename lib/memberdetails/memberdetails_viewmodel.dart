// viewmodels/member_detail_viewmodel.dart

import 'dart:io';

import 'package:family_tree/model/family_member.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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

  void save(BuildContext context) {
    final updated = FamilyMember(
      name: nameController.text,
      relationship: relationshipController.text,
      birthDate: birthDateController.text,
      deathDate: isAlive ? null : deathDateController.text,
      isAlive: isAlive,
      imagePath: imagePath,
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

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final directory = await getApplicationDocumentsDirectory();
      final savedImage = File('${directory.path}/${picked.name}');
      await File(picked.path).copy(savedImage.path);

      imagePath = savedImage.path;
      notifyListeners();
    }
  }
}
