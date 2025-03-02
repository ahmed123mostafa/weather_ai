import 'package:flutter_weather_ai/feature/home/data/remote_data_source/ai_data.dart';
import 'package:flutter_weather_ai/feature/home/domain/repo/ai_weather.dart';

class AiModelRepositoryImp extends AiModel{
  final AiService aiModelRepositoriesl;
  AiModelRepositoryImp({required this.aiModelRepositoriesl});

  @override
  Future<int?> getPrediction(List<int> features)async {
   return await aiModelRepositoriesl.getPrediction(features);
   
  }
  }