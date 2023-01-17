import 'dart:io';
import 'dart:convert';

List<String> tasks = [];
void main() {
  loadTasks();
  while (true) {
    stdout.write('Please type: Add, delete, list, or quit: ');
    var command = stdin.readLineSync();
    switch (command) {
      case 'add':
        addTask();
        break;
      case 'delete':
        deleteTask();
        break;
      case 'list':
        listTasks();
        break;
      case 'quit':
        exit(0);
      default:
        print('Invalid command');
    }
  }
}

void addTask() {
  stdout.write('Enter the task: ');
  var task = stdin.readLineSync();
  tasks.add(task.toString());
  saveTasks();
}

void deleteTask() {
  stdout.write('Enter the task number: ');
  int taskNumber = int.parse(stdin.readLineSync().toString());
  tasks.removeAt(taskNumber - 1);
  saveTasks();
}

void loadTasks() {
  try {
    var file = File('todo.json');
    var jsonString = file.readAsStringSync();
    tasks = jsonDecode(jsonString);
  } catch (e) {
    // type safety
  }
}

void saveTasks() {
  var jsonString = jsonEncode(tasks);
  File('todo.json').writeAsStringSync(jsonString);
}

void listTasks() {
  for (var i = 0; i < tasks.length; i++) {
    print('${i + 1}. ${tasks[i]}');
  }
}
