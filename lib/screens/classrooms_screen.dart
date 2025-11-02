import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coderz1/bloc/classroom_bloc/classroom_bloc.dart';
import 'package:coderz1/bloc/classroom_bloc/classroom_event.dart';
import 'package:coderz1/bloc/classroom_bloc/classroom_state.dart';
import 'package:coderz1/bloc/models/classroom_model.dart';

class ClassroomsScreen extends StatefulWidget {
  const ClassroomsScreen({super.key});

  @override
  State<ClassroomsScreen> createState() => _ClassroomsScreenState();
}

class _ClassroomsScreenState extends State<ClassroomsScreen> {
  final TextEditingController _nameController = TextEditingController();
  Classroom? _selectedClassroom;

  @override
  void initState() {
    super.initState();
    context.read<ClassroomBloc>().add(FetchClassrooms());
  }

  void _showClassroomDialog({Classroom? classroom}) {
    _selectedClassroom = classroom;
    if (classroom != null) {
      _nameController.text = classroom.name;
    } else {
      _nameController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(classroom == null ? 'Add Classroom' : 'Edit Classroom'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Classroom Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = _nameController.text;
              if (name.isNotEmpty) {
                if (_selectedClassroom == null) {
                  context.read<ClassroomBloc>().add(
                    AddClassroom(Classroom(classroomId: 0, name: name)),
                  );
                } else {
                  context.read<ClassroomBloc>().add(
                    UpdateClassroom(_selectedClassroom!.copyWith(name: name)),
                  );
                }
                Navigator.pop(context);
              }
            },
            child: Text(classroom == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classrooms'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showClassroomDialog(),
          ),
        ],
      ),
      body: BlocConsumer<ClassroomBloc, ClassroomState>(
        listener: (context, state) {
          if (state is ClassroomActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is ClassroomActionFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
          } else if (state is ClassroomError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is ClassroomLoading && state is! ClassroomsLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ClassroomsLoaded) {
            return ListView.builder(
              itemCount: state.classrooms.length,
              itemBuilder: (context, index) {
                final classroom = state.classrooms[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(classroom.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showClassroomDialog(classroom: classroom),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<ClassroomBloc>().add(
                              DeleteClassroom(classroom.classroomId),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ClassroomError) {
            return Center(
              child: Text('Failed to load classrooms: ${state.message}'),
            );
          } else if (state is ClassroomActionFailure) {
            return Center(child: Text('Action failed: ${state.error}'));
          }
          return const Center(child: Text('No classrooms loaded.'));
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
