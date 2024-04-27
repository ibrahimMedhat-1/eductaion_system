part of 'parent_chat_cubit.dart';

@immutable
sealed class ParentChatState {}

final class ParentChatInitial extends ParentChatState {}
final class GetAllMessagesSuccessfully extends ParentChatState {}
