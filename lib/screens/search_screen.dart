import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagramclone/const/colors.dart';
import 'package:instagramclone/screens/profile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUser = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Form(
          child: TextFormField(
            controller: searchController,
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUser = true;
              });
            },
            decoration: const InputDecoration(
                labelText: 'Search for users', border: InputBorder.none),
          ),
        ),
      ),
      body: isShowUser
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isLessThanOrEqualTo: searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                            uid: (snapshot.data! as dynamic).docs[index]
                                ['uid']),
                      )),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]['pics']),
                        ),
                        title: Text((snapshot.data! as dynamic).docs[index]
                            ['username']),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return 
                
                // GridView.custom(
                //   gridDelegate: SliverQuiltedGridDelegate(
                //     crossAxisCount: 3,
                //     mainAxisSpacing: 8,
                //     crossAxisSpacing: 8,
                //     repeatPattern: QuiltedGridRepeatPattern.inverted,
                //     pattern: [
                //       const QuiltedGridTile(2, 2),
                //       const QuiltedGridTile(1, 1),
                //       const QuiltedGridTile(1, 1),
                //       // const QuiltedGridTile(1, 2),
                //     ],
                //   ),
                //   childrenDelegate: SliverChildBuilderDelegate(
                //     childCount: (snapshot.data!).docs.length,
                //     (context, index) => Image.network(snapshot.data!.docs[index]['postUrl'],
                //     fit: BoxFit.cover,),
                //   ),
                // );
                
                StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) =>
                      Image.network(snapshot.data!.docs[index]['postUrl'], fit: BoxFit.cover,),
                  staggeredTileBuilder: (int index) => StaggeredTile.count(
                    index % 7 == 0 ? 2 : 1,
                    index % 7 == 0 ? 2 : 1,
                  ),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                );
              },
            ),
    );
  }
}
