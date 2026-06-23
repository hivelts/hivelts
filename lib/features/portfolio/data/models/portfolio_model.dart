import '../../domain/entities/portfolio.dart';

class PortfolioModel extends Portfolio {
  const PortfolioModel({
    required super.profile,
    required super.projects,
    required super.experience,
    required super.education,
    required super.skills,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      profile: ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
      projects: (json['projects'] as List<dynamic>)
          .map((item) => ProjectModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      experience: (json['experience'] as List<dynamic>)
          .map((item) => ExperienceModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      education: (json['education'] as List<dynamic>)
          .map((item) => EducationModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      skills: (json['skills'] as List<dynamic>).cast<String>(),
    );
  }
}

class ProfileModel extends Profile {
  const ProfileModel({
    required super.name,
    required super.role,
    required super.location,
    required super.availability,
    required super.email,
    required super.phone,
    required super.summary,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] as String,
      role: json['role'] as String,
      location: json['location'] as String,
      availability: json['availability'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      summary: json['summary'] as String,
    );
  }
}

class ProjectModel extends Project {
  const ProjectModel({
    required super.name,
    required super.category,
    required super.description,
    required super.rating,
    required super.accent,
    required super.technologies,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      rating: json['rating'] as String,
      accent: json['accent'] as String,
      technologies: (json['technologies'] as List<dynamic>).cast<String>(),
    );
  }
}

class ExperienceModel extends Experience {
  const ExperienceModel({
    required super.role,
    required super.company,
    required super.period,
    required super.highlights,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      role: json['role'] as String,
      company: json['company'] as String,
      period: json['period'] as String,
      highlights: (json['highlights'] as List<dynamic>).cast<String>(),
    );
  }
}

class EducationModel extends Education {
  const EducationModel({
    required super.degree,
    required super.institution,
    required super.status,
    required super.certifications,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      degree: json['degree'] as String,
      institution: json['institution'] as String,
      status: json['status'] as String,
      certifications: (json['certifications'] as List<dynamic>).cast<String>(),
    );
  }
}
