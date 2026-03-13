class ContactData {
  final String email;
  final String phone;
  final String location;
  final List<Map<String, dynamic>> socialLinks;

  ContactData({
    required this.email,
    required this.phone,
    required this.location,
    required this.socialLinks,
  });

  factory ContactData.fromMap(Map<String, dynamic> map) {
    final List<Map<String, dynamic>> links = [];
    final raw = map['social_links'];
    if (raw is List) {
      for (final e in raw) {
        if (e is Map) links.add(Map<String, dynamic>.from(e));
      }
    }
    return ContactData(
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      socialLinks: links,
    );
  }
}
