import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stutents_lists/db_function/functions/db_function.dart';
import 'package:stutents_lists/db_function/models/list_model.dart';
import 'package:stutents_lists/db_function/screens/home.dart';
import 'package:stutents_lists/db_function/screens/widget/list_page.dart';

import '../../provider/db_provider/db_provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudent(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Contact List'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSerchDelegate());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: const [
            Expanded(child: ListStudentWidget()),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const ScreenHome()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomSerchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear_outlined))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_sharp));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<DataBaseProvider>(
      builder: (context, value, child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = value.studentList[index];
            if (data.name.toLowerCase().contains(query.toLowerCase())) {
              return Column(
                children: [
                  ListTile(
                    title: Text('Name: ${data.name}'),
                    subtitle: Text('Email: ${data.email}'),
                    leading: 
                    // const Icon(Icons.person),
                    CircleAvatar(
                        backgroundImage: MemoryImage(
                            const Base64Decoder().convert(data.image)),
                        radius: 30),
                  ),
                  const Divider()
                ],
              );
            } else {
              return const Text('');
            }
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: value.studentList.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<DataBaseProvider>(
      builder: (context, value, child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = value.studentList[index];
            if (data.name.toLowerCase().contains(query.toLowerCase())) {
              return Column(
                children: [
                  ListTile(
                    title: Text('Name: ${data.name}'),
                    subtitle: Text('Email: ${data.email}'),
                    leading: 
                    // const Icon(Icons.person),
                    CircleAvatar(
                        backgroundImage: MemoryImage(
                            const Base64Decoder().convert(data.image)),
                        radius: 30),
                  ),
                  const Divider()
                ],
              );
            } else {
              return const Text('');
            }
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: value.studentList.length,
        );
      },
    );
  }
}
