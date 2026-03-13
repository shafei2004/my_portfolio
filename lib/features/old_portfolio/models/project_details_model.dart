class Project {
  final String title;
  final String description;
  final String mainImagePath;
  final List<String> additionalImagePaths;
  final String longDescription;
  final List<String> features;
  final String technologiesUsed;
  final String? githubLink;
  final String? appStoreLink;
  final String? playStoreLink;

  Project({
    required this.title,
    required this.description,
    required this.mainImagePath,
    required this.additionalImagePaths,
    required this.longDescription,
    required this.features,
    required this.technologiesUsed,
    this.githubLink,
    this.appStoreLink,
    this.playStoreLink,
  });
}