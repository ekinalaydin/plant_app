import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({Key? key}) : super(key: key);

  @override
  _SearchBarAppState createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  late List<String> allItems;
  List<String> items = [];
  final TextEditingController searchController = TextEditingController();

  late Database _database;

  @override
  void initState() {
    super.initState();
    initDatabase();
    searchController.addListener(queryListener);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(queryListener);
    searchController.dispose();
  }

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'posts_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE posts(id INTEGER PRIMARY KEY, title TEXT)',
        );
      },
      version: 1,
    );
    await populateDatabase();
  }

  Future<void> populateDatabase() async {
    await _database.insert('posts', {'title': 'Example Post 1'});
    await _database.insert('posts', {'title': 'Another Post 2'});
    // Add more sample data as needed
    await search('');
  }

  void queryListener() {
    search(searchController.text);
  }

  Future<void> search(String query) async {
    final List<Map<String, dynamic>> result = await _database.query(
      'posts',
      where: "title LIKE ?",
      whereArgs: ['%$query%'],
    );

    setState(() {
      items = result.map((e) => e['title'].toString()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
