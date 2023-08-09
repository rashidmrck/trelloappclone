import 'package:serverpod/serverpod.dart';
import 'package:trelloappclone_server/src/generated/protocol.dart';

class AttachmentEndpoint extends Endpoint {
  Future<Attachment> addAttachment(Session session, Attachment attachment) async {
    await Attachment.insert(session, attachment);
    return attachment;
  }
}
