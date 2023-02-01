import "package:mynotes/services/auth_services/auth_user.dart";

abstract class AuthProvider{
  AuthUser? get currentUser;

}