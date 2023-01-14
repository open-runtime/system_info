import 'dart:io';

import 'package:file_utils/file_utils.dart';
import 'package:path/path.dart' as pathos;

import '../fluent.dart';
import '../utils.dart';
import 'operating_system.dart';
import 'userspace.dart';

int getKernelBitness() {
  switch (Platform.operatingSystem) {
    case 'android':
    case 'linux':
      if (getUserSpaceBitness() == 64) {
        return 64;
      }

      final paths = <String>[];
      final path = resolveLink('/etc/ld.so.conf');
      if (path != null) {
        parseLdConf(path, paths, <String>{});
      }

      paths.add('/lib');
      paths.add('/lib64');
      for (final path in paths) {
        final files = FileUtils.glob(pathos.join(path, 'libc.so.*'));
        for (final filePath in files) {
          final resolvedFilePath = resolveLink(filePath);
          if (resolvedFilePath == null) {
            continue;
          }

          final file = File(resolvedFilePath);
          if (file.existsSync()) {
            final fileType =
                (fluent(exec('file', ['-b', file.path]))..trim()).stringValue;
            if (fileType.startsWith('ELF 64-bit')) {
              return 64;
            }
          }
        }
      }

      return 32;
    case 'macos':
      if ((fluent(exec('uname', ['-m']))..trim()).stringValue == 'x86_64') {
        return 64;
      }

      return 32;
    case 'windows':
      final wow64 =
          fluent(Platform.environment['PROCESSOR_ARCHITEW6432']).stringValue;
      if (wow64.isNotEmpty) {
        return 64;
      }

      switch (Platform.environment['PROCESSOR_ARCHITECTURE']) {
        case 'AMD64':
        case 'IA64':
          return 64;
      }

      return 32;
    default:
      notSupportedError();
  }
}

String getKernelArchitecture() {
  switch (Platform.operatingSystem) {
    case 'android':
    case 'linux':
    case 'macos':
      return (fluent(exec('uname', ['-m']))..trim()).stringValue;
    case 'windows':
      final wow64 =
          fluent(Platform.environment['PROCESSOR_ARCHITEW6432']).stringValue;
      if (wow64.isNotEmpty) {
        return wow64;
      }

      return fluent(Platform.environment['PROCESSOR_ARCHITECTURE']).stringValue;
    default:
      notSupportedError();
  }
}

String getKernelName() {
  switch (Platform.operatingSystem) {
    case 'android':
    case 'linux':
    case 'macos':
      return (fluent(exec('uname', ['-s']))..trim()).stringValue;
    case 'windows':
      return fluent(Platform.environment['OS']).stringValue;
    default:
      notSupportedError();
  }
}

String getKernelVersion() {
  switch (Platform.operatingSystem) {
    case 'android':
    case 'linux':
    case 'macos':
      return (fluent(exec('uname', ['-r']))..trim()).stringValue;
    case 'windows':
      return getOperatingSystemVersion();
    default:
      notSupportedError();
  }
}
