import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';

void main() async {
  final dialog = CLI_Dialog(
    questions: [
      ['What is your application name?', 'appName'],
      ['What is your application id?', 'appId'],
    ],
    booleanQuestions: [
      ['Are you using fvm?', 'useFvm'],
    ],
    order: ['useFvm', 'appName', 'appId'],
  );

  final result = dialog.ask();
  final appName = result['appName'];
  final useFvm = result['useFvm'];
  final appId = result['appId'];

  await handleAppName('.', appName);
  await createMobile(useFvm, appId, appName);
}

Future<void> handleAppName(String path, String appName) async {
  final dir = Directory(path);
  final List<FileSystemEntity> entities = await dir.list().toList();
  await Future.forEach(entities, (entity) async {
    if (entity.path.endsWith('.git') || entity.path.endsWith('template') || entity.path.endsWith('.idea') || entity.path.endsWith('.dart_tool') || entity.path.endsWith('build')) {
      return;
    }
    if (entity.statSync().type == FileSystemEntityType.file) {
      final file = File(entity.path);
      final fileContent = await file.readAsString();
      if (!fileContent.contains('{{appName}}')) return;
      final out = fileContent.replaceAll('{{appName}}', appName);
      await file.delete();
      await file.create();
      await file.writeAsString(out);
    }

    if (entity.statSync().type == FileSystemEntityType.directory) {
      handleAppName(entity.path, appName);
    }
  });
}

Future<void> createMobile(bool useFvm, String appId, String appName) async {
  print("Creating mobile directory");
  if (useFvm) {
    await Process.run("fvm", ["flutter", "create", "--org", "com.asia", "--project-name", appName, "."]);
  } else {
    await Process.run("flutter", ["create", "--org", "com.asia", "--project-name", appName, "."]);
  }
  print("Directory creation success");
}
