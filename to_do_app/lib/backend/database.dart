import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:to_do_app/models/task_details.dart';
import 'package:to_do_app/models/tasks.dart';

class Database {
  Future<Tasks> fetchTasks() async {
    try {
      final url = Uri.parse('http://192.168.31.101:3000/');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result);
        if (result != null && result is List && result.isNotEmpty) {
          return Tasks(tasks: result);
        }
        return Tasks(tasks: []); // Empty list if no data
      } else {
        throw 'Server returned status code ${response.statusCode}';
      }
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  Future<TaskDetails> fetchTaskDetails(String title) async {
    final encodedTitle = Uri.encodeComponent(title);
    // note the corrected IP and encoded title
    final url = Uri.parse('http://192.168.31.101:3000/details/$encodedTitle');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result != null && result['content'] != null) {
          return TaskDetails(content: result['content'].toString());
        } else {
          throw Exception('No content found in response');
        }
      } else {
        throw Exception('Server returned status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  Future<void> deleteTask(String title) async {
    final url = Uri.parse('http://192.168.31.101:3000/delete');
    try {
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'title': title}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete task');
      }
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  Future<void> createTask(String title, String content) async {
    final url = Uri.parse('http://192.168.31.101:3000/create');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'title': title, 'content': content}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete task');
      }
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
