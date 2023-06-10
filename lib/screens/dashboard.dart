import 'package:flutter/material.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/screens/activities/view/activities_screen.dart';
import 'package:kiuqi/screens/discover/view/discover_page.dart';
import 'package:kiuqi/screens/profile/view/profile_page.dart';
import 'package:kiuqi/utils/loading_animation.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
  
);

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  List<Widget> pages = [
    const DiscoverPage(),
    const ActivitiesScreen(),
    // Center(
    //   child: Padding(
    //     padding: const EdgeInsets.all(20.0),
        
    //     child: Text('Activites Screen',textAlign: TextAlign.center, style: _textStyle),
    //   ),
    // ),
    const ProfilePage(),
    const ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                offset: Offset(0.0, 0.75))
          ],
        ),
        child: NavigationBar(
          height: 70,
          backgroundColor: AppColor.navBarColor,
          animationDuration: const Duration(milliseconds: 800),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _currentIndex,
          onDestinationSelected: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.people_alt),
              icon: Icon(Icons.people_alt_outlined),
              label: 'Discover',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.aod),
              icon: Icon(Icons.aod_outlined),
              label: 'Activities',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.account_circle),
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.chat),
              icon: Icon(Icons.chat_outlined),
              label: 'Chats',
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: 
          Image.asset(
            ImageLinks.CHAT_SCREEN,
            fit: BoxFit.fitWidth,
          ),
        ),
      );
  }
}