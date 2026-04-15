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
    // 🛡️ Safe Image Parsing
    final rawImages = data['project_images'];
    List<String> images = [];
    
    if (rawImages is List) {
      images = rawImages
          .map((e) => e is Map ? e['image_url']?.toString() : e.toString())
          .whereType<String>()
          .toList();
    }

    if (images.isEmpty && (data['cover_url'] as String?)?.isNotEmpty == true) {
      images.add(data['cover_url'] as String);
    }

    // 🛡️ Safe Features & Technologies (Tools) Parsing
    final rawFeatures = data['features'];
    final rawTools = data['tools'];
    
    List<String> featureList = [];
    if (rawFeatures is List) {
      featureList = rawFeatures.map((e) => e.toString()).toList();
    }

    List<String> techList = [];
    if (rawTools is List) {
      techList = rawTools.map((e) => e.toString()).toList();
    }

    return ProjectDetailModel(
      title: data['title']?.toString() ?? '',
      category: data['category']?.toString() ?? '',
      description: (data['short_description'] ?? data['description'])?.toString() ?? '',
      longDescription: (data['long_description'] ?? data['description'])?.toString() ?? '',
      images: images,
      features: featureList,
      technologies: techList,
      githubUrl: (data['github_url'] ?? data['repo_url'])?.toString() ?? '',
    );
  }
}
