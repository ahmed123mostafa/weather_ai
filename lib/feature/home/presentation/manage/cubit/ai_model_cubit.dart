import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_ai/feature/home/data/models/weather_model.dart';
import 'package:flutter_weather_ai/feature/home/domain/usecase/weather_predection.dart';
import 'package:flutter_weather_ai/feature/home/presentation/manage/cubit/ai_mode_state.dart';

class AiModelCubit extends Cubit<AiModelStates> {
  final AiUseCase aiUseCase;

  AiModelCubit(this.aiUseCase) : super(AiModelinitial());
  int ?prediction;
  Future<int?> getPrediction(WeatherModel? features) async {
    try {
      emit(Aioading());
      if (features != null) {
       prediction= await aiUseCase.getPrediction(fromList(features));
        emit(AiSuccess());
        return prediction;
      } else {
        emit(AiFaliuer());
        print("Error: features is null");
        return null;
      }

    } catch (e) {
      emit(AiFaliuer());
      print("Error: $e");
      return null;
    }
  }

  List<int> fromList(WeatherModel data) {
    List<int> list = List.filled(5, 0);
    if (data.rain > 50) {
      list[0] = 1;
      list[1] = 0;
    } else {
      list[0] = 0;
      list[1] = 1;
    }

    if (data.uv! > 32) {
      list[2] = 1;
    } else {
      list[2] = 0;
    }
    
    if (data.temp! < 38) {
      list[3] = 1;
    } else {
      list[3] = 0;
    }

    if (data.humidity! < 60) {
      list[4] = 1;
    } else {
      list[4] = 0;
    }
    
    return list;
  }
}