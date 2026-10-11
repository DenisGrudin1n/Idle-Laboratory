import 'package:idle_laboratory/features/home/domain/models/statistics_model/statistics_model.dart';

abstract class StatisticsRepository {
  Future<StatisticsModel?> getStatistics();
  Future<void> saveStatistics(StatisticsModel statistics);
  Future<void> clearAll();
}
