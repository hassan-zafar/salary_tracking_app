import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:salary_tracking_app/Extensions/integer_extensions.dart';
import 'package:salary_tracking_app/consts/collections.dart';
import 'package:salary_tracking_app/models/users.dart';
import 'package:salary_tracking_app/services/authentication_service.dart';
import 'package:salary_tracking_app/widgets/custom_toast%20copy.dart';
import 'package:salary_tracking_app/widgets/loadingWidget.dart';

import '../../models/timed_event.dart';
import '../auth/landing_page.dart';

class UserNSearch extends StatefulWidget {
  // final UserModel currentUser;
  // UserNSearch({this.currentUser});
  @override
  _UserNSearchState createState() => _UserNSearchState();
}

class _UserNSearchState extends State<UserNSearch>
    with AutomaticKeepAliveClientMixin<UserNSearch> {
  Future<QuerySnapshot>? searchResultsFuture;
  TextEditingController searchController = TextEditingController();
//  'Katy','Laporte','Houston',
  String typeSelected = 'Katy';
  handleSearch(String query) {
    if (currentUser!.isAdmin!) {
      Future<QuerySnapshot> users =
          userRef.where("name", isGreaterThanOrEqualTo: query).get();
      setState(() {
        searchResultsFuture = users;
      });
    } else {
      Future<QuerySnapshot> users = userRef
          .where("name", isGreaterThanOrEqualTo: query)
          .where("isAdmin", isNotEqualTo: true)
          .get();
      setState(() {
        searchResultsFuture = users;
      });
    }
  }

  clearSearch() {
    searchController.clear();
  }

  AppBar buildSearchField(context) {
    return AppBar(
      backgroundColor: Theme.of(context).accentColor,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.black),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: clearSearch,
            )),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  buildSearchResult() {
    return FutureBuilder<QuerySnapshot>(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingIndicator();
        }
        List<UserResult> searchResults = [];
        snapshot.data!.docs.forEach((doc) {
          String completeName =
              doc["employName"].toString().toLowerCase().trim();
          if (completeName.contains(searchController.text)) {
            TimedEvent user = TimedEvent.fromDocument(doc);
            setState(() {
              UserResult searchResult = UserResult(user);
              searchResults.add(searchResult);
            });
          }
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        appBar: buildSearchField(context),
        body:
            searchResultsFuture == null ? buildAllUsers() : buildSearchResult(),
      ),
    );
  }

  buildAllUsers() {
    return Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: timerRef.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LoadingIndicator();
              }
              List<UserResult> userResults = [];
              List<UserResult> allAdmins = [];
              List<UserResult> katyUsers = [];
              List<UserResult> laporteUsers = [];
              List<UserResult> houstonUsers = [];

              snapshot.data!.docs.forEach((doc) {
                TimedEvent user = TimedEvent.fromDocument(doc);

                //remove auth user from recommended list
                userResults.add(UserResult(user));
                if (user.isAdmin) {
                  UserResult adminResult = UserResult(user);
                  allAdmins.add(adminResult);
                } else if (user.companyName == 'Katy') {
                  katyUsers.add(UserResult(user));
                } else if (user.companyName == 'Houston') {
                  houstonUsers.add(UserResult(user));
                } else if (user.companyName == 'Laporte') {
                  laporteUsers.add(UserResult(user));
                }
              });
              return GlassContainer(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    currentUser!.isAdmin!
                        ? Container(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              typeSelected = "users";
                                            });
                                          },
                                          child: GlassContainer(
                                            opacity: 0.7,
                                            shadowStrength: 8,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "All Users ${userResults.length}",
                                                style:
                                                    const TextStyle(fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              typeSelected = "admin";
                                            });
                                          },
                                          child: GlassContainer(
                                            opacity: 0.7,
                                            shadowStrength: 8,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "All Admins ${allAdmins.length}",
                                                style:
                                                    const TextStyle(fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              typeSelected = "Katy";
                                            });
                                          },
                                          child: GlassContainer(
                                            opacity: 0.7,
                                            shadowStrength: 8,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Katy ${katyUsers.length}",
                                                style:
                                                    const TextStyle(fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              typeSelected = "Houston";
                                            });
                                          },
                                          child: GlassContainer(
                                            opacity: 0.7,
                                            shadowStrength: 8,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Houston ${houstonUsers.length}",
                                                style: const TextStyle(
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              typeSelected = "Laporte";
                                            });
                                          },
                                          child: GlassContainer(
                                            opacity: 0.7,
                                            shadowStrength: 8,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Laporte ${laporteUsers.length}",
                                                style:
                                                    const TextStyle(fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              typeSelected = "admin";
                                            });
                                          },
                                          child: GlassContainer(
                                            opacity: 0.7,
                                            shadowStrength: 8,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "All Admins ${allAdmins.length}",
                                                style:
                                                    const TextStyle(fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    typeSelected == 'admin'
                        ? Column(
                            children: allAdmins,
                          )
                        : const Text(""),
                    typeSelected == 'users'
                        ? Column(
                            children: userResults.toList(),
                          )
                        : const Text(''),
                    typeSelected == 'Katy'
                        ? Column(
                            children: katyUsers.toList(),
                          )
                        : const Text(''),
                    typeSelected == 'Houston'
                        ? Column(
                            children: houstonUsers.toList(),
                          )
                        : const Text(''),
                    typeSelected == 'Laporte'
                        ? Column(
                            children: laporteUsers.toList(),
                          )
                        : const Text(''),
                  ],
                ),
              );
            }),
        Positioned(
            left: 20,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                AuthenticationService().signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LandingPage(),
                ));
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("LogOut"),
                  )),
            ))
      ],
    );
  }
}

class UserResult extends StatelessWidget {
  final TimedEvent user;
  UserResult(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => makeAdmin(context),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GlassContainer(
                  opacity: 0.6,
                  shadowStrength: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(user.imageUrl),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user.employName,
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ]),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            user.companyName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ),
                        Row(
                          children: [
                            const Text('Total Time: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),),
                            Text(user.totalSecondsPerSession
                                .formatSecondsToTimeWithFormat),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Computed Wage: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),),
                            Text((user.wage *
                                    (user.totalSecondsPerSession / 3600))
                                .toStringAsFixed(2)),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                // ListTile(
                //   leading: CircleAvatar(
                //     backgroundColor: Colors.grey,
                //     child: Icon(Icons.person),
                //   ),
                //   title: Text(
                //     user.name.toString(),
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                //   subtitle: Text(
                //     user.name.toString(),
                //   ),
                //   trailing: Text(user.isAdmin != null && user.isAdmin == true
                //       ? "Admin"
                //       : "User"),
                // ),

                ),
          ),
        ],
      ),
    );
  }

  makeAdmin(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              user.isAdmin && user.id != currentUser!.id
                  ? SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                        makeAdminFunc("Rank changed to User");
                      },
                      child: const Text(
                        'Make User',
                      ),
                    )
                  : SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                        makeAdminFunc("Upgraded to Admin");
                      },
                      child: const Text(
                        'Make Admin',
                      ),
                    ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);

                  deleteUser(user.id.toString());
                },
                child: const Text(
                  'Delete User',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              )
            ],
          );
        });
  }

  void makeAdminFunc(String msg) {
    userRef.doc(user.id.toString()).update({"isAdmin": !user.isAdmin});
    addToFeed(msg);

    // CustomToast.successToast(message: msg);
  }

  addToFeed(String msg) {
    // activityFeedRef.doc(user.id).collection('feedItems').add({
    //   "type": "mercReq",
    //   "commentData": msg,
    //   "userName": user.displayName,
    //   "userId": user.id,
    //   "userProfileImg": user.photoUrl,
    //   "ownerId": currentUser.id,
    //   "mediaUrl": currentUser.photoUrl,
    //   "timestamp": timestamp,
    //   "productId": "",
    // });
  }
  void deleteUser(
    String id,
  ) async {
    userRef.doc(id).get().then((value) {
      if (value.exists) {
        AppUserModel user = AppUserModel.fromDocument(value);
        AuthenticationService().deleteUser(user.email!, user.password!);
        CustomToast.successToast(message: 'User Deleted Refresh');
      }
    });
  }
}
