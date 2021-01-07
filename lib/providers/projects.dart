import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:emc2/models/project.dart';
import 'package:emc2/helpers/db_helper.dart';

class Projects with ChangeNotifier {
  static const stepsDescription = [
    'Instalador Autorizado',
    'Registro de la Instalacion',
    'Validacion y Documentacion',
    'Contrato de Compensacion de Excedentes',
    'Respuesta al Contrato de Compensacion',
    'Inicio de Obra',
    'Entrega de Instalacion',
    'Contrato de Mantenimiento',
    'Explotacion',
  ];

  List<Project> _projects = [];
  List<ProjectStep> _steps = [];

  List<Project> get projects {
    return [..._projects];
  }

  Project getProjectById(int id) {
    return projects.firstWhere((project) => project.id == id);
  }

  Future<Project> findById(int id) async {
    final projects = await fetchAndSetProject();
    return projects.firstWhere((project) => project.id == id);
  }

  Future<void> newProject(
    int projectId,
    String title,
    int installationId,
  ) async {
    final newProject = Project(
      id: projectId,
      title: title,
      installationId: installationId,
      steps: [],
      status: 'Not started',
      planDate: DateTime.now().millisecondsSinceEpoch,
      startDate: 0,
      endDate: 0,
    );

    _projects.add(newProject);
    notifyListeners();
    DBHelper.insert('projects', {
      'id': newProject.id,
      'title': newProject.title,
      'installation_id': newProject.installationId,
      'plandate': newProject.planDate,
      'startdate': newProject.startDate,
      'enddate': newProject.endDate,
    });

    createSteps(newProject.id);
  }

  Future<List<Project>> fetchAndSetProject() async {
    final dataList = await DBHelper.getData('projects');
    final stepList = await DBHelper.getData('project_steps');

    _projects = dataList.map((project) {
      final projectSteps = stepList
          .where((step) => step['project_id'] == project['id'])
          .map((step) {
        return ProjectStep(
          projectId: step['project_id'],
          step: step['step'],
          title: step['title'],
          status: step['status'],
          planDate: step['plandate'],
          startDate: step['startdate'],
          endDate: step['enddate'],
        );
      }).toList();
      return Project(
        id: project['id'],
        title: project['title'],
        installationId: project['installation_id'],
        steps: projectSteps,
        status: project['status'],
        planDate: project['plandate'],
        startDate: project['startdate'],
        endDate: project['enddate'],
      );
    }).toList();
    notifyListeners();
    return _projects;
  }

  Future<void> createSteps(projectId) async {
    var counter = 0;
    _steps = stepsDescription.map((desc) {
      final step = ProjectStep(
        projectId: projectId,
        step: counter,
        title: desc,
        status: 'pending',
        planDate: DateTime.now().millisecondsSinceEpoch,
        startDate: 0,
        endDate: 0,
      );
      counter++;
      return step;
    }).toList();
    for (var i = 0; i < _steps.length; i++) {
      final step = _steps[i];
      await DBHelper.insert('project_steps', {
        'project_id': step.projectId,
        'step': step.step,
        'title': step.title,
        'status': step.status,
        'plandate': step.planDate,
        'startdate': step.startDate,
        'enddate': step.endDate,
      });
    }
  }
}
