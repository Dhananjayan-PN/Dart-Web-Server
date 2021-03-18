import 'dart:convert';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

const _hostname = 'localhost';
const _port = 8080;

void main(List<String> args) async {
  var staticHandler =
      createStaticHandler('files', defaultDocument: 'index.html');

  var routes = Router();

  routes.get('/hello', (shelf.Request request) {
    return shelf.Response.ok(jsonEncode({'message': 'Hello-World!! :)'}));
  });

  routes.get('/user/<user>', (shelf.Request request, String user) {
    return shelf.Response.ok(jsonEncode({'message': 'hello $user'}));
  });

  var handler = shelf.Cascade().add(staticHandler).add(routes).handler;

  var server = await io.serve(handler, _hostname, _port);
  print('Serving at http://${server.address.host}:${server.port}');
}
