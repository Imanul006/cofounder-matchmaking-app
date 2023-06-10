import 'package:flutter/material.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/providers/cofounder_provider.dart';
import 'package:kiuqi/screens/activities/components/list_card.dart';
import 'package:kiuqi/screens/view_user_screen.dart';
import 'package:kiuqi/utils/loading_animation.dart';
import 'package:provider/provider.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Activities'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColor.primaryColor,
          labelColor: AppColor.primaryColor,
          unselectedLabelColor: Colors.black54,
          isScrollable: false,
          tabs: const <Widget>[
            Tab(
              text: ('Requests'),
            ),
            Tab(
              text: ('Interactions'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          RequestsTabBar(),
          InteractionsTabBar(),
        ],
        controller: _tabController,
      ),
    );
  }
}

class RequestsTabBar extends StatefulWidget {
  const RequestsTabBar({Key? key}) : super(key: key);

  @override
  _RequestsTabBarState createState() => _RequestsTabBarState();
}

class _RequestsTabBarState extends State<RequestsTabBar>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: AppColor.primaryColor,
          labelColor: AppColor.primaryColor,
          unselectedLabelColor: Colors.black54,
          isScrollable: false,
          tabs: const <Widget>[
            Tab(
              text: "Sent Requests",
            ),
            Tab(
              text: "Recieved Requests",
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.65,
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _nestedTabController,
            children: <Widget>[
              EntryBuilder(
                context: context,
                interactionType: "sent",
              ),
              EntryBuilder(
                context: context,
                interactionType: "incoming",
              ),
            ],
          ),
        )
      ],
    );
  }
}

class InteractionsTabBar extends StatefulWidget {
  const InteractionsTabBar({Key? key}) : super(key: key);

  @override
  _InteractionsTabBarState createState() => _InteractionsTabBarState();
}

class _InteractionsTabBarState extends State<InteractionsTabBar>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: AppColor.primaryColor,
          labelColor: AppColor.primaryColor,
          unselectedLabelColor: Colors.black54,
          isScrollable: false,
          tabs: const <Widget>[
            Tab(
              text: "Connected Profiles",
            ),
            Tab(
              text: "Liked Profiles",
            ),
            Tab(
              text: "Rejected Profiles",
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.70,
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _nestedTabController,
            children: <Widget>[
              EntryBuilder(
                context: context,
                interactionType: "connected",
              ),
              EntryBuilder(
                context: context,
                interactionType: "liked",
              ),
              EntryBuilder(
                context: context,
                interactionType: "rejected",
              ),
            ],
          ),
        )
      ],
    );
  }
}

class EntryBuilder extends StatefulWidget {
  final String interactionType;
  final BuildContext context;
  const EntryBuilder({Key? key, required this.interactionType, required this.context})
      : super(key: key);

  @override
  State<EntryBuilder> createState() => _EntryBuilderState();
}

class _EntryBuilderState extends State<EntryBuilder> {
  
  @override
  void initState() {
    final CofounderProvider _cofounderProvider =
        Provider.of<CofounderProvider>(widget.context, listen: true);
    _cofounderProvider.retrieveCofounderDataByInteractionType(interactionType: widget.interactionType);    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CofounderProvider _cofounderProvider =
        Provider.of<CofounderProvider>(context, listen: true);

    return _cofounderProvider.isLoading == true
        ? ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int itemIndex) => LoadingAnimation.shimmerListTile()) 
        
        : _cofounderProvider.interactedUserData.isEmpty
            ? Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: 
          Image.asset(
            ImageLinks.NO_DATA,
            fit: BoxFit.fitWidth,
          ),
        ),
      )
            : ListView.builder(
                itemCount: _cofounderProvider.interactedUserData.length,
                itemBuilder: (BuildContext context, int itemIndex) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ViewUserPage(
                          user:
                              _cofounderProvider.interactedUserData[itemIndex],
                        ),
                      )),
                      child: ListCard(
                        name: _cofounderProvider
                            .interactedUserData[itemIndex].name!,
                        category: _cofounderProvider
                            .interactedUserData[itemIndex].resume!.category!,
                        expertise: _cofounderProvider
                            .interactedUserData[itemIndex].resume!.expertise!,
                      ),
                    ),
                  );
                });
  }
}
