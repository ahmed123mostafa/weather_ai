

import 'package:flutter_weather_ai/feature/home/domain/repo/ai_weather.dart';

class AiUseCase {
  final AiModel aiModel;

  AiUseCase({required this.aiModel});

  Future<int?> getPrediction (List<int>features)=> aiModel.getPrediction(features);
}