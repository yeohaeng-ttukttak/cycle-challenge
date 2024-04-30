import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yeohaeng_ttukttak/data/models/place_model.dart';
import 'package:yeohaeng_ttukttak/data/models/travel_model.dart';

part 'map_data_state.freezed.dart';


@freezed
class MapDataState with _$MapDataState {
  factory MapDataState({
    @Default([]) List<PlaceModel> places,
    @Default([]) List<TravelModel> travels
  }) = _MapDataState;

}