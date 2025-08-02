import '../repositories/download_repository.dart';

class ResumeDownload {
  final DownloadRepository repository;
  ResumeDownload(this.repository);
  Future<void> call(String taskId) {
    return repository.resumeDownload(taskId);
  }
}
