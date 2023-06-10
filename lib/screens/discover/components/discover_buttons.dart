import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/providers/actions_provider.dart';
import 'package:kiuqi/utils/loading_animation.dart';
import 'package:provider/provider.dart';

class DiscoverButtons extends StatefulWidget {
  final String userId;
  const DiscoverButtons({Key? key, required this.userId}) : super(key: key);

  @override
  State<DiscoverButtons> createState() => _DiscoverButtonsState();
}

class _DiscoverButtonsState extends State<DiscoverButtons> {
  @override
  void initState() {
    context.read<ActionsProvider>().initInteractionState(id: widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ActionsProvider _actionProvider =
        Provider.of<ActionsProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(Sizes.componentSideMargin),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: _actionProvider.isLoading
            ? LoadingAnimation.circular()
            : _getButtons(_actionProvider),
      ),
    );
  }

  Widget _getButtons(ActionsProvider actionProvider) {
    switch (actionProvider.buttonIndex) {
      case 0:
        {
          return _buildPrimaryButtons(actionProvider);
        }
      case 1:
        {
          return _buildAcceptOrRejectButtons(actionProvider);
        }
      case 2:
        {
          return _buildButtonsForConnectedCofounders(actionProvider);
        }
      default:
        {
          return _buildPrimaryButtons(actionProvider);
        }
    }
  }

  Widget _buildButtonsForConnectedCofounders(ActionsProvider actionProvider) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Card(
              elevation: 4,
              color: Colors.white,
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: FaIcon(
                  FontAwesomeIcons.link,
                  size: 20,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "This entrepreneur is already connected with you.",
                style: BaseStyles.greySmallSecondaryTextStyle,
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildRectCardButtons(
                isPrimary: false,
                icon: FontAwesomeIcons.userTimes,
                buttonText: "Remove",
                onPressed: () async {
                  bool _status =
                      await actionProvider.removeConnection(widget.userId);
                  if (_status) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Connection removed successfully..."),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Failed to remove connection. (Uncaught error)"),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: Sizes.componentSideMargin),
            Expanded(
              child: _buildRectCardButtons(
                  isPrimary: true,
                  icon: FontAwesomeIcons.commentDots,
                  buttonText: "Chat",
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Chat feature is coming soon..."),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAcceptOrRejectButtons(ActionsProvider actionProvider) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Card(
              elevation: 4,
              color: Colors.white,
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: FaIcon(
                  FontAwesomeIcons.solidHandshake,
                  size: 20,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "This entrepreneur has sent you a connection request.",
                style: BaseStyles.greySmallSecondaryTextStyle,
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildRectCardButtons(
                isPrimary: false,
                icon: FontAwesomeIcons.timesCircle,
                buttonText: "Reject",
                onPressed: () async {
                  bool _status =
                      await actionProvider.deleteRequest(widget.userId);
                  if (_status) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Request deleted successfully..."),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Failed to delete request. (Uncaught error)"),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: Sizes.componentSideMargin),
            Expanded(
              child: _buildRectCardButtons(
                isPrimary: true,
                icon: FontAwesomeIcons.checkCircle,
                buttonText: "Accept",
                onPressed: () async {
                  bool _status =
                      await actionProvider.acceptRequest(widget.userId);
                  if (_status) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Request accepted successfully..."),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Failed to accept request. (Uncaught error)"),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrimaryButtons(ActionsProvider actionProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCardButtons(
          // Reject button
          isActivated: actionProvider.rejectIsActivated,
          icon: FontAwesomeIcons.times,
          iconColor: const Color.fromARGB(180, 0, 0, 0),
          onPressed: () async {
            late String _snackbarText;
            Map<String, bool> _status =
                await actionProvider.rejectOrUnreject(widget.userId);

            if (_status['status']!) {
              if (_status['isSent']!) {
                _snackbarText = "Rejected successfully...";
              } else {
                _snackbarText = "Undo rejection successful...";
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_snackbarText),
                  duration: const Duration(milliseconds: 1000),
                ),
              );
            }
          },
        ),
        _buildCardButtons(
          // Like button
          isActivated: actionProvider.likeIsActivated,
          icon: FontAwesomeIcons.solidHeart,
          iconColor: Colors.red,
          onPressed: () async {
            late String _snackbarText;
            Map<String, bool> _status =
                await actionProvider.likeOrUnlike(widget.userId);

            if (_status['status']!) {
              if (_status['isSent']!) {
                _snackbarText = "Liked successfully...";
              } else {
                _snackbarText = "Unliked successfully...";
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_snackbarText),
                  duration: const Duration(milliseconds: 1000),
                ),
              );
            }
          },
        ),
        _buildCardButtons(
          // Request Button
          isActivated: actionProvider.requestIsActivated,
          icon: FontAwesomeIcons.check,
          iconColor: Colors.green,
          onPressed: () async {
            late String _snackbarText;
            Map<String, bool> _status =
                await actionProvider.sendOrUnsendRequest(widget.userId);

            if (_status['status']!) {
              if (_status['isSent']!) {
                _snackbarText = "Request sent successfully...";
              } else {
                _snackbarText = "Request unsent successfully...";
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_snackbarText),
                  duration: const Duration(milliseconds: 1000),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildRectCardButtons(
      {required bool isPrimary,
      required IconData icon,
      required String buttonText,
      Function()? onPressed}) {
    return RawMaterialButton(
      onPressed: onPressed ??
          (() {
            if (kDebugMode) print("action not assigned...");
          }),
      elevation: 5.0,
      fillColor: isPrimary ? AppColor.primaryColor : Colors.white,
      padding: const EdgeInsets.all(15.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        side: BorderSide(
          width: 1,
          color: AppColor.primaryColor,
        ),
      ),
      child: Row(
        children: [
          FaIcon(
            icon,
            color: isPrimary ? Colors.white : AppColor.primaryColor,
            size: 25.0,
          ),
          const SizedBox(width: 8),
          Text(
            buttonText,
            style: TextStyle(
                color: isPrimary ? Colors.white : AppColor.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildCardButtons(
      {required bool isActivated,
      required IconData icon,
      required Color iconColor,
      Function()? onPressed}) {
    return RawMaterialButton(
      onPressed: onPressed ??
          (() {
            if (kDebugMode) print("action not assigned...");
          }),
      elevation: 5.0,
      fillColor: isActivated ? iconColor : Colors.white,
      padding: const EdgeInsets.all(15.0),
      shape: const CircleBorder(),
      child: FaIcon(
        icon,
        color: isActivated ? Colors.white : iconColor,
        size: 38.0,
      ),
    );
  }
}
