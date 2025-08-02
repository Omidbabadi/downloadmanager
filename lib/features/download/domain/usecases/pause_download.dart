import '../repositories/download_repository.dart';

class PauseDownload {
  final DownloadRepository repository;
  PauseDownload(this.repository);
  Future<void> call(String taskId){
    return repository.pauseDownload(taskId);
  
  }
}