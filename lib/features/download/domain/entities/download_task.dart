class DownloadTask {
  final String id;
  final String url;
  final String fileName;
  final double progress;
  final int downloadedBytes;
  final DownloadStatus status;

  DownloadTask({
    required this.id,
    required this.url,
    required this.fileName,
    required this.progress,
    required this.downloadedBytes,
    required this.status,
  });

  DownloadTask copyWith({
    String? id,
    String? url,
    String? fileName,
    double? progress,
    int? downloadedBytes,
    DownloadStatus? status,
  }) {
    return DownloadTask(
      id: id ?? this.id,
      url: url ?? this.url,
      fileName: fileName ?? this.fileName,
      progress: progress ?? this.progress,
      downloadedBytes: downloadedBytes ?? this.downloadedBytes,
      status: status ?? this.status,
    );
  }
}

enum DownloadStatus { pending, downloading, paused, completed, failed }
