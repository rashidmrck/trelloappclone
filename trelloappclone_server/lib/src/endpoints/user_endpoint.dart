import 'package:serverpod/server.dart';
import 'package:trelloappclone_server/src/generated/protocol.dart';
// import '../generated/protocol.dart';

class UserEndpoint extends Endpoint {
  Future<User> createUser(Session session, User user) async {
    await User.insert(session, user);
    return user;
  }

  Future<User?> getUserById(Session session, {required int userId}) async {
    User? user = await User.findById(session, userId);
    return user;
  }
}
