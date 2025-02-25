enum PlatescapeWorkmanager {
  oneOff("com.platescape.oneOff", "oneOff-task"),
  periodic("com.platescape.periodic", "periodic-task");

  final String uniqueName;
  final String taskName;

  const PlatescapeWorkmanager(this.uniqueName, this.taskName);
}
