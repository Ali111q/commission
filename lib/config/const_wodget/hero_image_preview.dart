import 'dart:io';

import 'package:Trip/config/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HeroImagePreview extends StatefulWidget {
  final String mainImagePath; // Path for the thumbnail image
  final List imagePaths; // List of image paths for the page view
  final String heroTag;
  final int index;
  final int moreCount;
  final bool more;
  final bool isFile;
  HeroImagePreview({
    required this.mainImagePath,
    required this.imagePaths,
    required this.heroTag,
    required this.index,
    this.moreCount = 0,
    this.more = false,
    this.isFile = false,
  });

  @override
  _HeroImagePreviewState createState() => _HeroImagePreviewState();
}

class _HeroImagePreviewState extends State<HeroImagePreview> {
  double _backgroundOpacity = 1;
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isFile && !isError) {
          showImagePreview(context, widget.index, widget.imagePaths,
              widget.heroTag, widget.mainImagePath);
        }
      },
      // onVerticalDragUpdate: (details) {
      //   // Calculate the new opacity based on the drag position
      //   double newOpacity = (1 - details.primaryDelta! / 100).clamp(0.0, 1.0);
      //   setState(() {
      //     _backgroundOpacity = newOpacity;
      //   });
      // },
      child: Hero(
        tag: '${widget.heroTag}_${widget.index}',
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: isError
                ? Container(
                    height: Get.height * 0.3,
                    color: Colors.white,
                    child: Center(
                      child: Text("حدث خطأ اثناء تحميل الصورة"),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        opacity: _backgroundOpacity,
                        image: widget.isFile
                            ? FileImage(File(
                                    '/' + widget.mainImagePath.split("//")[2]))
                                as ImageProvider<Object>
                            : CachedNetworkImageProvider(widget.mainImagePath,
                                errorListener: (stackTrace) {
                                setState(() {
                                  isError = true;
                                });
                              }),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      color: widget.more || widget.isFile
                          ? Colors.black.withOpacity(0.5)
                          : Colors.transparent,
                      child: widget.more
                          ? Center(
                              child: Text(
                                '+${widget.moreCount}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : widget.isFile
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : null,
                    ),
                  )),
      ),
    );
  }
}

void showImagePreview(BuildContext context, int index, List imagePaths,
    String heroTag, String mainImagePath) {
  bool showList = true;
  TransformationController transformationController =
      TransformationController();
  bool isZoomed = false;
  Get.to(StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      PageController pageController = PageController(initialPage: index);

      return GestureDetector(
        onTap: () {
          setState(() {
            showList = !showList;
          });
        },
        onVerticalDragUpdate: (details) {
          // Calculate the new opacity based on the drag position
          setState(() {
            double newOpacity =
                (0.5 + details.primaryDelta! / 100).clamp(0.0, 0.8);
          });

          // Dismiss the bottom sheet when swiped down
          if (details.primaryDelta! > 10) {
            if (isZoomed) {
              print("object");
              return;
            }
            Navigator.of(context).pop();
          }
        },
        onVerticalDragEnd: (details) {
          // Reset opacity to default after dragging ends
          setState(() {});
        },
        child: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: imagePaths.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Hero(
                        tag: '${heroTag}_$index', // Unique tag for each image
                        child: InteractiveViewer(
                          transformationController: transformationController,
                          minScale: 0.5,
                          maxScale: 4.0,
                          child: CachedNetworkImage(
                            width: Get.width,
                            errorWidget: (context, url, error) => Container(
                              height: Get.height * 0.3,
                              width: Get.width,
                              color: Colors.white,
                              child: Center(
                                child: Text("حدث خطأ اثناء تحميل الصورة"),
                              ),
                            ),
                            imageUrl: imagePaths[index],
                            fit: BoxFit.cover,
                          ),
                          onInteractionUpdate: (details) {
                            // Update `isZoomed` based on scale factor
                            setState(() {
                              double scale = transformationController.value
                                  .getMaxScaleOnAxis();
                              isZoomed = scale > 1.0;
                              // Handle the zoomed state here if needed
                            });
                          },
                        ),
                      ),
                    );
                  },
                  onPageChanged: (pageIndex) {
                    setState(() {
                      index = pageIndex;
                    });
                  },
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: showList ? 1.0 : 0.0,
                child: Container(
                  margin: EdgeInsets.all(Insets.medium),
                  color: Colors.black.withOpacity(0.7),
                  height: 100.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imagePaths.length,
                    itemBuilder: (BuildContext context, int thumbnailIndex) {
                      return GestureDetector(
                        onTap: () {
                          pageController.jumpToPage(thumbnailIndex);
                          setState(() {
                            index = thumbnailIndex;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: thumbnailIndex == index
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                          margin: EdgeInsets.all(4.0),
                          width: 80.0,
                          child: CachedNetworkImage(
                            errorWidget: (context, url, error) => Container(
                              color: Colors.white,
                              child: Center(
                                child: Text("حدث خطأ "),
                              ),
                            ),
                            imageUrl: imagePaths[thumbnailIndex],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ));
}
