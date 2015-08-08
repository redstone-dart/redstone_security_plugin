part of redstone.security_plugin;

class AdmittedRoles {
  final List<String> roles;
  final String failureRedirect;
  const AdmittedRoles (this.roles, {this.failureRedirect});
}

class UserIdMetadata {
  const UserIdMetadata();
}

const UserIdMetadata UserId = const UserIdMetadata();

