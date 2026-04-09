import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/cell_container_section.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/cells_list_section.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/prestige_info_section.dart';

class EnergyCellsContent extends StatelessWidget {
  const EnergyCellsContent({super.key});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const CellsListSection(),
      SizedBox(width: 12.w),
      const Expanded(child: CellContainerSection()),
      SizedBox(width: 12.w),
      const PrestigeInfoSection(),
    ],
  );
}
