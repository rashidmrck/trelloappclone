import 'package:serverpod/server.dart';
import 'package:trelloappclone_server/src/generated/protocol.dart';

class WorkspaceEndpoint extends Endpoint {
  Future<Workspace> createWorkspace(Session session, Workspace workspace) async {
    Workspace.insert(session, workspace);
    return workspace;
  }

  Future<List<Workspace>> getWorkspaceByUser(Session session, {required int userId}) async {
    List<Workspace> workspaces = await Workspace.find(
      session,
      where: (workspace) => workspace.userId.equals(userId),
    );

    for (int i = 0; i < workspaces.length; i++) {
      List<Member> members = await Member.find(
        session,
        where: (member) => member.workspaceId.equals(workspaces[i].id),
      );
      workspaces[i].members = members;
    }
    return workspaces;
  }

  Future<Workspace?> getWorkspaceById(Session session, {required workspaceId}) async {
    Workspace? workspace = await Workspace.findById(session, workspaceId);
    return workspace;
  }

  Future<List<Board>> getBoardsByWorkspace(Session session, {required int workspaceId}) async {
    List<Board> boards = await Board.find(
      session,
      where: (board) => board.workspaceId.equals(workspaceId),
    );
    return boards;
  }

  Future<bool> updateWorkspace(Session session, Workspace workspace) async {
    return await Workspace.update(session, workspace);
  }
 
  Future<bool> deleteWorkspace(Session session, Workspace workspace) async {
    return await Workspace.deleteRow(session, workspace);
  }
}
