import "package:flutter/foundation.dart";

class ProjectStep {
  final int projectId;
  final int step;
  final String title;
  final String status;
  final int planDate;
  final int startDate;
  final int endDate;

  const ProjectStep({
    @required this.projectId,
    @required this.step,
    @required this.title,
    @required this.status,
    @required this.planDate,
    @required this.startDate,
    @required this.endDate,
  });
}

class Project {
  final int id;
  final String title;
  final int installationId;
  List<ProjectStep> steps;
  final String status;
  final int planDate;
  final int startDate;
  final int endDate;

  Project({
    @required this.id,
    @required this.title,
    @required this.installationId,
    @required this.steps,
    @required this.status,
    @required this.planDate,
    @required this.startDate,
    @required this.endDate,
  });
}
