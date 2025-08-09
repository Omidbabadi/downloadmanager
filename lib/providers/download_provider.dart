import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/dio_provider.dart';
import 'package:myapp/services/download_service.dart';

final downloadServiceProvier = Provider<DownloadService>(
  (ref){
        final dio = ref.watch(dioProvider);
    return DownloadService(dio: dio);
  }
);
