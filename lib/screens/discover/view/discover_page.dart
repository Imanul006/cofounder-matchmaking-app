import 'package:flutter/material.dart';
import 'package:kiuqi/constants/links.dart';
import 'package:kiuqi/models/user_model.dart';
import 'package:kiuqi/providers/actions_provider.dart';
import 'package:kiuqi/providers/cofounder_provider.dart';
import 'package:kiuqi/screens/discover/components/discover_item.dart';
import 'package:kiuqi/utils/loading_animation.dart';
import 'package:provider/provider.dart';

// import 'package:socket_io_client/socket_io_client.dart' as IO;

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PagerView(),
    );
  }
}

class PagerView extends StatefulWidget {
  const PagerView({Key? key}) : super(key: key);

  @override
  State<PagerView> createState() => _PagerViewState();
}

class _PagerViewState extends State<PagerView> {
  final PageController pageController = PageController(initialPage: 0);

  // final IO.Socket _socket = IO.io("http://localhost:8080", IO.OptionBuilder().setTransports(['websocket']).build());

  // _connectSocket() {
  //   _socket.onConnect((data) => print("Socket Connection Established"));
  //   _socket.onConnectError((data) => print("Socket Connection Refused: $data"));
  //   _socket.onDisconnect((data) => print("Socket Connection Disconnected"));
  // }

  @override
  void initState() {
    super.initState();
    // _connectSocket();
    context.read<ActionsProvider>().updateInteractionList();
    context.read<ActionsProvider>().updateConnectionList();
    context.read<CofounderProvider>().retrieveCofounderData();
  }

  @override
  Widget build(BuildContext context) {
    CofounderProvider _cofounderProvider =
        Provider.of<CofounderProvider>(context, listen: true);

    return _cofounderProvider.isLoading == true
        ? LoadingAnimation.shimmer()
        : PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            onPageChanged: (int itemIndex) {
              pageController.animateToPage(itemIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linearToEaseOut);

              if (itemIndex > 0 && itemIndex % 10 == 0) {
                _cofounderProvider.retrieveCofounderData();
              }
            },
            itemCount: _cofounderProvider.cofounderData.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              if (itemIndex == 0 || itemIndex % 10 == 0) {}
              return DiscoverItem(
                isUserDetails: false,
                user: _cofounderProvider.cofounderData[itemIndex]);
            },
          );
  }
}
//   UserModel _demoUser() {
//     return UserModel.fromJson({
//       "_id": "6267ddf11c5f215567968254",
//       "phone": "+919064610259",
//       "interactions": [],
//       "connections": [],
//       "__v": 0,
//       "city": "Berhampore",
//       "dob": "2022-04-26T12:00:55.000Z",
//       "email": "pritamsarkar014@gmail.com",
//       "name": "Pritam Sarkar",
//       "profile_pic":
//           "https://firebasestorage.googleapis.com/v0/b/project-x-test-2.appspot.com/o/Profile%20Pictures%2Fimon.png?alt=media&token=13bd1d13-842e-45a0-b535-ea9b40210dfa",
//       "state": "West Bengal",
//       "resume": {
//         "bio":
//             "Author of Tender'n Me • Featured on Amazon, Flipkart, Snapdeal • BITS Pilani • HarvardX",
//         "category": "Entrepreneur",
//         "expertise": "Team Management",
//         "startup_count": 3,
//         "skills":
//             "Creative Strategy, Visual Storytelling, Team Management, Content Marketing. ",
//         "has_startup": false,
//         "_id": "6267def91c5f215567968259"
//       },
//       "startup": {
//         "name": "Kiuqi",
//         "legal_name": "Kiuqi LLC.",
//         "tagline":
//             "Kiuqi helps Entrepreneurs to Find Co-founders for their Startup by using Kiuqi App. ",
//         "industry": "Madtech: Marketing + Advertising + Technology",
//         "date_founded": "2022-04-26T12:00:55.000Z",
//         "kv_incubation_id": "",
//         "_id": "6267defb1c5f21556796825d"
//       }
//     });
//   }
// }
