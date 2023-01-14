class ProcessorArchitecture {
  const ProcessorArchitecture(this.name);

  static const ProcessorArchitecture arm64 = ProcessorArchitecture('ARM64');

  static const ProcessorArchitecture arm = ProcessorArchitecture('ARM');

  static const ProcessorArchitecture ia64 = ProcessorArchitecture('IA64');

  static const ProcessorArchitecture mips = ProcessorArchitecture('MIPS');

  static const ProcessorArchitecture x86 = ProcessorArchitecture('X86');

  static const ProcessorArchitecture x86_64 = ProcessorArchitecture('X86_64');

  static const ProcessorArchitecture unknown = ProcessorArchitecture('UNKNOWN');

  final String name;

  @override
  String toString() => name;
}
