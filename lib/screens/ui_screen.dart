import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/screens/ui_screen2.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const FollowUpScreen(),
    );
  }
}

class FollowUpScreen extends StatelessWidget {
  const FollowUpScreen({Key? key}) : super(key: key);

  Widget _buildRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon, color: Colors.teal.shade700, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('When to use follow-up',style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 12),

                  _buildRow(
                    Icons.link_outlined,
                    'Ask substitutes of prescribe medication',
                    'In case the prescribe medicines are not available',
                  ),
                  const Divider(height: 2),

                  _buildRow(
                    Icons.help_outline,
                    'Ask clarifications',
                    'Around prescription dosage,effectivenss of treatment or lifestyle changes',
                  ),
                  const Divider(height: 2),

                  _buildRow(
                    Icons.sentiment_dissatisfied,
                    'No improvement in condition',
                    'If your medical condition hasn\'t improved even after following prescribed treatment',
                  ),
                  const Divider(height: 2),

                  _buildRow(
                    Icons.description_outlined,
                    'Show tests and reports',
                    'If there are tests are reports to be shown',
                  ),

                  const SizedBox(height: 18),

                  // Section header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'When not to use follow -up',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade800,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  _buildRow(
                    Icons.person_outline,
                    'Do not consult for a different problem',
                    'Only ask question relating to the health concern the primary consultation was for',
                  ),
                  const Divider(height: 2),

                  _buildRow(
                    Icons.person_outline,
                    'Do not consult for another family member',
                    'Continue followup for the same patient that the primary consultation was done for',
                  ),

                  const SizedBox(height: 18),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      'Please note that follow-up is not for emergency case go to your nearby hospital in case of an emergency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 90), // leave space for button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                // action
                // Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => HelpSupportScreen(),));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.teal,
                elevation: 0,
              ),
              child: const Text(
                'Go It',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
