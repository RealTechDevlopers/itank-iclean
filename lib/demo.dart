import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 tabs for Student and Trainer
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Section
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/logo.png', // Ensure the logo image is placed in assets folder
                      height: 100,
                    ),
                    const SizedBox(height: 10),
                    // Title
                    const Text(
                      'Z-Smart Academy',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    const Text(
                      'BE THE SMARTER YOU',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Tab Bar
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab, // Makes indicator cover full tab width
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: 'STUDENT'),
                    Tab(text: 'TRAINER'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Tab Views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    buildLoginForm(isStudent: true),
                    buildLoginForm(isStudent: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm({required bool isStudent}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Phone or Email TextField
            const TextField(
              decoration: InputDecoration(
                labelText: 'Phone or Email',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Password TextField
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Implement Forgot Password Functionality
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Login Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60), // Adjusted padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Implement Login Functionality
              },
              child: Text(
                isStudent ? 'LOG IN AS STUDENT' : 'LOG IN AS TRAINER',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
