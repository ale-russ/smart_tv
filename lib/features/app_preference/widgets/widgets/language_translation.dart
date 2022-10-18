import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:get/get.dart';

class translate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': English,
        'ti_ER': tigrinya,
      };
}

const Map<String, String> English = {
  // Log In
  'Login': 'Login',
  'Email': 'Enter Email',
  'Please login to continue': 'Please login to continue',
  'Password': 'Enter Password',
  'Remember me': 'Remember me',
  'Home': 'Home',
  'Comming Soon': 'Comming Soon',
  'Search': 'Search',
  'Library': 'Library',
  'K': 'K',
  'abbee': 'abbee',
  '+': '+',
  'Play': 'Play',
  'Watch Trailer': 'Watch Trailer',
  'Watch Later': 'Watch Later',
  'Trending Movies': 'Trending Movies',
  'Top Rated Movies': 'Top Rated Movies',
  'Tv Shows': 'Tv Shows',
};

const Map<String, String> tigrinya = {
  // Log In Screen
  'Login': 'እቶ',
  'Please login to continue': '   ',
  'Email': 'ኢመይል ኣእቱ',
  'Enter password': 'ምልክት ቃል ኣእትዉ',
  'Password': 'ምልክት ቃል።',
  'Remember me': 'ዘክርኒ።',
  'Home': 'ቤት',
  'Comming Soon': 'ቀረባ ግዜ',
  'Search': 'ኣናዲ',
  'Library': 'ከብሒ',
  'K': 'ካ',
  'abbee': 'ቢ',
  '+': '',
  'Play': 'ርኣይ',
  'Watch Trailer': 'Watch Trailer',
  'Watch Later': 'Watch Later',
  'Trending Movies': 'Trending Movies',
  'Top Rated Movies': 'Top Rated Movies',
  'Tv Shows': 'Tv Shows',
  'Cast & Crew': 'ተዋሳእትን ክኢላታትን'
};
