import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libraryapp/screenTools/screenTools.dart';

class CustomCardSwiper extends ConsumerWidget {
  const CustomCardSwiper(
      {required this.swiperList,
      this.radius = 16,
      this.autoPlay = false,
      this.width,
      this.height,
      required this.isDataOffline,
      this.onTap,
      this.duration = 3000,
      this.pagination = true,
      this.viewPort = 1.0,
      this.scale = 1.0,
      super.key});

  final List<String> swiperList;
  final double radius;
  final bool autoPlay;
  final double? width;
  final double? height;
  final bool isDataOffline;
  final Function(int)? onTap;
  final int duration;
  final bool pagination;
  final double? viewPort;
  final double? scale;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width ?? screenWidth(context),
      height: height ?? screenHeight(context) * 0.1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Swiper(
            itemCount: swiperList.length,
            itemBuilder: (context, index) {
              var item = swiperList[index];
              return ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: isDataOffline
                      ? Image.asset(
                          item,
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          item,
                          fit: BoxFit.fill,
                        ));
            },
            duration: duration,
            autoplay: autoPlay,
            pagination: pagination ? const SwiperPagination() : null,
            viewportFraction: viewPort ?? 1.0,
            scale: scale ?? 1.0,
            autoplayDisableOnInteraction: true,
            onTap: onTap),
      ),
    );
  }
}
