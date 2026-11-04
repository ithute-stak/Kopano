/// Contract for future FastAPI / OIDC authentication integration.
///
/// This file declares interfaces only. No network traffic is performed.
/// Production implementations must use TLS, secure token storage, server-side
/// validation, short-lived access tokens and refresh-token rotation.
abstract interface class KopanoAuthGateway {
  Future<AuthResult> signIn({required String phone, required String password});
  Future<void> signOut();
  Future<AuthResult?> restoreSession();
}

class AuthResult {
  const AuthResult({required this.subjectId, required this.isAdultVerified});
  final String subjectId;
  final bool isAdultVerified;
}

class AuthUnavailableException implements Exception {
  const AuthUnavailableException();
  @override
  String toString() => 'Authentication has not been connected yet.';
}

/// Deliberately disabled until an approved server integration is configured.
class DisabledAuthGateway implements KopanoAuthGateway {
  const DisabledAuthGateway();
  @override
  Future<AuthResult> signIn({required String phone, required String password}) async {
    throw const AuthUnavailableException();
  }
  @override
  Future<void> signOut() async {}
  @override
  Future<AuthResult?> restoreSession() async => null;
}
