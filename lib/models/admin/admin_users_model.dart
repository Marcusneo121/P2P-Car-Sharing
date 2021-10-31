class AdminUsersModel {
  final String userID, createdAt, email, profilePic, role, username;

  AdminUsersModel({
    required this.userID,
    required this.createdAt,
    required this.email,
    required this.profilePic,
    required this.role,
    required this.username,
  });
}

class AdminUsersList {
  static List<AdminUsersModel> adminUsersList = [];
}
