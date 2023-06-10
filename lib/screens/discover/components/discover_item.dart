import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/models/user_model.dart';
import 'package:kiuqi/providers/actions_provider.dart';
import 'package:kiuqi/screens/discover/components/discover_bio.dart';
import 'package:kiuqi/screens/discover/components/discover_buttons.dart';
import 'package:kiuqi/screens/discover/components/discover_contact_info.dart';
import 'package:kiuqi/screens/discover/components/discover_item_header.dart';
import 'package:kiuqi/screens/discover/components/discover_startup.dart';
import 'package:kiuqi/utils/extensions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscoverItem extends StatelessWidget {
  final UserModel user;
  final bool isUserDetails;

  const DiscoverItem({Key? key, required this.user, required this.isUserDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              DiscoverItemHeader(
                name: user.name!,
                age: _getAgeFromDob(user.dob!),
                category: user.resume!.category!,
                hasStartup: user.resume!.hasStartup!,
                expertise: user.resume!.expertise!,
                location: user.city! + ", " + user.state!,
                //TODO: Add default profile pic
                profilePic: "https://firebasestorage.googleapis.com/v0/b/project-x-test-2.appspot.com/o/profile-placeholder.png?alt=media&token=f86271fd-befd-49b8-95e2-b0d0d2a8790b",
                skills: user.resume!.skills!,
                startupCount: user.resume!.startupCount!.toDouble(),
                isHidden: !context.read<ActionsProvider>().currentUserIsConnected(user.id!),
                isUserDetails: isUserDetails,
              ),
              const SizedBox(height: 20),
              
              DiscoverButtons(userId: user.id!),
              const SizedBox(height: 20),
              
              DiscoverBio(
                name: user.name!.formatName(),
                bio: user.resume!.bio!,
              ),

              user.resume!.hasStartup!? DiscoverStartup(
                hasStartup: user.resume!.hasStartup!,
                name: user.startup!.name!,
                legalName: user.startup!.legalName!,
                tagline: user.startup!.tagline!,
                industry: user.startup!.industry!,
                dateFounded: user.startup!.dateFounded!,
              ) : DiscoverStartup(hasStartup: user.resume!.hasStartup!),

              DiscoverContactInfo(
                phone: user.phone!,
                email: user.email!,
                isHidden: !context.read<ActionsProvider>().currentUserIsConnected(user.id!),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  double _getAgeFromDob(DateTime dob) {
    //TODO: Create DOB to age calculator

    if (kDebugMode) print("DOB: $dob");

    return 24;
  }
}
