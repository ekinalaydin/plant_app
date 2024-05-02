import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/models/post.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/themes/colors.dart';
import '../screens/post_detail_screen.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostDetailPage(postId: widget.post.id)),
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
                  widget.post.title,
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
                        backgroundImage:
                            AssetImage(widget.post.authorProfileImage),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.createdByUsername,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: AppColors.onSurface,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .add_Hm()
                                  .format(widget.post.createdAt),
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
<<<<<<< Updated upstream
                          IconButton(
                            icon: Icon(Icons.favorite),
                            color:
                                widget.post.isLiked ? Colors.red : Colors.grey,
                            onPressed: () async {
                              await ApiService()
                                  .likePost(widget.post.id, context);
                              setState(() {
                                widget.post.isLiked = !widget.post.isLiked;
                                widget.post.likeCount +=
                                    widget.post.isLiked ? 1 : -1;
                              });
                            },
=======
                          Expanded(
                            child: IconButton(
                              icon: Icon(Icons.favorite),
                              color: widget.post.isLiked
                                  ? Colors.red
                                  : AppColors.secondaryVariant,
                              iconSize: MediaQuery.of(context).size.height / 35,
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                await ApiService()
                                    .likePost(widget.post.id, context);
                                setState(() {
                                  widget.post.isLiked = !widget.post.isLiked;
                                  widget.post.likeCount +=
                                      widget.post.isLiked ? 1 : -1;
                                });
                              },
                            ),
>>>>>>> Stashed changes
                          ),
                          Text(
                            '${widget.post.likeCount}',
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
