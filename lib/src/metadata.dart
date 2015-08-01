part of redstone.headers_plugin;

class Roles {
  final List<String> roles;
  final String failureRedirect;
  const Roles (this.roles, {this.failureRedirect});
}

class UserIdMetadata {
  const UserIdMetadata();
}

const UserIdMetadata UserId = const UserIdMetadata();

