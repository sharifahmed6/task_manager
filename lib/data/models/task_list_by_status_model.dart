import 'package:task_manager/data/models/task_list_model.dart';

class TaskListByStatusModel {
  String? status;
  List<TaskListModel>? taskList;

  TaskListByStatusModel({this.status, this.taskList});

  TaskListByStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskListModel>[];
      json['data'].forEach((v) {
        taskList!.add(new TaskListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    if (this.taskList != null) {
      data['data'] = this.taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

