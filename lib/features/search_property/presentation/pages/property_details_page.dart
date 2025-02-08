import 'dart:ui';

import 'package:emtelek/core/extensions/alignment_extension.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/shared/common_pages/image_viewer_page.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailsPage extends StatefulWidget {
  const PropertyDetailsPage({super.key});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  int currentPage = 0;
  final int totalImages = 8;
  bool isExpanded = false;
  bool showAll = false;
  int totalFeatures = 11; // العدد الإجمالي للميزات (11 ميزة في هذه الحالة)
  List<String> features =
      List.generate(11, (index) => 'ميزة ${index + 1}'); // بيانات الميزات
  Key mapKey = UniqueKey();
  LatLng latLng = const LatLng(33.510414, 36.278336);
  final ScrollController _scrollController = ScrollController();
  bool showAppBar = false;
  double scrollThreshold = 100.0; // تحديد مقدار التمرير المطلوب

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      // حساب النسبة المئوية للتمرير
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;

      // حساب النسبة المئوية
      double scrollPercentage = currentScroll / maxScroll;

      // طباعة النسبة المئوية للتمرير
      if (scrollPercentage > 0.3) {
        setState(() {
          showAppBar = true;
        });
      } else if (scrollPercentage < 0.3) {
        setState(() {
          showAppBar = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose(); // لا تنسى التخلص من المراقب بعد الانتهاء
  }

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    // Alignment alignment =
    //     getIt<CacheHelper>().getDataString(key: 'Lang') == 'ar'
    //         ? Alignment.centerRight
    //         : Alignment.centerLeft;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller:
                      _scrollController, // ربط المراقب بـ SingleChildScrollView
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              pageTransition(context,
                                  page: const ImageGalleryPage());
                            },
                            child: SizedBox(
                              height: context.height * 0.34,
                              child: ImageSlideshow(
                                indicatorColor: AppColors.primary,
                                onPageChanged: (value) {
                                  setState(() {
                                    currentPage = value;
                                  });
                                },
                                children: [
                                  Image.asset(
                                    'assets/images/example.png',
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    'assets/images/example1.webp',
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    'assets/images/example2.webp',
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    'assets/images/example3.webp',
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    'assets/images/example.png',
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    'assets/images/example1.webp',
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    'assets/images/example2.webp',
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    'assets/images/example3.webp',
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: settingsCubit.locale == 'ar' ? 16 : null,
                            left: settingsCubit.locale == 'ar' ? null : 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.image,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  6.toWidth,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: TextWidget(
                                      text: '${currentPage + 1} / $totalImages',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -16,
                            right: settingsCubit.locale == 'ar' ? null : 16,
                            left: settingsCubit.locale == 'ar' ? 16 : null,
                            child: Row(
                              children: [
                                ButtonWidget(
                                  borderRadius: 18,
                                  showElevation: true,
                                  height: 0,
                                  width: 0,
                                  onTap: () {},
                                  color: Colors.white,
                                  child: const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.favorite_border,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                16.toWidth,
                                ButtonWidget(
                                  borderRadius: 18,
                                  showElevation: true,
                                  height: 0,
                                  width: 0,
                                  onTap: () {},
                                  color: Colors.white,
                                  child: const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.share_rounded,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 42,
                            right: settingsCubit.locale == 'ar' ? 6 : null,
                            left: settingsCubit.locale == 'ar' ? null : 6,
                            child: ButtonWidget(
                              borderRadius: 18,
                              showElevation: true,
                              height: 0,
                              width: 0,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                  child: Image.asset(
                                    'assets/icons/rightArrow.png',
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.height * 0.03),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Align(
                              alignment: context.textAlignment,
                              child: Row(
                                children: [
                                  const TextWidget(
                                    isHaveOverflow: true,
                                    text: '28,600,278',
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  6.toWidth,
                                  const TextWidget(
                                    isHaveOverflow: true,
                                    text: 'ل.س',
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            6.toHeight,
                            Align(
                              alignment: context.textAlignment,
                              child: const TextWidget(
                                isHaveOverflow: true,
                                text: 'منزل مستقل 4 غرف وصالة',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            4.toHeight,
                            Align(
                              alignment: context.textAlignment,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/bed.png',
                                    height: 20,
                                    width: 20,
                                    color: Colors.black,
                                  ),
                                  6.toWidth,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: TextWidget(
                                      isHaveOverflow: true,
                                      text: '4 ${S.of(context).Bathroom}',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  12.toWidth,
                                  Image.asset(
                                    'assets/icons/bath.png',
                                    height: 20,
                                    width: 20,
                                    color: Colors.black,
                                  ),
                                  6.toWidth,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: TextWidget(
                                      isHaveOverflow: true,
                                      text: '4 ${S.of(context).Bathroom}',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  12.toWidth,
                                  Image.asset(
                                    'assets/icons/ruler.png',
                                    height: 20,
                                    width: 20,
                                    color: Colors.black,
                                  ),
                                  6.toWidth,
                                  const Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: TextWidget(
                                      isHaveOverflow: true,
                                      text: '224 متر مربع',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ), //حي أبو رمانة - شارع الجلاء
                            ),
                            8.toHeight,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Colors.black,
                                ),
                                Expanded(
                                  child: TextWidget(
                                    textAlign: TextAlign.right,
                                    text:
                                        'شارع الجلاء ,حي أبو رمانة ,منطقة الصالحية ,مدينة دمشق',
                                    fontSize: 14,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            8.toHeight,
                            const Divider(),
                            8.toHeight,
                            Table(
                              columnWidths: {
                                0: FixedColumnWidth(
                                    context.width * 0.47), // عرض العمود الأول
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'نوع:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'شقة', // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text:
                                              'الغرض من الاعلان:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'الايجار', // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text:
                                              'مفروشة/غير مفروشة:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'مفروشة', // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'صاعب الاعلان:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'مالك', // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'صافي المساحة:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: '193 متر مربع', // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'رقم الطابق:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: '3', // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'عدد الشرف:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: '1', // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'اسم البناء:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'بناء 1', // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'تاريخ النشر:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: '22/01/2025', // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                alignment: context
                                    .textAlignment, // محاذاة النص إلى اليسار
                                child: const TextWidget(
                                  text: 'وصف الاعلان:', // totalPrice!,
                                  fontSize: 16,
                                  //  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            TextWidget(
                              maxLines: isExpanded
                                  ? null
                                  : 3, // عرض النص كاملاً إذا كان موسعاً
                              textAlign: TextAlign.justify,
                              text:
                                  'شقة فاخرة تقع في قلب المدينة، تتميز بإطلالات بانورامية خلابة على الأفق. تضم ثلاث غرف نوم واسعة، وصالة مشرقة مع نوافذ كبيرة تسمح بدخول الضوء الطبيعي. المطبخ مصمم بأحدث الأجهزة والتشطيبات العصرية. تحتوي الشقة أيضًا على حمامين أنيقين مجهزين بالكامل. توفر مجمع سكني آمن مع خدمات مميزة مثل حوض سباحة، نادي رياضي، ومواقف خاصة للسيارات. تقع بالقرب من المدارس، المتاجر، والمرافق العامة، مما يجعلها مثالية للعائلات. فرصة استثمارية رائعة لمحبي الفخامة والراحة.',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            8.toHeight,
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isExpanded =
                                          !isExpanded; // تغيير حالة النص عند الضغط
                                    });
                                  },
                                  child: TextWidget(
                                    text:
                                        isExpanded ? 'عرض أقل' : 'قراءة المزيد',
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            8.toHeight,
                            const Divider(),
                            8.toHeight,
                            Align(
                              alignment: context.textAlignment,
                              child: const TextWidget(
                                isHaveOverflow: true,
                                text: 'مزايا العقار',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.toHeight,
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics:
                                  const NeverScrollableScrollPhysics(), // إيقاف التمرير
                              itemCount: showAll || totalFeatures <= 8
                                  ? totalFeatures // عرض جميع الميزات إذا كانت أقل من 8 أو تم الضغط على زر "عرض المزيد"
                                  : 9, // عرض 8 ميزات مع زر "عرض المزيد" في النهاية
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.1,
                              ),
                              itemBuilder: (context, index) {
                                if (index < 8 && index < totalFeatures) {
                                  // عرض الميزات فقط إذا كانت موجودة
                                  return ButtonWidget(
                                    color: Colors.grey[200]!,
                                    height: 0,
                                    width: 0,
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.ac_unit_outlined,
                                        ),
                                        8.toHeight,
                                        TextWidget(
                                          text: features[
                                              index], // عرض الميزات من البيانات
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (index == 8 && !showAll) {
                                  // زر "عرض المزيد" عند الـ index == 8
                                  int remainingFeatures = totalFeatures - 8;
                                  return ButtonWidget(
                                    onTap: () {
                                      setState(() {
                                        showAll =
                                            !showAll; // تغيير حالة العرض عند الضغط على زر "عرض المزيد"
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.more_horiz,
                                        ),
                                        8.toHeight,
                                        TextWidget(
                                          text:
                                              '+$remainingFeatures مزايا إضافية',
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (index >= 8 && showAll) {
                                  // عرض الميزات المتبقية مع زر "عرض أقل"
                                  return ButtonWidget(
                                    color: Colors.grey[200]!,
                                    height: 0,
                                    width: 0,
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.ac_unit_outlined,
                                        ),
                                        8.toHeight,
                                        TextWidget(
                                          text: features[
                                              index], // عرض الميزات المتبقية من نفس البيانات
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return null;
                              },
                            ),
                            8.toHeight,
                            const Divider(),
                            8.toHeight,
                            Align(
                              alignment: context.textAlignment,
                              child: const TextWidget(
                                isHaveOverflow: true,
                                text: 'عرض الخريطة',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.toHeight,
                            Align(
                              alignment: context.textAlignment,
                              child: const TextWidget(
                                // maxLines: 5,
                                textAlign: TextAlign.right,
                                text:
                                    'شارع الجلاء ,حي أبو رمانة ,منطقة الصالحية ,مدينة دمشق',
                                fontSize: 14,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.toHeight,
                            ButtonWidget(
                              height: 0.2,
                              width: 1,
                              onTap: () {},
                              child: FlutterMap(
                                key: mapKey,
                                options: MapOptions(
                                  initialCenter: latLng,
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    userAgentPackageName: 'com.example.app',
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        point: latLng,
                                        child: const Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        rotate: true,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            8.toHeight,
                            ButtonWidget(
                              color: AppColors.primary,
                              height: 0.05,
                              width: 1,
                              onTap: () async {
                                //  void openMaps(LatLng location) async {
                                // تحويل النص إلى Uri
                                final Uri url = Uri.parse(
                                    'https://www.google.com/maps?q=${33.510414},${36.278336}');

                                // التحقق من إمكانية فتح الرابط باستخدام canLaunchUrl
                                if (await canLaunchUrl(url)) {
                                  // فتح الرابط باستخدام launchUrl
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  throw 'Could not open maps: $url';
                                }
                                // }
                              },
                              text: 'عرض الخريطة',
                            ),
                            4.toHeight,
                            const Divider(),
                            8.toHeight,
                            Align(
                              alignment: context.textAlignment,
                              child: const TextWidget(
                                isHaveOverflow: true,
                                text: 'معلومات صاحب الاعلان',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            12.toHeight,
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/user.png',
                                    width: 80,
                                    height: 80,
                                  ),
                                  8.toHeight,
                                  const TextWidget(
                                    text: 'احمد عبد الرحيم',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  4.toHeight,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const TextWidget(
                                        text: 'عرض جميع العقارات',
                                        fontSize: 14,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      4.toWidth,
                                      const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            8.toHeight,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ButtonWidget(
                boxShadowOpacity: 0.7,
                borderRadius: 0,
                color: Colors.white,
                height: 0.07,
                width: 1,
                showElevation: true,
                onTap: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        borderRadius: 4,
                        onTap: () {},
                        height: 0.05,
                        width: 0.3,
                        color: const Color(0XDD64b5f6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            8.toWidth,
                            const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: TextWidget(
                                text: 'ايميل',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ButtonWidget(
                        borderRadius: 4,
                        onTap: () {},
                        height: 0.05,
                        width: 0.3,
                        color: const Color(0XDDe57373),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.phone_outlined,
                              color: Colors.white,
                            ),
                            8.toWidth,
                            const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: TextWidget(
                                text: 'اتصال',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ButtonWidget(
                        borderRadius: 4,
                        onTap: () {},
                        height: 0.05,
                        width: 0.3,
                        color: const Color(0XFFa5d6a7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/whatsapp.png',
                              height: 20,
                              width: 20,
                              color: Colors.white,
                            ),
                            8.toWidth,
                            const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: TextWidget(
                                text: 'واتساب',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          showAppBar == false
              ? const SizedBox()
              : Positioned(
                  top: 0,
                  child: ButtonWidget(
                    boxShadowOpacity: 0.1,
                    borderRadius: 0,
                    color: Colors.white,
                    height: 0.125,
                    width: 1,
                    showElevation: true,
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 16.0,
                          right: 16,
                          top: context.height * 0.06,
                          bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              8.toWidth,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const TextWidget(
                                        isHaveOverflow: true,
                                        text: '28,600,278',
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      6.toWidth,
                                      const TextWidget(
                                        isHaveOverflow: true,
                                        text: 'ل.س',
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  2.toHeight,
                                  Row(
                                    children: [
                                      const TextWidget(
                                        isHaveOverflow: true,
                                        text: '4 غرف',
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      6.toWidth,
                                      const TextWidget(
                                        isHaveOverflow: true,
                                        text: '2 الحمامات',
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      6.toWidth,
                                      const TextWidget(
                                        isHaveOverflow: true,
                                        text: '224 متر مربع',
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ButtonWidget(
                            borderRadius: 18,
                            showElevation: true,
                            height: 0,
                            width: 0,
                            onTap: () {},
                            color: Colors.white,
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.share_rounded,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
