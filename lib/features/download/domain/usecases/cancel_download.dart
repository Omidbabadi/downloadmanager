import '../repositories/download_repository.dart';

class CancelDownload {
  final DownloadRepository repository;
  CancelDownload(this.repository);

  Future<void> call(String taskId) {
    return repository.cancelDownload(taskId);
  }
}
