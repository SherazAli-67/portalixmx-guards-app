import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portalixmx_guards_app/res/app_constants.dart';
import 'package:portalixmx_guards_app/res/app_icons.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class ReportSummaryPage extends StatelessWidget{
  const ReportSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(
        paddingFromTop: 50,
        child: Column(
          spacing: 11,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,)),
                Text("Report Title", style: AppTextStyles.regularTextStyle,),
                const SizedBox(width: 40,)
              ],
            ),
            Expanded(
              child: Card(
                color: Colors.white,
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      Text("Sep 20, 10:00 AM", style: AppTextStyles.editProfileHeadingTextStyle,),
                      Text(AppConstants.dummyEventDescription, style: AppTextStyles.tileTitleTextStyle,),
                      Expanded(child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 20, crossAxisSpacing: 20),

                          itemCount: 6,
                          itemBuilder: (ctx, index){
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(imageUrl: AppIcons.icUserImageUrl, fit: BoxFit.cover,)
                            );
                          })),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

}