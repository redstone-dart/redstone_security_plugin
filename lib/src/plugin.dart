part of redstone.headers_plugin;

app.RedstonePlugin securityPlugin (GetUserRoles getUserRoles, {String cookieIdField: "id"}) {

  return (app.Manager manager) {
    //Controller Group
    manager.addRouteWrapper(Roles, (Roles metadata, injector, app.Request request, route) async {

      try {
        List<String> roles = [];
        try {
          var userId = getUserId(request, cookieIdField);
          roles = await getUserRoles(request, userId);
        }
        catch (e, s) {
        }

        if (metadata.roles.any((role) => roles.contains(role)))
          return route(injector, request);
        else if (metadata.failureRedirect != null)
          return app.redirect(metadata.failureRedirect);
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