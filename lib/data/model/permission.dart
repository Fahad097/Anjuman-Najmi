class Permissions {
  Map<String, String>? permission;
  Permissions({this.permission});
}

PermissionService permissionService = PermissionService();

class PermissionService {
  Map<String, dynamic>? userPermissions = {};

  void updateUserPermissions(Map<String, dynamic>? permissions) {
    userPermissions = permissions;
  }

  bool hasPermission(String permissionKey) {
    if (userPermissions!.containsKey(permissionKey)) {
      if (userPermissions![permissionKey] != 'n') {
        return true;
      }
    }
    return false;
  }

  bool hasWritePermission(String permissionKey) {
    if (userPermissions!.containsKey(permissionKey)) {
      if (userPermissions![permissionKey] == 'w') {
        return true;
      }
    }
    return false;
  }

  bool hasReadPermission(String permissionKey) {
    if (userPermissions!.containsKey(permissionKey)) {
      if (userPermissions![permissionKey] == 'r') {
        return true;
      }
    }
    return false;
  }
}
