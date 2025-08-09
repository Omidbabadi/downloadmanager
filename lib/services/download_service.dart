import 'package:myapp/models/download_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:flutter_media_store/flutter_media_store.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

class DownloadService {
  final Dio dio;
  DownloadService({Dio? dio}) : dio = dio ?? Dio();
  Stream<DownloadTaskModel> startDownload(String url, String fileName) async* {
    final storageStatus = await Permission.manageExternalStorage.request();
    if (!storageStatus.isGranted) {
      debugPrint('#info: Permission denied');
      return;
    }
    debugPrint('#info: start download method begins');
    final flutterMediaStorePlugin = FlutterMediaStore();
    final id = const Uuid().v4();
    debugPrint('download id: $id');
    int downloadedBytes = 0;
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    debugPrint("Path: $tempDir/$fileName");
    yield DownloadTaskModel(
      savePath: 'Download/mydownloader/$fileName',
      downloadedBytes: 0,
      fileName: fileName,
      id: id,
      progress: 0,
      status: DownloadStatus.downloading,
      url: url,
    );
    try {
      final response = await dio.download(
        url,
        file.path,
        onReceiveProgress: (received, total) {
          downloadedBytes = received;
        },
      );
      if (response.statusCode == 200) {
        final bytes = await file.readAsBytes();
        final mime = lookupMimeType(fileName) ?? 'application/octet-stream';
        await flutterMediaStorePlugin.saveFile(
          fileData: bytes,
          mimeType: mime,
          rootFolderName: 'Download',
          folderName: 'mydownloader',
          fileName: fileName,
          onSuccess: (uri, filePath) {
            debugPrint('File Saved Succsessfully: $uri : $filePath');
          },
          onError: (error) {
            debugPrint('Failed To Save: $error');
          },
        );
        yield DownloadTaskModel(
          savePath: 'Download/mydownloader/$fileName',
          downloadedBytes: downloadedBytes,
          fileName: fileName,
          id: id,
          progress: 1,
          status: DownloadStatus.completed,
          url: url,
        );
      } else {
        debugPrint('Download Failed');
        throw Exception('Download Failed');
      }
    } catch (e) {
       yield DownloadTaskModel(
        savePath: 'Download/mydownloader/$fileName',
        id: id,
        url: url,
        fileName: fileName,
        progress: 0,
        downloadedBytes: downloadedBytes,
        status: DownloadStatus.failed,
      );
    }
  }
}
