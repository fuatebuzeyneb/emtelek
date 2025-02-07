import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/add_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/shared/common_pages/select_location.dart';

import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdDetailsPage extends StatelessWidget {
  const AddAdDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);
    final rentCategories = {
      7: S.of(context).Room,
      8: S.of(context).Apartment,
      9: S.of(context).Shop,
      10: S.of(context).Building,
      11: S.of(context).Land,
      12: S.of(context).Villa,
      13: S.of(context).Factory,
      22: S.of(context).Office,
    };

    final saleCategories = {
      14: S.of(context).Apartment,
      15: S.of(context).Shop,
      16: S.of(context).Building,
      17: S.of(context).Land,
      18: S.of(context).Villa,
      19: S.of(context).Factory,
      23: S.of(context).Office,
    };

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 2,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: const Icon(Icons.arrow_back_ios),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: TextWidget(
                text: 'أضف اعلانك',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.appBarBackground,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: context.height * 0.03),
                Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info,
                              color: Colors.black54,
                              size: context.width * 0.06),
                          8.toWidth,
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontFamily: 'Tajawal'),
                                children: [
                                  TextSpan(
                                    text:
                                        "${S.of(context).AdReviewMessage}\n\n",
                                  ),
                                  TextSpan(
                                    text: S.of(context).AdInfoNote,
                                  ),
                                  TextSpan(
                                    text:
                                        "${S.of(context).AdRejectionReason} \n\n",
                                  ),
                                  TextSpan(
                                    text: S.of(context).QuestionsPrompt,
                                  ),
                                  TextSpan(
                                    text: S.of(context).PublishingGuidelines,
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration
                                            .underline), // رابط مرجعي
                                  ),
                                  TextSpan(
                                    text: S.of(context).DirectContactMessage,
                                  ),
                                  TextSpan(
                                    text: S.of(context).WhatsAppContact,
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration
                                            .underline), // رابط مرجعي
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                12.toHeight,
                TextWidget(
                  text: S.of(context).EnterAdDetails,
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                12.toHeight,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            text: rentCategories.containsKey(
                                    propertyAddAdCubit.categoryForAdType)
                                ? '${S.of(context).PropertyForRent} --> ${rentCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForRent}'
                                : '${S.of(context).PropertyForSale} --> ${saleCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForSale}',
                            fontSize: 14,
                            color: Colors.black,
                            // fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      12.toHeight,
                      TextFieldWidget(
                        paddingVertical: 0,
                        hint: S.of(context).AdTitleHint,
                        onChanged: (value) {
                          propertyAddAdCubit.setPropertyField(
                              'adModelTitle', value);
                        },
                      ),
                      12.toHeight,
                      ButtonWidget(
                        onTap: () {},
                        height: 0.06,
                        width: 1,
                        color: Colors.white,
                        borderColor: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // توسيط الأيقونة والنص رأسياً
                          children: [
                            const Icon(
                              Icons.camera,
                              color: Colors.black38,
                              size: 26,
                            ),
                            const SizedBox(width: 8),
                            Baseline(
                              baseline: 20.0,
                              baselineType: TextBaseline.alphabetic,
                              child: TextWidget(
                                text: S.of(context).AddPhotos,
                                fontSize: 16,
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      12.toHeight,
                      TextFieldWidget(
                        paddingVertical: 0,
                        hint: S.of(context).PhoneNumber,
                        onChanged: (value) {
                          propertyAddAdCubit.setPropertyField(
                              'adModelPhone', value);
                        },
                      ),
                      12.toHeight,
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextFieldWidget(
                              paddingVertical: 0,
                              hint: S.of(context).Price,
                              onChanged: (value) {
                                propertyAddAdCubit.setPropertyField(
                                    'adModelPrice', value);
                              },
                              suffixWidget: Padding(
                                padding:
                                    EdgeInsets.only(top: context.height * 0.02),
                                child: const TextWidget(
                                  text: 'USD',
                                  fontSize: 16,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: ButtonWidget(
                              onTap: () {},
                              height: 0.059,
                              color: Colors.black,
                              borderColor: Colors.black,
                              text: "USD",
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      12.toHeight,
                      TextFieldWidget(
                        paddingVertical: 0,
                        hint: S.of(context).TotalArea,
                        onChanged: (value) {
                          propertyAddAdCubit.setPropertyField(
                              'totalArea', value);
                        },
                        suffixWidget: Padding(
                          padding: EdgeInsets.only(
                              top: context.height * 0.016, left: 8),
                          child: const TextWidget(
                            text: ' متر مربع',
                            fontSize: 16,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      12.toHeight,
                      TextFieldWidget(
                        paddingVertical: 0,
                        onChanged: (value) {
                          propertyAddAdCubit.setPropertyField(
                              'netOrBuildingArea', value);
                        },
                        hint: [10, 13, 16, 19]
                                .contains(propertyAddAdCubit.categoryForAdType)
                            ? S.of(context).BuildingAreaOptional
                            : S.of(context).NetAreaOptional,
                        suffixWidget: Padding(
                          padding: EdgeInsets.only(
                              top: context.height * 0.016, left: 8),
                          child: const TextWidget(
                            text: 'متر مربع',
                            fontSize: 16,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      12.toHeight,
                      TextFieldWidget(
                        paddingVertical: 8,
                        maxLines: 8,
                        hint: S.of(context).AdDescriptionOptional,
                        onChanged: (value) {
                          propertyAddAdCubit.setPropertyField(
                              'adModelDescription', value);
                        },
                      ),
                      Visibility(
                        visible: ![11, 17, 7]
                            .contains(propertyAddAdCubit.categoryForAdType),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: ButtonWidget(
                            onTap: () {},
                            height: 0.06,
                            width: 1,
                            color: Colors.white,
                            borderColor: Colors.grey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: S.of(context).NumberOfRooms,
                                    fontSize: 16,
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: ![11, 17, 7]
                            .contains(propertyAddAdCubit.categoryForAdType),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: ButtonWidget(
                            onTap: () {},
                            height: 0.06,
                            width: 1,
                            color: Colors.white,
                            borderColor: Colors.grey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: S.of(context).NumberOfBathrooms,
                                    fontSize: 16,
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: ![
                          11,
                          17,
                        ].contains(propertyAddAdCubit.categoryForAdType),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: ButtonWidget(
                            onTap: () {},
                            height: 0.06,
                            width: 1,
                            color: Colors.white,
                            borderColor: Colors.grey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: S.of(context).FloorNumberOptional,
                                    fontSize: 16,
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: ![11, 17, 9, 15]
                            .contains(propertyAddAdCubit.categoryForAdType),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: ButtonWidget(
                            onTap: () {},
                            height: 0.06,
                            width: 1,
                            color: Colors.white,
                            borderColor: Colors.grey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text:
                                        S.of(context).NumberOfBalconiesOptional,
                                    fontSize: 16,
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: ![11, 17, 7]
                            .contains(propertyAddAdCubit.categoryForAdType),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: ButtonWidget(
                            onTap: () {},
                            height: 0.06,
                            width: 1,
                            color: Colors.white,
                            borderColor: Colors.grey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text:
                                        S.of(context).ConstructionDateOptional,
                                    fontSize: 16,
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: ![11, 17, 9, 15, 10, 16, 13, 19]
                            .contains(propertyAddAdCubit.categoryForAdType),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: ButtonWidget(
                            onTap: () {},
                            height: 0.06,
                            width: 1,
                            color: Colors.white,
                            borderColor: Colors.grey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: S.of(context).FurnishedOptional,
                                    fontSize: 16,
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      12.toHeight,
                      ButtonWidget(
                        onTap: () {},
                        height: 0.06,
                        width: 1,
                        color: Colors.white,
                        borderColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              TextWidget(
                                text: S.of(context).PropertyOwner,
                                fontSize: 16,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                      ),
                      12.toHeight,
                      ButtonWidget(
                        onTap: () {},
                        height: 0.06,
                        width: 1,
                        color: Colors.white,
                        borderColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              TextWidget(
                                text: S.of(context).City,
                                fontSize: 16,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                      ),
                      12.toHeight,
                      ButtonWidget(
                        onTap: () {},
                        height: 0.06,
                        width: 1,
                        color: Colors.white,
                        borderColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              TextWidget(
                                text: S.of(context).Region,
                                fontSize: 16,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                      ),
                      12.toHeight,
                      TextFieldWidget(
                        paddingVertical: 8,
                        maxLines: 2,
                        hint: S.of(context).NeighborhoodAndStreetOptional,
                        onChanged: (value) {
                          propertyAddAdCubit.setPropertyField(
                              'adModelAddress', value);
                        },
                      ),
                      Visibility(
                        visible: ![11, 17, 13, 19]
                            .contains(propertyAddAdCubit.categoryForAdType),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: TextFieldWidget(
                            onChanged: (value) {
                              propertyAddAdCubit.setPropertyField(
                                  'complexName', value);
                            },
                            paddingVertical: 8,
                            maxLines: 1,
                            hint: S.of(context).BuildingOrComplexNameOptional,
                          ),
                        ),
                      ),
                      8.toHeight,
                      ButtonWidget(
                        height: 0.15,
                        width: 1,
                        colorText: Colors.black45,
                        ////  color: Colors.redAccent,
                        borderColor: Colors.grey,
                        text: 'اختر الموقع على الخريطة',
                        onTap: () {
                          pageTransition(context, page: const SelectLocation());
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
              onTap: () {
                propertyAddAdCubit.submitProperty();
              },
              text: S.of(context).Apply,
              height: 0.06,
              width: 1,
              color: Colors.red,
              fontSize: 18,
              colorText: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
