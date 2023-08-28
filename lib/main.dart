import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String province;
  final String address;

  Person({required this.name, required this.province, required this.address});
}

class MyApp extends StatelessWidget {
  final List<Person> persons = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Person Data App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(persons: persons),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Person> persons;

  MyHomePage({required this.persons});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addNewPerson() async {
    final newPerson = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPersonPage()),
    );

    if (newPerson != null) {
      setState(() {
        widget.persons.add(newPerson);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person Data App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'By Province'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: widget.persons.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.persons[index].name),
                subtitle: Text(widget.persons[index].province),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmationDialog(widget.persons[index]);
                  },
                ),
                onTap: () {
                  _showPersonDetails(widget.persons[index]);
                },
              );
            },
          ),
          ListView.builder(
            itemCount: widget.persons.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.persons[index].name),
                subtitle: Text(widget.persons[index].province),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmationDialog(widget.persons[index]);
                  },
                ),
                onTap: () {
                  _showPersonDetails(widget.persons[index]);
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewPerson();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(Person person) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete ${person.name}?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                widget.persons.remove(person);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPersonDetails(Person person) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonDetailsPage(person: person),
      ),
    );
  }
}

class PersonDetailsPage extends StatelessWidget {
  final Person person;

  PersonDetailsPage({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Name: ${person.name}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Province: ${person.province}',
                style: TextStyle(fontSize: 16)),
            Text('Address: ${person.address}', style: TextStyle(fontSize: 16)),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

class AddnewpersonPage extends StatefulWidget {
  final Person person;

  AddnewpersonPage({required this.person});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Stepper(
          steps: [
            Step(
              title: const Text('Step 1'),
              content: Column(
                children: const [
                  Text('This is the first step.'),
                ],
              ),
            ),
            Step(
              title: const Text('Step 2'),
              content: const Text('This is the Second step.'),
            ),
            Step(
              title: const Text('Step 3'),
              content: const Text('This is the Third step.'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

class NewPersonPage extends StatefulWidget {
  @override
  _NewPersonPageState createState() => _NewPersonPageState();
}

class _NewPersonPageState extends State<NewPersonPage> {
  String newName = '';
  String newProvince = '';
  String newAddress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Person'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  newName = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Province'),
              onChanged: (value) {
                setState(() {
                  newProvince = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Address'),
              onChanged: (value) {
                setState(() {
                  newAddress = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                    context,
                    Person(
                      name: newName,
                      province: newProvince,
                      address: newAddress,
                    ));
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
