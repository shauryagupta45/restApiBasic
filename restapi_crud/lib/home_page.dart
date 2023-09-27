import 'package:flutter/material.dart';
import 'package:restapi_crud/base_client.dart';
import 'package:restapi_crud/user.dart';

import 'app_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD REST API'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const FlutterLogo(
                size: 72,
              ),
              AppButton(
                operation: 'GET',
                operationColor: Colors.lightGreen,
                description: 'Fetch Users',
                onPressed: () async {
                  var response =
                      await BaseClient().get('/users').catchError((err) {});

                  if (response == null) return;
                  debugPrint('Successfull');

                  var users = userFromJson(response);
                  debugPrint('User count: ${users.length}');
                },
              ),
              AppButton(
                operation: 'POST',
                operationColor: Colors.lightBlue,
                description: 'Add User',
                onPressed: () async {
                  var user = User(name: 'Shaurya', qualifications: [
                    Qualification(
                        degree: 'Master', completionData: '01-08-2024')
                  ]);
                  var response = await BaseClient()
                      .post('/users', user)
                      .catchError((err) {});

                  if (response == null) return;
                  debugPrint('Successfull');
                },
              ),
              AppButton(
                operation: 'PUT',
                operationColor: Colors.deepOrange,
                description: 'Edit User',
                onPressed: () async {
                  var id = 2;
                  var user = User(name: 'Shaurya', qualifications: [
                    Qualification(degree: 'MBA', completionData: '01-08-2026')
                  ]);
                  var response = await BaseClient()
                      .put('/users/$id', user)
                      .catchError((err) {});

                  if (response == null) return;
                  debugPrint('Successfull');
                },
              ),
              AppButton(
                operation: 'DEL',
                operationColor: Colors.lightGreen,
                description: 'Delete User',
                onPressed: () async {
                  var id = 2;
                  var response = await BaseClient()
                      .delete('/users/$id')
                      .catchError((err) {});

                  if (response == null) return;
                  debugPrint('Successfull');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
