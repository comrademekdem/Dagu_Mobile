import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Topic Preferences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TopicPreferencesPage(),
    );
  }
}

class TopicPreferencesPage extends StatefulWidget {
  const TopicPreferencesPage({super.key});
  @override
  _TopicPreferencesPageState createState() => _TopicPreferencesPageState();
}

class _TopicPreferencesPageState extends State<TopicPreferencesPage> {
  List<String> topics = [
    'Technology',
    'Science',
    'Health',
    'Sports',
    'Art',
    'Music',
    'Travel',
    'Food',
    'Education',
    'Politics',
  ];

  Set<String> selectedTopics = {};

  void _toggleTopicSelection(String topic) {
    setState(() {
      if (selectedTopics.contains(topic)) {
        selectedTopics.remove(topic);
      } else {
        selectedTopics.add(topic);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Interests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Select the topics you are interested in:',
              style: TextStyle(fontSize: 18.0),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  final topic = topics[index];
                  final isSelected = selectedTopics.contains(topic);
                  return GestureDetector(
                    onTap: () => _toggleTopicSelection(topic),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          topic,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle saving the selected topics
                print('Selected Topics: $selectedTopics');
              },
              child: Text('Save Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}