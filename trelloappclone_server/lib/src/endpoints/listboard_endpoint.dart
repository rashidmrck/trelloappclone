import 'package:serverpod/serverpod.dart';
import 'package:trelloappclone_server/src/generated/protocol.dart';

class ListBoardEndpoint extends Endpoint {
  Future<List<Listboard>> getListsByBoard(Session session, {required int boardId}) async {
    List<Listboard> listBoards = await Listboard.find(
      session,
      where: (listBoard) => listBoard.boardId.equals(boardId),
    );

    for (var i = 0; i < listBoards.length; i++) {
      List<Card> cards = await Card.find(
        session,
        where: (card) => card.listId.equals(listBoards[i].id),
      );
      listBoards[i].cards = cards;
    }
    return listBoards;
  }

  Future<Listboard> createList(Session session, Listboard listboard) async {
    await Listboard.insert(session, listboard);
    return listboard;
  }
}
