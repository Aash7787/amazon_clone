import 'package:flutter/material.dart';

const uri = 'https://amazon-clone-t6dj.onrender.com'; //ip address is removed

const openAiUrl = 'https://openrouter.ai/api/v1/chat/completions';

const xToken = 'x-auth-token';

const apiKey =
    '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';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/imgs/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/imgs/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/imgs/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/imgs/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/imgs/fashion.jpeg',
    },
  ];
}