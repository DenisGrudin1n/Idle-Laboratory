import 'package:idle_laboratory/core/enums/cell_type.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

extension CellTypeL10n on CellType {
  String localize(AppLocalizations l10n) => switch (this) {
        CellType.energy => l10n.energyType,
      };
}
