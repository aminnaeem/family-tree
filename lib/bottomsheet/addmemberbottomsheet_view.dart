import 'package:family_tree/bottomsheet/addmemberbottomsheet_viewmodel.dart';
import 'package:family_tree/model/family_member.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class AddMemberBottomSheetView extends StackedView<AddMemberBottomSheetViewModel> {
  final Function(FamilyMember) onSave;

  const AddMemberBottomSheetView({super.key, required this.onSave});

  @override
  Widget builder(
    BuildContext context,
    AddMemberBottomSheetViewModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: viewModel.nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),

            // Relationship Dropdown
            DropdownButtonFormField<String>(
              value: viewModel.selectedRelationship,
              items: viewModel.relationshipOptions
                  .map((relation) => DropdownMenuItem(
                        value: relation,
                        child: Text(relation),
                      ))
                  .toList(),
              onChanged: viewModel.onRelationshipChanged,
              decoration: const InputDecoration(
                labelText: 'Relationship',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Show custom text field if "Other"
            if (viewModel.isOtherSelected)
              TextField(
                controller: viewModel.customRelationshipController,
                decoration: const InputDecoration(
                  labelText: 'Enter Custom Relationship',
                  border: OutlineInputBorder(),
                ),
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
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  AddMemberBottomSheetViewModel viewModelBuilder(BuildContext context) =>
      AddMemberBottomSheetViewModel(onSave: onSave);
}
