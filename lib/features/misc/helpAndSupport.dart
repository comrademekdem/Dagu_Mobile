import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help and Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dagu App',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16.0),
            Text(
              'Version: 1.0.0',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact our Developers and Support Team.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16.0),
            Text(
              'Mekdem - mekdemaemero360@gmail.com',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Fekadu - fekadusisay@gmail.com',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Biruk - biruknigussie.com',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
