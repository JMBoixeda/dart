import 'dart:math';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../providers/installation_set.dart';
import 'package:emc2/providers/projects.dart';

class ProjectDetailScreen extends StatefulWidget {
  static const routeName = '/project-detail';
  const ProjectDetailScreen({Key key}) : super(key: key);

  @override
  _ProjectDetailScreenState createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  int _showDropDown = -1;
  Random _random = Random.secure();

  String convertDate(int date) {
    print(date);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);
    var format = new DateFormat("d/M/y");
    return format.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedInstallation =
        Provider.of<InstallationSet>(context, listen: false).findById(id);
    final projectsProvider = Provider.of<Projects>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Proyecto Instalacion: ${selectedInstallation.title}'),
      ),
      body: Center(
        child: FutureBuilder(
          future: projectsProvider.findById(selectedInstallation.projectId),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Projects>(
                  child: Center(
                    child: const Text('El proyecto no esta iniciado'),
                  ),
                  builder: (context, projectSet, ch) => projectSet
                              .projects.length <=
                          0
                      ? ch
                      : Container(
                          alignment: Alignment.topLeft,
                          height: 550,
                          width: 300,
                          child: ListView.builder(
                            itemCount: projectSet
                                .getProjectById(selectedInstallation.projectId)
                                .steps
                                .length,
                            itemBuilder: (ctx, i) => Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: _random.nextInt(10) > 6
                                        ? Colors.green
                                        : _random.nextInt(10) > 3
                                            ? Colors.red
                                            : Colors.yellow,
                                    // backgroundImage: FileImage(
                                    //   project.projects[i].image,
                                    // ),
                                  ),
                                  title: Text(projectSet
                                      .getProjectById(
                                          selectedInstallation.projectId)
                                      .steps[i]
                                      .title),
                                  subtitle: Text(convertDate(projectSet
                                      .getProjectById(
                                          selectedInstallation.projectId)
                                      .planDate)),
                                  onTap: () {},
                                  onLongPress: () {
                                    setState(() {
                                      _showDropDown = i;
                                    });
                                  },
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: _showDropDown == i
                                      ? Text(projectSet
                                          .getProjectById(
                                              selectedInstallation.projectId)
                                          .steps[i]
                                          .projectId
                                          .toString())
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}
