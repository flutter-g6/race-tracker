import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:race_tracker/ui/theme/theme.dart';
import 'package:race_tracker/ui/widgets/actions/rt_button.dart';
import 'package:race_tracker/ui/widgets/actions/rt_text_button.dart';

import '../widgets/navigation/rt_top_bar.dart';

class RTForm extends StatefulWidget {
  const RTForm({super.key});

  @override
  State<RTForm> createState() => _RTFormState();
}

class _RTFormState extends State<RTForm> {
  final _formKey = GlobalKey<FormState>();

  void _saveParticipant() {
    _formKey.currentState!.validate();
  }

  String? _selectedGender;
  final List<String> listOfGender = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RTTopBar(title: 'Add Participant'),
      body: Padding(
        padding: const EdgeInsets.all(RTSpacings.s),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 20,
                decoration: const InputDecoration(label: Text('First Name')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 20) {
                    return 'Must be between 1 and 20 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: RTSpacings.s),
              TextFormField(
                maxLength: 20,
                decoration: const InputDecoration(label: Text('Last Name')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 20) {
                    return 'Must be between 1 and 20 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: RTSpacings.s),
              TextFormField(
                maxLength: 2,
                decoration: const InputDecoration(label: Text('Age')),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null ||
                      int.tryParse(value)! <= 0) {
                    return 'Must be a valid, positive number and smaller than 100.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: RTSpacings.s),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                hint: Text('Gender'),
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
                onSaved: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a gender';
                  }
                  return null;
                },
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
                        _selectedGender = null;
                      });
                    },
                  ),
                  const SizedBox(width: RTSpacings.s),
                  RTButton(text: 'Add', onPressed: _saveParticipant),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
