import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/Home/bloc/home_bloc.dart';
import 'package:to_do_app/features/single_task/ui/single_task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc _homeBloc = HomeBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    _homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Task Manager')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => showDialogBox(context, _homeBloc),
          );
        },
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        bloc: _homeBloc,
        listener: (context, state) {
          if (state is HomeNavigateToTaskDetailsState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        SingleTask(title: state.title, content: state.content),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadedState:
              final loadedState = state as HomeLoadedState;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                  itemCount: loadedState.tasks.tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          _homeBloc.add(
                            HomeTaskClickedEvent(
                              title: loadedState.tasks.tasks[index].toString(),
                            ),
                          );
                        },
                        title: Text(loadedState.tasks.tasks[index].toString()),
                        trailing: InkWell(
                          onTap: () {
                            _homeBloc.add(
                              HomeTaskDeleteClickedEvent(
                                title:
                                    loadedState.tasks.tasks[index].toString(),
                              ),
                            );
                          },
                          child: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }

  Widget showDialogBox(BuildContext context, HomeBloc homeBloc) {
    // Replace with your desired dialog widget or a placeholder
    return AlertDialog(
      scrollable: true,
      title: Text('Create Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _taskController,
              decoration: const InputDecoration(
                hintText: 'Task title',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter title';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 10,
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Task description',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter descripton';
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),

        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _homeBloc.add(
                HomeTaskCreateClickedEvent(
                  title: _taskController.text.trim(),
                  content: _descriptionController.text.trim(),
                ),
              );
              _taskController.clear();
              _descriptionController.clear();
              Navigator.of(context).pop();
            }
          },
          child: Text('Create'),
        ),
      ],
    );
  }
}
