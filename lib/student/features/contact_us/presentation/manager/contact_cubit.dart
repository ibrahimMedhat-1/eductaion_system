import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());
  static ContactCubit get(context) => BlocProvider.of(context);
}
