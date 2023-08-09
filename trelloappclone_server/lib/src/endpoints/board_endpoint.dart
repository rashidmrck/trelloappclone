import 'package:serverpod/server.dart';
import 'package:trelloappclone_server/src/generated/protocol.dart';

class BoardEndpoint extends Endpoint {
  Future<Board> createBoard(Session session, Board board) async {
    await Board.insert(session, board);
    return board;
  }

  Future<bool> updateBoard(Session session, Board board) async {
    return await Board.update(session, board);
  }

  Future<bool> deleteBoard(Session session, Board board) async {
    return await Board.deleteRow(session, board);
  }

  Future<Workspace?> getWorkspaceForBoard(Session session, Board board) async {
    Workspace? workspace = await Workspace.findSingleRow(
      session,
      where: (workspace) => workspace.id.equals(board.workspaceId),
    );
    return workspace;
  }
}
