import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rent_now/core/common/widgets/custom_button.dart';
import 'package:rent_now/core/const/colors.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';

bool isLoadingcam = false;

void camAndFile(
    {required BuildContext context,
    required Function galleryOnTap,
    required Function cameraOnTap}) {
  isLoadingcam = true;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        // ignore: deprecated_member_use
        child: WillPopScope(
            child: Container(
              alignment: Alignment.center,
              height: getDeviceHeight(context) * 0.25,
              width: getDeviceWidth(context) * 0.85,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: getDeviceHeight(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.close,
                            color: Colors.transparent,
                            size: 30,
                          ),
                          Text(
                            'Upload Image',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    getFontSize(20, getDeviceWidth(context))),
                          ),
                          InkWell(
                              onTap: () {
                                hideCamAndFile(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.close,
                                  color: AppColors.primaryColor,
                                  size: 30,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: getDeviceHeight(context) * 0.02,
                      ),
                      SizedBox(
                        width: getDeviceWidth(context) * 0.63,
                        child: CustomElevatedBtn(
                          text: 'Scan Document',
                          fontSize: 12.5,
                          onPressed: () {
                            hideCamAndFile(context);
                            cameraOnTap();
                          },
                          bgColor: AppColors.whiteColor,
                          borderColor: AppColors.primaryColor,
                          textColor: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: getDeviceHeight(context) * 0.01),
                      SizedBox(
                        width: getDeviceWidth(context) * 0.63,
                        child: CustomElevatedBtn(
                          fontSize: 12.5,
                          text: 'Choose from Documents',
                          onPressed: () {
                            hideCamAndFile(context);
                            galleryOnTap();
                          },
                          bgColor: AppColors.primaryColor,
                          borderColor: AppColors.primaryColor,
                          textColor: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(
                        height: getDeviceHeight(context) * 0.03,
                      ),
                    ],
                  )
                ],
              ),
            ),
            onWillPop: () async {
              return false;
            }),
      );
    },
  );

  // return file;
}

void hideCamAndFile(BuildContext context) {
  if (isLoadingcam) {
    Navigator.of(context).pop();
    isLoadingcam = false;
  }
}
