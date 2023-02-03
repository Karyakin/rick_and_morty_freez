part of 'character_bloc.dart';

@freezed
class CharacterState with _$CharacterState {
  const factory CharacterState.loading() = CharacterStateLoading;
  factory CharacterState.loaded({required Character character}) =
      CharacterStateLoaded;
  const factory CharacterState.error() = CharacterStateError;
}
