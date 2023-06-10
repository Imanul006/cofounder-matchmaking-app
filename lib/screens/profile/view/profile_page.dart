import 'package:flutter/material.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: AppColor.discoverHeaderGradient,
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80.0),
                  bottomRight: Radius.circular(80.0),
                ),
              ),
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(Sizes.componentSideMargin),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColor.primaryColor,
                                radius: 85,
                                child: CircleAvatar(
                                  backgroundColor: Colors.orange[100],
                                  radius: 82,
                                  child: const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://firebasestorage.googleapis.com/v0/b/project-x-test-2.appspot.com/o/profile-placeholder.png?alt=media&token=f86271fd-befd-49b8-95e2-b0d0d2a8790b"),
                                    radius: 80,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                "Lorem Ipsum",
                                style: BaseStyles.primaryLargeTitleTextStyle,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Entrepreneur, Technical",
                                style: BaseStyles.greySmallSecondaryTextStyle,
                              ),
                              const SizedBox(height: 22),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text(""),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logoutSession(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
