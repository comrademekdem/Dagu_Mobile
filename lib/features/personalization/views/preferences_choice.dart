import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:dagu/features/personalization/views/topics_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dagu/utils/api_service/api_service.dart';

class PreferencesView extends StatefulWidget {
  final User user;

  const PreferencesView({
    required this.user,
  });

  @override
  _PreferencesViewState createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  final _formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];

  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    bool dark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    List<String> topics = [
      "Politics",
      "Business",
      "Technology",
      "Entertainment",
      "Health",
      "Science",
      "Education",
      "Environment",
      "Crime",
      "Human Interest",
      "Travel",
      "Opinion Editorial",
      "Finance",
      "Sports",
      "Lifestyle",
      "Automotive",
      "Real Estate",
      "Fashion",
      "Food and Dining",
      "Arts and Culture",
      "Books",
      "Movies",
      "Music",
      "Photography",
      "Gaming",
      "Fitness",
      "Nature",
      "Wellness",
      "Startups",
      "Gadgets",
      "Artificial Intelligence",
      "Space",
      "Robotics",
      "Astronomy",
      "Medicine",
      "Mental Health",
      "Nutrition",
      "Psychology",
      "Economics",
      "Investment",
      "Personal Finance",
      "Cryptocurrency",
      "Parenting",
      "Home Improvement",
      "Pets",
      "Social Media",
      "World News",
      "Local News"
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${widget.user.firstName}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF652D91),
                      ),
                    ),
                    TextSpan(
                      text: ", Welcome to Dagu News.",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: dark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 25),
              Text(
                "Tell us what you want to discover, from Sports to Politics, from Entertainment to Health and Dagu will deliver.",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 19,
                  color: dark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 107,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedTopics.clear();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                            color: dark ? Colors.white : Color(0xFF652D91),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Icon(
                            Iconsax.trash,
                            color: dark ? Colors.white : Color(0xFF652D91),
                            size: 16,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Reset",
                            style: TextStyle(
                              color: dark ? Colors.white : Color(0xFF652D91),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: topics.map((topic) {
                  final isSelected = selectedTopics.contains(topic);
                  return ChoiceChip(
                    label: Text(
                      topic,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color(0xFF652D91),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: Color(0xFF652D91),
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                      color: Color(0xFF652D91),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onSelected: (selected) {
                      setState(() {
                        if (isSelected) {
                          selectedTopics.remove(topic);
                        } else {
                          selectedTopics.add(topic);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedTopics.isEmpty
                      ? null // Disable button if no topic selected
                      : () async {
                          if (selectedTopics.isNotEmpty) {
                            // Map selected topics to backend-supported topics
                            List<String> mappedTopics = selectedTopics
                                .map((topic) => TopicsMap.topicMapping[topic]!)
                                .toList();

                            try {
                              await _apiService.setUserPreferences(
                                  widget.user, mappedTopics);
                              Get.to(() => NewsHomePage(user: widget.user));
                            } catch (e) {
                              print('Failed to update preferences: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Failed to update preferences')),
                              );
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF652D91),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
