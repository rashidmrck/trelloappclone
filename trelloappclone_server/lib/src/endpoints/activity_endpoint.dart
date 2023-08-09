import 'package:serverpod/serverpod.dart';
import 'package:trelloappclone_server/src/generated/protocol.dart';

class ActivityEndpoint extends Endpoint {
  Future<bool> createActivity(Session session, Activity activity) async {
    await Activity.insert(session, activity);
    return true;
  }
}
