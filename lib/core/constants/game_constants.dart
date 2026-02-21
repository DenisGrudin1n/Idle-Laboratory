import 'package:idle_laboratory/core/utils/big_number.dart';

class GameConstants {
  GameConstants._();

  // Energy generation
  static final BigNumber initialEnergy = BigNumber.zero();

  // Instead of using a huge double, we define mantissa and exponent directly
  // Example: mantissa=1.0, exponent=90 means 1.0 × 10^90
  static final BigNumber startingEnergyPerSecond = BigNumber(1.0, 0);

  // Update intervals
  static const int energyUpdateIntervalMs = 100; // Update 10 times per second

  // Suffixes list for visual representation of big numbers
  static const List<String> suffixes = <String>[
    '', // 10^0
    'K', // 10^3    Thousand
    'M', // 10^6    Million
    'B', // 10^9    Billion
    'T', // 10^12   Trillion
    'Qa', // 10^15   Quadrillion
    'Qi', // 10^18   Quintillion
    'Sx', // 10^21   Sextillion
    'Sp', // 10^24   Septillion
    'Oc', // 10^27   Octillion
    'No', // 10^30   Nonillion
    'Dc', // 10^33   Decillion
    'Ud', // 10^36   Undecillion
    'Dd', // 10^39   Duodecillion
    'Td', // 10^42   Tredecillion
    'Qad', // 10^45   Quattuordecillion
    'Qid', // 10^48   Quindecillion
    'Sxd', // 10^51   Sexdecillion
    'Spd', // 10^54   Septendecillion
    'Ocd', // 10^57   Octodecillion
    'Nod', // 10^60   Novemdecillion
    'Vg', // 10^63   Vigintillion
    'Uvg', // 10^66   Unvigintillion
    'Dvg', // 10^69   Duovigintillion
    'Tvg', // 10^72   Trevigintillion
    'Qavg', // 10^75   Quattuorvigintillion
    'Qivg', // 10^78   Quinvigintillion
    'Sxvg', // 10^81   Sexvigintillion
    'Spvg', // 10^84   Septenvigintillion
    'Ocvg', // 10^87   Octovigintillion
    'Novg', // 10^90   Novemvigintillion
    'Tg', // 10^93   Trigintillion
    'Utg', // 10^96   Untrigintillion
    'Dtg', // 10^99   Duotrigintillion
    'Ttg', // 10^102  Tretrigintillion
    'Qatg', // 10^105  Quattuortrigintillion
    'Qitg', // 10^108  Quintrigintillion
    'Sxtg', // 10^111  Sextrigintillion
    'Sptg', // 10^114  Septentrigintillion
    'Octg', // 10^117  Octotrigintillion
    'Notg', // 10^120  Novemtrigintillion
    'Qg', // 10^123  Quadragintillion
    'Uqg', // 10^126  Unquadragintillion
    'Dqg', // 10^129  Duoquadragintillion
    'Tqg', // 10^132  Trequadragintillion
    'Qaqg', // 10^135  Quattuorquadragintillion
    'Qiqg', // 10^138  Quinquadragintillion
    'Sxqg', // 10^141  Sexquadragintillion
    'Spqg', // 10^144  Septenquadragintillion
    'Ocqg', // 10^147  Octoquadragintillion
    'Noqg', // 10^150  Novemquadragintillion
    'Qq', // 10^153  Quinquagintillion
    'Uqq', // 10^156  Unquinquagintillion
    'Dqq', // 10^159  Duoquinquagintillion
    'Tqq', // 10^162  Trequinquagintillion
    'Qaqq', // 10^165  Quattuorquinquagintillion
    'Qiqq', // 10^168  Quinquinquagintillion
    'Sxqq', // 10^171  Sexquinquagintillion
    'Spqq', // 10^174  Septenquinquagintillion
    'Ocqq', // 10^177  Octoquinquagintillion
    'Noqq', // 10^180  Novemquinquagintillion
    'Sg', // 10^183  Sexagintillion
    'Usg', // 10^186  Unsexagintillion
    'Dsg', // 10^189  Duosexagintillion
    'Tsg', // 10^192  Tresexagintillion
    'Qasg', // 10^195  Quattuorsexagintillion
    'Qisg', // 10^198  Quinsexagintillion
    'Sxsg', // 10^201  Sexsexagintillion
    'Spsg', // 10^204  Septensexagintillion
    'Ocsg', // 10^207  Octosexagintillion
    'Nosg', // 10^210  Novemsexagintillion
    'Stg', // 10^213  Septuagintillion
    'Ustg', // 10^216  Unseptuagintillion
    'Dstg', // 10^219  Duoseptuagintillion
    'Tstg', // 10^222  Treseptuagintillion
    'Qastg', // 10^225  Quattuorseptuagintillion
    'Qistg', // 10^228  Quinseptuagintillion
    'Sxstg', // 10^231  Sexseptuagintillion
    'Spstg', // 10^234  Septenseptuagintillion
    'Ocstg', // 10^237  Octoseptuagintillion
    'Nostg', // 10^240  Novemseptuagintillion
    'Og', // 10^243  Octogintillion
    'Uog', // 10^246  Unoctogintillion
    'Dog', // 10^249  Duooctogintillion
    'Tog', // 10^252  Treoctogintillion
    'Qaog', // 10^255  Quattuoroctogintillion
    'Qiog', // 10^258  Quinoctogintillion
    'Sxog', // 10^261  Sexoctogintillion
    'Spog', // 10^264  Septenoctogintillion
    'Ocog', // 10^267  Octooctogintillion
    'Noog', // 10^270  Novemoctogintillion
    'Ng', // 10^273  Nonagintillion
    'Ung', // 10^276  Unnonagintillion
    'Dng', // 10^279  Duononagintillion
    'Tng', // 10^282  Trenonagintillion
    'Qang', // 10^285  Quattuornonagintillion
    'Qing', // 10^288  Quinnonagintillion
    'Sxng', // 10^291  Sexnonagintillion
    'Spng', // 10^294  Septennonagintillion
    'Ocng', // 10^297  Octononagintillion
    'Nong', // 10^300  Novemnonagintillion
    'Ce', // 10^303  Centillion
  ];
}
