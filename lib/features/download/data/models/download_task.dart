import '../../domain/entities/download_task.dart';

class DownloadTaskModel extends DownloadTask {
  DownloadTaskModel({
    required super.id,
    required super.url,
    required super.fileName,
    required super.progress,
    required super.downloadedBytes,
    required super.status,
  });

  factory DownloadTaskModel.fromEntity(DownloadTask task) {
    return DownloadTaskModel(
      id: task.id,
      url: task.url,
      fileName: task.fileName,
      progress: task.progress,
      downloadedBytes: task.downloadedBytes,
      status: task.status,
    );
  }
}
