import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dagu/features/authentication/views/otp/otp.dart';

class PreferencesView extends StatefulWidget {
  const PreferencesView({Key? key}) : super(key: key);

  @override
  _PreferencesViewState createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  final _formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    bool dark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    List<String> topics = [
      "Politics",
      "World",
      "Business",
      "Tech",
      "Climate",
      "Health",
      "Culture",
      "Science",
      "Sports",
      "Education",
      "Obituaries",
      "The Upshot",
      "The Magazine",
      "2024 Elections",
      "Primary Results",
      "Supreme Court",
      "Congress",
      "Biden Administration",
      "Trump Investigations",
      "Immigration",
      "Abortion",
      "Campus Protests",
      "Audio",
      "Podcasts",
      "Narrated Articles",
      "Newsletters",
      "Games",
      "Puzzles",
      "Crosswords",
      "Baseball",
      "Soccer",
      "Opinion",
      "Lifestyle",
      "Wellness",
      "Travel",
      "Style",
      "Real Estate",
      "Food",
      "Love",
      "Your Money",
      "Personal Tech",
      "T Magazine"
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
                      text: "Mekdem",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF652D91), // DaguColors.primaryColor,
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
                  onPressed: () {
                    Get.to(() => NewsHomePage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF652D91), // Button color
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
