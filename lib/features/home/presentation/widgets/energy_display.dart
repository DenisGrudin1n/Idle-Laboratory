import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/widgets/energy_icon.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/energy/energy_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';

class EnergyDisplay extends StatelessWidget {
  const EnergyDisplay({super.key});

  @override
  Widget build(BuildContext context) => BlocSelector<SettingsBloc, SettingsState, bool>(
    selector: (state) => state.isScientificNotation,
    builder: (context, isScientific) => BlocSelector<EnergyBloc, EnergyState, (BigNumber, BigNumber)>(
      selector: (state) => (state.currentEnergy, state.energyPerSecond),
      builder: (context, data) {
        final (currentEnergy, energyPerSecond) = data;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        currentEnergy.format(useScientific: isScientific),
                        style: context.styles.energyValue,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const EnergyIcon(sizeMultiplier: 1.9),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '+${energyPerSecond.format(useScientific: isScientific)} ${context.l10n.perSecond}',
                style: context.styles.successText,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    ),
  );
}
