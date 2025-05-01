import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/ui/screens/rt_form.dart';
import 'package:race_tracker/ui/widgets/navigation/rt_top_bar.dart';
import 'package:race_tracker/ui/widgets/navigation/rt_nav_bar.dart';
import 'package:race_tracker/ui/provider/participant_provider.dart';
import '../theme/theme.dart';
import '../widgets/actions/rt_alert_dialog.dart';
import '../widgets/display/rt_list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RTColors.backGroundColor,
      appBar: RTTopBar(
        title: 'Participants',
        actions: [
          IconButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const RTForm(title: 'Add Participant'),
                  ),
                ),
            icon: Icon(Icons.add, color: RTColors.black),
          ),
        ],
      ),
      body: Consumer<ParticipantProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!provider.hasData || provider.participantState?.data == null) {
            return Center(
              child: Text(
                'No participants found.',
                style: RTTextStyles.subHeading.copyWith(
                  color: RTColors.greyLight,
                ),
              ),
            );
          }

          final participants = provider.participantState!.data!;
          return ListView.builder(
            padding: const EdgeInsets.only(top: RTSpacings.m),
            itemCount: participants.length,
            itemBuilder: (context, index) {
              final participant = participants[index];
              return Dismissible(
                key: Key(participant.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: RTColors.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: RTSpacings.m),
                  child: Icon(Icons.delete, color: RTColors.white),
                ),
                confirmDismiss: (direction) async {
                  final result = await showDialog<bool>(
                    context: context,
                    builder:
                        (context) => RTAlertDialog(
                          title: 'Delete Participant',
                          content:
                              'Delete ${participant.firstName} ${participant.lastName}?',
                        ),
                  );
                  return result ?? false;
                },
                onDismissed: (direction) {
                  final deletedParticipant = participant;
                  provider.deleteParticipant(participant.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Participant deleted'),
                      action: SnackBarAction(
                        label: 'Undo',
                        textColor: RTColors.secondary,
                        onPressed: () {
                          provider.addParticipant(deletedParticipant);
                        },
                      ),
                      backgroundColor: RTColors.primary,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: RTSpacings.m,
                    vertical: RTSpacings.s,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: RTColors.primary.withAlpha(124),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: RTListTile(
                      leading: Text(
                        'Bib${participant.bib}',
                        style: RTTextStyles.body.copyWith(
                          fontWeight: FontWeight.bold,
                          color: RTColors.primary,
                        ),
                      ),
                      title: '${participant.firstName} ${participant.lastName}',
                      trailingIcon: Icons.edit,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: RTSpacings.s,
                        horizontal: RTSpacings.m,
                      ),
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => RTForm(
                                    title: 'Edit Participant',
                                    participant: participant,
                                    isEditMode: true,
                                  ),
                            ),
                          ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const RTNavBar(),
    );
  }
}
