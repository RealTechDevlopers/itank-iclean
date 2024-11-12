import 'package:flutter/material.dart';

class New extends StatefulWidget {
  const New({super.key});

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Refresh the indicator when the tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 310,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://lh3.googleusercontent.com/p/AF1QipP_B_8E8rbR-ZV4nXKxWgIaGcyVEAr0CM_lUa2c=s680-w680-h510",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 219, 191, 191),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_tabController.index == 0 ? 20 : 0),
                  topRight: Radius.circular(_tabController.index == 1 ? 20 : 0),
                ),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: const Color.fromARGB(255, 228, 221, 221),
              unselectedLabelColor: const Color.fromARGB(255, 20, 19, 19),
              tabs: const [
                Tab(text: 'STUDENT'),
                Tab(text: 'TRAINER'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildStudentTab(),
                _buildTrainerTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // STUDENT Tab Content
  Widget _buildStudentTab() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 25, 30, 10),
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 10, 10, 10)),
              ),
              filled: true,
              labelText: "Phone or Email",
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 15, 30, 5),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              filled: true,
              labelText: "Phone or Email",
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot Password?",
            style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)),
          ),
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            // Add your login logic here
          },
          child: const Text(
            "LOG IN AS STUDENT",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  // TRAINER Tab Content
  Widget _buildTrainerTab() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 25, 30, 10),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              filled: true,
              labelText: "Phone or Email",
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 15, 30, 5),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            decoration: InputDecoration(
              filled: true,
              labelText: "Phone or Email",
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot Password?",
            style: TextStyle(color: Color.fromARGB(255, 14, 13, 13)),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            // Add your login logic here
          },
          child: const Text(
            "LOG IN AS TRAINER",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
