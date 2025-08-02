import '../repositories/download_repository.dart';
import '../entities/download_task.dart';

class StartDownloadUseCase {
  final DownloadRepository repository;
  StartDownloadUseCase(this.repository);
  Stream<DownloadTask> call(String url, String fileName) {
    return repository.startDownload(url, fileName);
  }
}
