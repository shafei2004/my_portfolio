class ProjectModel {
  final String id;
  final String slug;
  final String title;
  final String description;
  final String image;
  final List<String> features;
  final DateTime? createdAt;

  ProjectModel({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.image,
    required this.features,
    this.createdAt,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    // 🛡️ Extremely safe parsing to avoid runtime exceptions
    final rawFeatures = map['features'];
    final rawTools = map['tools'];
    
    List<String> combinedFeatures = [];
    
    if (rawFeatures is List) {
      combinedFeatures.addAll(rawFeatures.map((e) => e.toString()).toList());
    }
    
    if (rawTools is List) {
      combinedFeatures.addAll(rawTools.map((e) => e.toString()).toList());
    }

    return ProjectModel(
      id: map['id']?.toString() ?? '',
      slug: map['slug']?.toString() ?? map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      description: (map['short_description'] ?? map['description'])?.toString() ?? '',
      image: map['cover_url']?.toString() ?? '',
      features: combinedFeatures,
      createdAt: map['created_at'] != null ? DateTime.tryParse(map['created_at'].toString()) : null,
    );
  }
}
