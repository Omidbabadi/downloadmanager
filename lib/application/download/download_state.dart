import '../../features/download/domain/entities/download_task.dart';

class DownloadState {
  final List<DownloadTask> tasks;
  DownloadState({required this.tasks});

  DownloadState copyWith({List<DownloadTask>? tasks} ){
    return DownloadState( tasks: tasks ?? this.tasks,);
  }
  
  }