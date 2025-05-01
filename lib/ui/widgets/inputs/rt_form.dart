import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/model/participant.dart';
import 'package:race_tracker/ui/theme/theme.dart';
import 'package:race_tracker/ui/widgets/actions/rt_button.dart';
import 'package:race_tracker/ui/widgets/actions/rt_text_button.dart';

import '../../provider/participant_provider.dart';
import '../navigation/rt_top_bar.dart';

class RTForm extends StatefulWidget {
  const RTForm({
    super.key,
    required this.title,
    this.participant,
    this.isEditMode = false,
  });

  final String title;
  final Participant? participant;
  final bool isEditMode;

  @override
  State<RTForm> createState() => _RTFormState();
}

class _RTFormState extends State<RTForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedGender;
  final List<String> listOfGender = ['Male', 'Female'];

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.participant?.firstName,
    );
    _lastNameController = TextEditingController(
      text: widget.participant?.lastName,
    );
    _ageController = TextEditingController(
      text: widget.participant?.age.toString() ?? '',
    );
    _selectedGender = widget.participant?.gender;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _saveParticipant(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final participant = Participant(
        id: widget.participant?.id ?? '',
        bib: widget.participant?.bib ?? '',
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        age: int.tryParse(_ageController.text.trim()) ?? 0,
        gender: _selectedGender ?? '',
      );

      final participantProvider = Provider.of<ParticipantProvider>(
        context,
        listen: false,
      );

      if (widget.isEditMode) {
        participantProvider.updateParticipant(participant);
      } else {
        participantProvider.addParticipant(participant);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RTTopBar(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.all(RTSpacings.s),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                maxLength: 20,
                decoration: const InputDecoration(label: Text('First Name')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length > 20) {
                    return 'Must be between 1 and 20 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: RTSpacings.s),
              TextFormField(
                controller: _lastNameController,
                maxLength: 20,
                decoration: const InputDecoration(label: Text('Last Name')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length > 20) {
                    return 'Must be between 1 and 20 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: RTSpacings.s),
              TextFormField(
                controller: _ageController,
                maxLength: 2,
                decoration: const InputDecoration(label: Text('Age')),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  final age = int.tryParse(value ?? '');
                  if (age == null || age <= 12 || age > 59) {
                    return 'Enter a valid age (12-59).';
                  }
                  return null;
                },
              ),
              const SizedBox(height: RTSpacings.s),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                hint: const Text('Gender'),
                isExpanded: true,
                items:
                    listOfGender.map((String gen) {
                      return DropdownMenuItem(value: gen, child: Text(gen));
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a gender.';
                  }
                  return null;
                },
                key: Key('genderDropdown'),
              ),
              const SizedBox(height: RTSpacings.m),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RTTextButton(
                    text: 'Reset',
                    onPressed: () {
                      _formKey.currentState!.reset();
                      setState(() {
                        _firstNameController.clear();
                        _lastNameController.clear();
                        _ageController.clear();
                        _selectedGender = null;
                      });
                    },
                  ),
                  const SizedBox(width: RTSpacings.s),
                  RTButton(
                    text: widget.isEditMode ? 'Update' : 'Add',
                    onPressed: () => _saveParticipant(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
