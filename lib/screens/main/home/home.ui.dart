import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopper/data/cache/app-images.dart';
import 'package:shopper/utils/widget_extensions.dart';
import 'package:shopper/widget/apptexts.dart';

import '../../../utils/shimmer_loaders.dart';
import '../../../widget/app-bar-widget.dart';
import '../../../widget/app-card.dart';
import '../../base-ui.dart';
import 'home.vm.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (m)=> m.init(),
      builder: (_, model, theme, child)=> Scaffold(
        appBar: const AppBars(
          text: "Product List",
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 16.sp, left: 16.sp, right: 16.sp),
          children: [
            Container(
              height: 232.sp,
              width: width(context),
              alignment: Alignment.centerLeft,
              padding: 30.sp.padA,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                image: const DecorationImage(
                  image: AssetImage(
                    AppImages.headset,
                  ),
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    "Premium Sound, \nPremium Savings",
                    color: Colors.white,
                    size: 20.sp,
                    weight: FontWeight.w600,
                  ),
                  5.sp.sbH,
                  AppText(
                    "Limited offer, hope on and get yours now",
                    color: Colors.white,
                    size: 12.sp,
                    weight: FontWeight.w500,
                  ),

                ],
              ),
            ),
            30.sp.sbH,
            AppText("Tech Gagdet", size: 20.sp, weight: FontWeight.w600),
            20.sp.sbH,
            SizedBox(
              height: 346.92.sp,
              width: width(context),
              child: PageView.builder(
                itemCount: model.chunkGagdetList.length,
                itemBuilder: (_, i){
                  List<Product> pageItems = model.chunkGagdetList[i];
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: pageItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.sp,
                        mainAxisSpacing: 8.sp,
                        childAspectRatio: 1.5, // Adjust the aspect ratio as needed
                        // Set the itemExtent to fix the height of each item
                        // You may need to adjust the value based on your design
                        mainAxisExtent: 346.92.sp,
                      ),
                      itemBuilder: (_,i){
                        return AppCard(
                          color: Theme.of(context).colorScheme.secondary,
                          padding: 0.0.padA,
                          margin: (i % 2) == 1
                              ? const EdgeInsets.only(
                              left: 5,bottom: 5)
                              : const EdgeInsets.only(
                              right: 5, bottom: 5
                          ),
                        );
                      }
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
