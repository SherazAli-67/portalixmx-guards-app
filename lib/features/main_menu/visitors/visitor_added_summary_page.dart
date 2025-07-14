import 'package:flutter/material.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/vistor_info_item_widget.dart';
import '../../../app_data/app_data.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class VisitorAddedSummaryPage extends StatelessWidget{
  const VisitorAddedSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(child: Column(
        spacing: 20,
        children: [
          Padding(padding: EdgeInsets.only(top: 65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.white,),
                Column(
                  children: [
                    Text("Name", style: AppTextStyles.regularTextStyle,),
                    Text("Visitor TYpe", style: AppTextStyles.tileSubtitleTextStyle,)
                  ],
                ),
                const SizedBox(width: 40,),
              ],
            ),
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
                child: _buildRegularVisitorWidget(),
              ),
            ),
          )
        ],
      ),);
  }

 /* Widget _buildGuestWidget() {
    return Column(
      children: [
        Row(
          spacing: 20,
          children: [
            Expanded(
              child: VisitorInfoItemWidget(
                  title: 'NAME', subTitle: 'User Name', showDivider: true),
            ),
            Expanded(
                child: VisitorInfoItemWidget(title: 'CONTACT',
                    subTitle: '+92 307 2215500',
                    showDivider: true)
            ),
          ],
        ),

        Row(
          spacing: 20,
          children: [
            Expanded(
              child: VisitorInfoItemWidget(
                title: 'DATE', subTitle: 'Sep 20, 2024',),
            ),
            Expanded(
                child: VisitorInfoItemWidget(
                  title: 'TIME', subTitle: '10:00AM - 06:00PM',)
            ),
          ],
        ),
        const Spacer(),
        Text("QR CODE", style: AppTextStyles.visitorDetailTitleTextStyle,),
        Image.asset(AppIcons.icQRCode),
        const Spacer(),
        Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 40),
          width: double.infinity,
          child: PrimaryBtn(
            onTap: () {}, btnText: "Share Key", color: AppColors.primaryColor,),
        )
      ],
    );
  }*/

  Widget _buildRegularVisitorWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            spacing: 20,
            children: [
              Expanded(
                child: VisitorInfoItemWidget(
                    title: 'REQUESTED TIME', subTitle: 'Sep 20, 2024', showDivider: true),
              ),
              Expanded(
                  child: VisitorInfoItemWidget(title: 'ACCESS FOR',
                      subTitle: 'Teacher',
                      showDivider: true)
              ),
            ],
          ),
      
          Row(
            spacing: 20,
            children: [
              Expanded(
                child: VisitorInfoItemWidget(
                  title: 'ACCESS APPROVED DATE', subTitle: 'Sep 20, 2024',),
              ),
              Expanded(
                  child: VisitorInfoItemWidget(
                    title: 'CONTACT NO', subTitle: '+91 12345678',)
              ),
            ],
          ),
      
          Column(
              children: List.generate(7, (index){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppData.days[index], style: AppTextStyles.visitorDetailTitleTextStyle,),
                          Text("10:00AM - 06:00PM", style: AppTextStyles.visitorDetailSubtitleTextStyle,)
                        ],
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: AppColors.dividerColor,
                      ),
                    ],
                  ),
                );
              })
          ),
        ],
      ),
    );
  }

}