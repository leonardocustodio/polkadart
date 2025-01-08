part of ink_cli;

/// Gets the root directory path.
String getRootDirectoryPath() => getRootDirectory().path;

/// Gets the root directory.
///
/// Note: The current working directory is assumed to be the root of a project.
Directory getRootDirectory() => Directory.current;

/// Gets the pubspec file.
File? getPubspecFile() {
  final rootDirPath = getRootDirectoryPath();
  final pubspecFilePath = path.join(rootDirPath, 'pubspec.yaml');
  final pubspecFile = File(pubspecFilePath);

  return pubspecFile.existsSync() ? pubspecFile : null;
}

/// Gets polkadart directory path.
String getPolkadartDirectoryPath(String outputDir) =>
    path.join(getRootDirectoryPath(), outputDir, 'polkadart');

/// Gets polkadart directory.
Directory? getPolkadartDirectory(String outputDir) {
  final polkadartDirPath = getPolkadartDirectoryPath(outputDir);
  final polkadartDir = Directory(polkadartDirPath);

  return polkadartDir.existsSync() ? polkadartDir : null;
}

/// Creates polkadart directory.
Future<Directory> createPolkadartDirectory(String outputDir) async {
  final polkadartDirPath = getPolkadartDirectoryPath(outputDir);
  final polkadartDir = Directory(polkadartDirPath);

  if (!polkadartDir.existsSync()) {
    await polkadartDir.create(recursive: true);
  }

  return polkadartDir;
}

/// Gets the user home directory path.
String? getUserHome() {
  if (Platform.isMacOS || Platform.isLinux) {
    return Platform.environment['HOME'];
  } else if (Platform.isWindows) {
    return Platform.environment['USERPROFILE'];
  } else {
    return null;
  }
}
