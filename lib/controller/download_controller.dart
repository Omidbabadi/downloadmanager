import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/download_model.dart';
import 'package:hive/hive.dart';
import 'package:myapp/providers/dio_provider.dart';
import 'package:myapp/services/download_service.dart';

class DownloadServiceController extends Notifier<DownloadService> {
  final Map<String, StreamSubscription<DownloadTaskModel>> _subscriptions = {};
  
}
