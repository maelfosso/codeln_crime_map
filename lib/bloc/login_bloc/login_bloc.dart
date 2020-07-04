import 'package:bloc/bloc.dart';
import 'package:codeln_crime_map/bloc/login_bloc/login_event.dart';
import 'package:codeln_crime_map/bloc/login_bloc/login_state.dart';
import 'package:meta/meta.dart';
import 'package:codeln_crime_map/repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository})
    : assert(userRepository != null),
      _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _userRepository.signInWithGoogle();
    } catch(_) {
      yield LoginState.failure();
    }
  }
  
}