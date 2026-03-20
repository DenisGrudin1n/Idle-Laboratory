import 'package:idle_laboratory/core/utils/big_number.dart';

class GameConstants {
  GameConstants._();

  static final initialEnergy = BigNumber.zero();
  static final startingEnergyPerSecond = BigNumber(1, 0);
  static const energyUpdateIntervalMs = 100;

  static const suffixes = [
    '', 'K', 'M', 'B', 'T', 'Qa', 'Qi', 'Sx', 'Sp', 'Oc', 'No', 'Dc', 'Ud', 'Dd', 'Td', 'Qad', 'Qid', 'Sxd', 'Spd', 'Ocd', 'Nod', 'Vg', 'Uvg', 'Dvg', 'Tvg', 'Qavg', 'Qivg', 'Sxvg', 'Spvg', 'Ocvg', 'Novg', 'Tg', 'Utg', 'Dtg', 'Ttg', 'Qatg', 'Qitg', 'Sxtg', 'Sptg', 'Octg', 'Notg', 'Qg', 'Uqg', 'Dqg', 'Tqg', 'Qaqg', 'Qiqg', 'Sxqg', 'Spqg', 'Ocqg', 'Noqg', 'Qq', 'Uqq', 'Dqq', 'Tqq', 'Qaqq', 'Qiqq', 'Sxqq', 'Spqq', 'Ocqq', 'Noqq', 'Sg', 'Usg', 'Dsg', 'Tsg', 'Qasg', 'Qisg', 'Sxsg', 'Spsg', 'Ocsg', 'Nosg', 'Stg', 'Ustg', 'Dstg', 'Tstg', 'Qastg', 'Qistg', 'Sxstg', 'Spstg', 'Ocstg', 'Nostg', 'Og', 'Uog', 'Dog', 'Tog', 'Qaog', 'Qiog', 'Sxog', 'Spog', 'Ocog', 'Noog', 'Ng', 'Ung', 'Dng', 'Tng', 'Qang', 'Qing', 'Sxng', 'Spng', 'Ocng', 'Nong', 'Ce',
  ];
}
