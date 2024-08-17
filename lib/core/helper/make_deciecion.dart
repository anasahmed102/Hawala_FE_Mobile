
import 'package:hawala/service/connection_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/enums.dart';

// make decision either send request to server or local
Future<DataSource> makeDecision(DataSource source) async {
  // ConnectionChecker networkInfo = sl<ConnectionChecker>();
  ConnectionChecker networkInfo = getItClient.get<ConnectionChecker>();
  if (source.isRemote) {
    return source;
  } else if (source.isLocal) {
    return source;
  } else {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      return DataSource.remote;
    }
    return DataSource.local;
  }
}
