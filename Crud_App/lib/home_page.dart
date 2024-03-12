import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController= TextEditingController();
  TextEditingController contactController= TextEditingController();
  int selectedIndex= -1; // initially no item is selected

  List<Contact> contacts= List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            'Contact Lists',
            style: TextStyle(
              color: Colors.white,
            ),
        ),
        backgroundColor: Colors.deepPurple,


      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
             TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Contact Name',
                border:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

              )
            ),
            const SizedBox(height: 20),
             TextField(
                 controller: contactController,
                 keyboardType: TextInputType.number,
                 maxLength: 10,
                 decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),

                )
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: (){
                    String name = nameController.text.trim();
                    String contact = contactController.text.trim();
                    if(name.isNotEmpty && contact.isNotEmpty){
                      setState(() {
                        contacts.add(Contact(name: name, number: contact));
                        nameController.clear();
                        contactController.clear();
                      });
                    }
                  },
                  child: const Text('Add Contact'),
                ),
                ElevatedButton(
                  onPressed: (){
                    String name = nameController.text.trim();
                    String contact = contactController.text.trim();
                    if(name.isNotEmpty && contact.isNotEmpty){
                      setState(() {
                        contacts[selectedIndex].name = name;
                        contacts[selectedIndex].number = contact;
                        nameController.clear();
                        contactController.clear();
                        selectedIndex= -1;//resetting the selected index
                      });
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            contacts.isEmpty?
            const Text('No Contacts available ...', style: TextStyle(fontSize: 22),)
                : Expanded(
                  child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context,index)=>getRow(index)),
            )
          ]
        ),
      ),
    );
  }

  Widget getRow(int index){
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index%2==0 ? Colors.deepPurple[100]: Colors.deepPurple[200],
          foregroundColor: Colors.purple[50],
          child:  Text(
          contacts[index].name[0].toUpperCase()
        )
        ),
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(contacts[index].name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(contacts[index].number, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: (){
                setState(() {
                  nameController.text= contacts[index].name;
                  contactController.text= contacts[index].number;
                  selectedIndex= index;
                });
              },
              icon: const Icon(Icons.edit),
              color: Colors.green,
            ),
            IconButton(
              onPressed: (){
                setState(() {
                  contacts.removeAt(index);
                });
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),

          ],
        )
      
      ),
    );
  }
}
