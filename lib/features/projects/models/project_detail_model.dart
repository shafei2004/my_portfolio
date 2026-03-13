class ProjectDetailModel {
  final String title;
  final String category;
  final String description;
  final String longDescription;
  final List<String> images;
  final List<String> features;
  final List<String> technologies;
  final String githubUrl;

  ProjectDetailModel({
    required this.title,
    required this.category,
    required this.description,
    required this.longDescription,
    required this.images,
    required this.features,
    required this.technologies,
    required this.githubUrl,
  });

  factory ProjectDetailModel.fromMap(Map<String, dynamic> data) {
    final images = (data['project_images'] as List<dynamic>?)
            ?.map((e) => e['image_url']?.toString())
            .whereType<String>()
            .toList() ??
        [];

    if (images.isEmpty &&
        (data['cover_url'] as String?)?.isNotEmpty == true) {
      images.add(data['cover_url'] as String);
    }

    return ProjectDetailModel(
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      description: (data['short_description'] ?? data['description']) ?? '',
      longDescription: data['long_description'] ?? '',
      images: images,
      features: (data['features'] is List)
          ? List<String>.from(data['features'])
          : [],
      technologies: (data['tools'] is List)
          ? List<String>.from(data['tools'])
          : [],
      githubUrl: data['github_url'] ?? data['repo_url'] ?? '',
    );
  }
}
