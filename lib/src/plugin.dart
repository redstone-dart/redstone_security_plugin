part of redstone.security_plugin;

app.RedstonePlugin securityPlugin (GetUserRoles getUserRoles, {String cookieIdField: "userId", String defaultRedirect}) {

  return (app.Manager manager) {
    //Controller Group
    manager.addRouteWrapper(AdmittedRoles, (AdmittedRoles metadata, injector, app.Request request, route) async {

      try {
        List<String> roles = [];
        try {
          var userId = getUserId(request, cookieIdField);
          roles = await getUserRoles(request, userId);
        }
        catch (e, s) {
        }

        var redirect = metadata.failureRedirect != null? metadata.failureRedirect: defaultRedirect;

        if (metadata.roles.any((role) => roles.contains(role)))
          return route(injector, request);
        else if (redirect != null)
          return app.redirect(redirect);
        else
          return "AUTHORIZATION ERROR: You don't have permission to access this resource.";
      }
      catch (e, s) {
        return "SERVER ERROR: $e\n$s";
      }

    }, includeGroups: true);


    manager.addParameterProvider(UserIdMetadata, (UserIdMetadata metadata, Type type, String handlerName, String paramName, app.Request request, injector) {
      return getUserId(request, cookieIdField);
    });
  };
}

/*
List<String> rethinkGetUserRoles (app.Request request, String userId) {
  var r = new Rethinkdb();
  var conn = request.attributes.dbConn.conn;
  return r.table('users').get(userId).getField('roles').run(conn);
}
*/