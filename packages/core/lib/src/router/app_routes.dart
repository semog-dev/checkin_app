abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const places = '/places';
  static const placeDetail = '/places/:id';
  static const addPlace = '/places/add';
  static const groups = '/groups';
  static const createGroup = '/groups/create';
  static const joinGroup = '/groups/join';
  static const groupDetail = '/groups/:id';
  static const groupMemberHistory = '/groups/:groupId/member/:memberId';
  static const settings = '/settings';

  static String groupMemberHistoryPath(String groupId, String memberId) =>
      '/groups/$groupId/member/$memberId';
}
