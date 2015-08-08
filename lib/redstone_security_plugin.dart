library redstone.security_plugin;

import 'package:redstone/redstone.dart' as app;
import 'package:cookies/cookies.dart' as ck;
import 'dart:async' show Future;

part 'src/metadata.dart';
part 'src/plugin.dart';

typedef Future<List<String>> GetUserRoles (app.Request request, String userId);

String getUserId (app.Request request, String cookieIdField) {
  var cookieJar = new ck.CookieJar(request.headers.cookie);
  if (cookieJar.containsKey(cookieIdField)) {
    return cookieJar[cookieIdField].value;
  }
  else {
    throw new Exception('cookieIdField "$cookieIdField" not found in cookie header');
  }
}