import 'package:serverpod/serverpod.dart';
import 'package:trelloappclone_server/src/generated/protocol.dart';

class CardEndpoint extends Endpoint {
  Future<Card> createCard(Session session, Card card) async {
    await Card.insert(session, card);
    return card;
  }

  Future<bool> updateCard(Session session, Card card) async {
    return await Card.update(session, card);
  }
}
