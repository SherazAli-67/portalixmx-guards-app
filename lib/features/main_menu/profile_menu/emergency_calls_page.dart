import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class EmergencyCallsPage extends StatelessWidget {
  const EmergencyCallsPage({super.key});

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
                Text("Emergency Communication", style: AppTextStyles.regularTextStyle,),
                const SizedBox(width: 40,)
              ],
            ),
            Expanded(
              child: Card(
                color: AppColors.lightGreyBackgroundColor,
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (ctx, index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Material(
                            color: AppColors.greyColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              leading: CircleAvatar(
                                backgroundColor: AppColors.btnColor,
                                child: Center(child: Icon(Icons.person, color: Colors.white,),),
                              ),
                              tileColor: Colors.white,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Police", style: AppTextStyles.tileTitleTextStyle,),
                                  Text("+111", style: AppTextStyles.tileSubtitleTextStyle,)
                                ],
                              ),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.primaryColor,
                                child: Center(
                                  child: Icon(Icons.call, color: Colors.white,),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ));
  }

}