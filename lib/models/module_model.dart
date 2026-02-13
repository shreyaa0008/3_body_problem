class ModuleModel {
  final String title;
  final bool isUnlocked;
  final bool isCompleted;

  ModuleModel({
    required this.title,
    required this.isUnlocked,
    this.isCompleted = false,
  });
}
