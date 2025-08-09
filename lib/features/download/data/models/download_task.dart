import '../../domain/entities/download_task.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class DownloadTaskModel{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final String fileName;
  @HiveField(3)
  final double progress;
  @HiveField(4)
  final int downloadedBytes;
  @HiveField(5)
  final DownloadStatus status;

  DownloadTaskModel({
    required this.id,
    required this.url,
    required this.fileName,
    required this.progress,
    required this.downloadedBytes,
    required this.status,
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

   DownloadTask toEntity() {
    return DownloadTask(
      id: id,
      url: url,
      fileName: fileName,
      status: status,
      progress: progress,
      downloadedBytes: downloadedBytes
    );
  }
}
