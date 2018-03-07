import 'dart:async';

import 'package:flutter/material.dart';
import 'package:async_loader/async_loader.dart';

import 'dart:convert';
import 'dart:io';

import 'package:rest_api_call/user.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Rest API',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new UserPage(),
    );
  }

}


final GlobalKey<AsyncLoaderState> _asyncLoaderState =
new GlobalKey<AsyncLoaderState>();

var _asyncLoader = new AsyncLoader(
  key: _asyncLoaderState,
  initState: () async => await _getUserApi(),
  renderLoad: () => new CircularProgressIndicator(),
  renderError: ([error]) =>
  new Text('Sorry, there was an error loading'),
  renderSuccess: ({data}) => new MyHomePage(data),
);

_getUserApi() async {
  var httpClient = new HttpClient();
  var uri = new Uri.https('api.github.com', '/users/1');
  var request = await httpClient.getUrl(uri);
  var response = await request.close();
  var responseBody = await response.transform(UTF8.decoder).join();
  return responseBody;
}

class UserPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("GitHub User"),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _asyncLoader,
                ],
              )),
        ],
      ),
    );
  }

}

class MyHomePage extends StatefulWidget {
  String _response;

  MyHomePage(String response) {
    this._response = response;
  }

  @override
  _MyHomePageState createState() => new _MyHomePageState(_response);
}

class _MyHomePageState extends State<MyHomePage> {
  String _response;
  User _user;

  _MyHomePageState(String response) {
    this._response = response;
  }


  @override
  Widget build(BuildContext context) {
    Map userMap = JSON.decode(_response);
    _user = new User.fromJson(userMap);

    String json = JSON.encode(_user);
    print(json);

    return new Expanded(
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("GitHub User",
                        style: new TextStyle(
                            fontSize: 20.0)
                    ))
              ],
            ),
            new Row(
              children: <Widget>[
                new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("User Id-: " + '${_user.id}',
                        style: new TextStyle(
                            fontSize: 16.0)
                    ))
              ],
            ),
            new Row(
              children: <Widget>[
                new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("Name-: " + _user.name,
                        style: new TextStyle(
                            fontSize: 16.0)
                    ))
              ],
            ),
            new Row(
              children: <Widget>[
                new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("Location-: " + _user.location,
                        style: new TextStyle(
                            fontSize: 16.0)))
              ],
            ),
          ],
        )
    );
  }
}

