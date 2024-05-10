import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/models/post.dart';
import 'package:plant_app/screens/post_detail_screen.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/themes/colors.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to post detail screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailPage(postId: post.id),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          height: MediaQuery.of(context).size.height / 7,
          margin: const EdgeInsets.only(top: 8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.secondaryVariant,
                spreadRadius: 1,
                blurRadius: 15,
                offset: Offset(0, 0.5),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryVariant],
              stops: [0.25, 0.75],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 14.0, right: 14, top: 8, bottom: 8),
                child: Text(
                  post.title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 14.0, right: 14, top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.background,
                        backgroundImage: AssetImage(post.authorProfileImage),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.createdByUsername,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: AppColors.onSurface,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .add_Hm()
                                  .format(post.createdAt),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: IconButton(
                              icon: Icon(Icons.favorite),
                              color: post.isLiked
                                  ? Colors.red
                                  : AppColors.secondaryVariant,
                              iconSize: MediaQuery.of(context).size.height / 35,
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                // Like or unlike the post
                                await ApiService().likePost(post.id, context);
                              },
                            ),
                          ),
                          Text(
                            '${post.likeCount}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              fontSize: 11,
                              color: AppColors.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
