import 'package:hive/hive.dart';

part 'family_member.g.dart'; // Needed for code generation

@HiveType(typeId: 0)
class FamilyMember {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String relationship;

  @HiveField(2)
  final String birthDate;

  @HiveField(3)
  final String? deathDate;

  @HiveField(4)
  final bool isAlive;

  @HiveField(5)
  final String? imagePath;

  FamilyMember({
    required this.name,
    required this.relationship,
    required this.birthDate,
    this.deathDate,
    required this.isAlive,
    required this.imagePath
  });
}
