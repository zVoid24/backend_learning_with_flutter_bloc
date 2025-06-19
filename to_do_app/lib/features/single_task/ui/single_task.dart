import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/single_task/bloc/single_task_bloc.dart';

class SingleTask extends StatefulWidget {
  final String title;
  final String content;
  const SingleTask({super.key, required this.title, required this.content});

  @override
  State<SingleTask> createState() => _SingleTaskState();
}

class _SingleTaskState extends State<SingleTask> {
  final SingleTaskBloc _singleTaskBloc = SingleTaskBloc();

  @override
  void initState() {
    _singleTaskBloc.add(SingleTaskInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<SingleTaskBloc, SingleTaskState>(
          bloc: _singleTaskBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case SingleTaskLoadedState:
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(widget.content, style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                );

              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
