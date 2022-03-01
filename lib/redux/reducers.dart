import 'package:spotify_clone/redux/actions.dart';
import 'package:spotify_clone/model/app_state.dart';

AppState reducer(AppState prevState, dynamic action){
  AppState newState = AppState.fromAppState(prevState);
  if(action is update_name)
    {
      newState.name = action.payload;
    }
  if(action is update_tracks)
  {
    newState.tracklist = action.payload;
  }
  if(action is update_artist)
  {
    newState.artistlist = action.payload;
  }
  if(action is update_album)
  {
    newState.albumlist = action.payload;
  }
  return newState;
}