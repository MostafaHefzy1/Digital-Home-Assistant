abstract class HomeState {}

class HomeInitial extends HomeState {}

class NavigateToNextScreenSuccessState extends HomeState {}

class StartListenSuccessState extends HomeState {}

class StopListenSuccessState extends HomeState {}

class TextToSpeechSuccessState extends HomeState {}

class GetTextSuccess extends HomeState {}

class ImagePickerSuccess extends HomeState {}

class ImagePickerFailed extends HomeState {}

class CreateProductLoadingState extends HomeState {}

class CreateProductSuccessState extends HomeState {}

class CreateProductFailedState extends HomeState {
  final String error;

  CreateProductFailedState(this.error);
}

class UploadProductSuccessState extends HomeState {}

class UploadProductFailedState extends HomeState {
  final String error;

  UploadProductFailedState(this.error);
}

class ImagePickedSuccessState extends HomeState {}

class ImagePickedErrorState extends HomeState {}

class SwitchButtonSuccessState extends HomeState {}

class GetAllDataInFireBaseSuccessState extends HomeState {}

class GetAllDataInFireBaseLoadingState extends HomeState {}
class GetAllDataInFireBaseErrorState extends HomeState {}


class GetCurrentWeatherSuccess extends  HomeState {}
class GetCurrentWeatherFailed extends  HomeState {}


class GetNewsSuccess extends  HomeState {}
class GetNewsFailed extends  HomeState {}



class SomeAndTempSuccessState extends  HomeState {}



class GoToMapSuccessState  extends  HomeState {}
class GoToMapFailedState  extends  HomeState {}