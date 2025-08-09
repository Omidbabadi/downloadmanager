import 'package:hive/hive.dart';

part 'download_model.g.dart';

@HiveType(typeId: 0)
class DownloadTaskModel extends HiveObject{
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
  final String savePath;

  DownloadTaskModel({
    required this.id,
    required this.url,
    required this.fileName,
    required this.progress,
    required this.downloadedBytes,
    required this.status,
    required this.savePath,
  });

  DownloadTaskModel copyWith({
    String? id,
    String? url,
    String? fileName,
    double? progress,
    int? downloadedBytes,
    DownloadStatus? status,
    String? savePath,
  }) {
    return DownloadTaskModel(
      id: id ?? this.id,
      url: url ?? this.url,
      fileName: fileName ?? this.fileName,
      progress: progress ?? this.progress,
      downloadedBytes: downloadedBytes ?? this.downloadedBytes,
      status: status ?? this.status,
      savePath: savePath ?? this.savePath,
    );
  }
}

enum DownloadStatus { pending, downloading, paused, completed, failed }
