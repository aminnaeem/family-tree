import 'dart:io';

import 'package:family_tree/model/family_member.dart';
import 'package:family_tree/memberdetails/memberdetails_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';


class MemberDetailView extends StatelessWidget {
  final int index;
  final FamilyMember member;
  final Function(int index, FamilyMember updatedMember) onUpdate;

  const MemberDetailView({
    super.key,
    required this.index,
    required this.member,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MemberDetailViewModel>.reactive(
      viewModelBuilder: () => MemberDetailViewModel(
        index: index,
        member: member,
        onUpdate: onUpdate,
      ),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Family Member'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => viewModel.pickImage(context),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: viewModel.imagePath != null && viewModel.imagePath!.isNotEmpty
                        ? FileImage(File(viewModel.imagePath!))
                        : null,
                      child: viewModel.imagePath == null || viewModel.imagePath!.isEmpty
                        ? const Icon(Icons.person, size: 40)
                        : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  TextField(
                    controller: viewModel.nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: viewModel.relationshipController,
                    decoration: const InputDecoration(labelText: 'Relationship'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: viewModel.birthDateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Birth Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        viewModel.birthDateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: viewModel.isAlive,
                        onChanged: viewModel.toggleAlive,
                      ),
                      const Text('Alive'),
                    ],
                  ),
                  if (!viewModel.isAlive)
                    TextField(
                      controller: viewModel.deathDateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Death Date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          viewModel.deathDateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                        }
                      },
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => viewModel.save(context),
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
