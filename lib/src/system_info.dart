import 'dart:io';

import 'core_info.dart';
import 'platform/cpu.dart';
import 'platform/kernel.dart';
import 'platform/memory.dart' as pm;
import 'platform/operating_system.dart';
import 'platform/user.dart';
import 'platform/userspace.dart';

abstract class SysInfo {
  SysInfo._internal();

  /// Returns the architecture of the kernel.
  ///
  ///     print(SysInfo.kernelArchitecture);
  ///     => i686
  static late final String kernelArchitecture = getKernelArchitecture();

  /// Returns the bintness of kernel.
  ///
  ///     print(SysInfo.kernelBitness);
  ///     => 32
  static late final int kernelBitness = getKernelBitness();

  /// Returns the name of kernel.
  ///
  ///     print(SysInfo.kernelName);
  ///     => Linux
  static late final String kernelName = getKernelName();

  /// Returns the version of kernel.
  ///
  ///     print(SysInfo.kernelVersion);
  ///     => 32
  static late final String kernelVersion = getKernelVersion();

  /// Returns the name of operating system.
  ///
  ///     print(SysInfo.operatingSystemName);
  ///     => Ubuntu
  static late final String operatingSystemName = getOperatingSystemName();

  /// Returns the version of operating system.
  ///
  ///     print(SysInfo.operatingSystemVersion);
  ///     => 14.04
  static late final String operatingSystemVersion = getOperatingSystemVersion();

  /// Returns the information about the processors.
  ///
  ///     print(SysInfo.processors.first.vendor);
  ///     => GenuineIntel
  static late final List<CoreInfo> cores = getCores();

  /// Returns the path of user home directory.
  ///
  ///     print(SysInfo.userDirectory);
  ///     => /home/andrew
  static late final String userDirectory = getUserDirectory();

  /// Returns the identifier of current user.
  ///
  ///     print(SysInfo.userId);
  ///     => 1000
  static late final String userId = getUserId();

  /// Returns the name of current user.
  ///
  ///     print(SysInfo.userName);
  ///     => 'Andrew'
  static late final String userName = getUserName();

  /// Returns the bitness of the user space.
  ///
  ///     print(SysInfo.userSpaceBitness);
  ///     => 32
  static late final int userSpaceBitness = getUserSpaceBitness();

  static late final String _operatingSystem = Platform.operatingSystem;

  /// Returns the amount of free physical memory in bytes.
  ///
  ///     print(SysInfo.getFreePhysicalMemory());
  ///     => 3755331584
  static int getFreePhysicalMemory() => pm.getFreePhysicalMemory();

  /// Returns the amount of free virtual memory in bytes.
  ///
  ///     print(SysInfo.getFreeVirtualMemory());
  ///     => 3755331584
  static int getFreeVirtualMemory() => pm.getFreeVirtualMemory();

  /// Returns the amount of total physical memory in bytes.
  ///
  ///     print(SysInfo.getTotalPhysicalMemory());
  ///     => 3755331584
  static int getTotalPhysicalMemory() => pm.getTotalPhysicalMemory();

  /// Returns the amount of total virtual memory in bytes.
  ///
  ///     print(SysInfo.getTotalVirtualMemory());
  ///     => 3755331584
  static int getTotalVirtualMemory() => pm.getTotalVirtualMemory();

  /// Returns the amount of virtual memory in bytes used by the proccess.
  ///
  ///     print(SysInfo.getVirtualMemorySize());
  ///     => 123456
  static int getVirtualMemorySize() => pm.getVirtualMemorySize();
}
