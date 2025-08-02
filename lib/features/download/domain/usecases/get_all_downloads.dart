import '../repositories/download_repository.dart';
import '../entities/download_task.dart';

class GetAllDownloads {
  final DownloadRepository repository;
  GetAllDownloads(this.repository);

  Future<List<DownloadTask>> call() {
    return repository.getAllDownloads();
  }
}
