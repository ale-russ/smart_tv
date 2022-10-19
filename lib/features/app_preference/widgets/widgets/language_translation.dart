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
  'loout': 'Logout',
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
  'history': 'History',
  'see_all': 'See All',

  'first_name': 'Fist Name',
  'last_name': 'Last Name',
  'sex': 'Sex',
  'country': 'country',
  'date_of_bith': 'Date of Birth',
  'user_not_found': 'Sorry user not found. Please try again',
};

const Map<String, String> tigrinya = {
  // Log In Screen
  'Login': 'እቶዉ',
  'Please login to continue': 'ብኽብረትኩም ንምቕጻል እተዉ',
  'Email': 'ኢመይል ኣእትዉ',
  'Enter password': 'ናይ ምስጢር ቃል ኣእትዉ',
  'Password': 'ምስጢር ቃል',
  'Remember me': 'ዘክርኒ',
  'Home': 'ቤት',
  'Comming Soon': 'ቀረባ ግዜ',
  'Search': 'ኣናድዩ',
  'Library': 'ከብሒ',
  'K': 'ካ',
  'abbee': 'ቢ',
  '+': '+',

  'Play': 'ርኣዩ',
  'Watch Trailer': 'ዝርአ መቃልዒ',
  'Watch Later': 'ዝርአ ደሓር',
  'Trending Movies': 'ህሉው ፊልምታት',
  'Top Rated Movies': 'Top Rated Movies',
  'Tv Shows': 'ተኸታታሊ ፊልምታት',
  'Cast & Crew': 'ተዋሳእትን ክኢላታትን',
  'history': 'ዝተራአዩ ፊልምታት',
  'see_all': 'ኩሉ ርአዩ',

  'first_name': 'ስም',
  'last_name': 'ስም ኣቦ',
  'sex': 'ጾታ',
  'country': 'ሃገር',
  'date_of_bith': 'ዕለተ ልደት',
  'user_not_found': 'ይቕረታ፣ ዓሚል አይተረኽበን። ብኽብረትኩም ደጊምኩም ፈትኑ',
};
