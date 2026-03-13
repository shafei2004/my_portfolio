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
    return ProjectModel(
      id: map['id'] ?? 0,
      slug: map['slug'] ?? map['id'].toString(),
      title: map['title'] ?? '',
      description: (map['short_description'] ?? map['description']) ?? '',
      image: map['cover_url'] ?? '',
      features: (map['features'] is List)
          ? List<String>.from(map['features'])
          : [],
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
    );
  }
}
