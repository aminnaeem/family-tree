import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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
      imagePath: imagePath,
    );

    onUpdate(index, updated);

    // Save to Hive
    final box = await Hive.openBox<FamilyMember>('members');
    if (index < box.length) {
      await box.putAt(index, updated);
    } else {
      await box.add(updated);
    } // update record at index

    Navigator.of(context).pop();
  }

  Future<void> pickImage(BuildContext context) async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imagePath = pickedFile.path;
        notifyListeners();
      }
    } else if (status.isDenied || status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'This app needs access to your gallery to pick an image. '
            'Please grant the permission in app settings.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings(); // opens system app settings
                Navigator.of(context).pop();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
    }
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
