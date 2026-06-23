class Portfolio {
  final Profile profile;
  final List<Project> projects;
  final List<Experience> experience;
  final List<Education> education;
  final List<String> skills;

  const Portfolio({
    required this.profile,
    required this.projects,
    required this.experience,
    required this.education,
    required this.skills,
  });
}

class Profile {
  final String name;
  final String role;
  final String location;
  final String availability;
  final String email;
  final String phone;
  final String summary;

  const Profile({
    required this.name,
    required this.role,
    required this.location,
    required this.availability,
    required this.email,
    required this.phone,
    required this.summary,
  });
}

class Project {
  final String name;
  final String category;
  final String description;
  final String rating;
  final String accent;
  final List<String> technologies;

  const Project({
    required this.name,
    required this.category,
    required this.description,
    required this.rating,
    required this.accent,
    required this.technologies,
  });
}

class Experience {
  final String role;
  final String company;
  final String period;
  final List<String> highlights;

  const Experience({
    required this.role,
    required this.company,
    required this.period,
    required this.highlights,
  });
}

class Education {
  final String degree;
  final String institution;
  final String status;
  final List<String> certifications;

  const Education({
    required this.degree,
    required this.institution,
    required this.status,
    required this.certifications,
  });
}
