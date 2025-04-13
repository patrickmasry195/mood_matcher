part of 'avatar_cubit.dart';



class AvatarState extends Equatable {
  final File? avatar;
  final bool isAvatarValid;
  final bool isLoading;
  final bool isUploaded;
  final String? error;

  const AvatarState({
    this.avatar,
    this.isAvatarValid = false,
    this.isLoading = false,
    this.isUploaded = false,
    this.error,
  });

  AvatarState copyWith({
    File? avatar,
    bool? isAvatarValid,
    bool? isLoading,
    bool? isUploaded,
    String? error,
  }) {
    return AvatarState(
      avatar: avatar ?? this.avatar,
      isAvatarValid: isAvatarValid ?? this.isAvatarValid,
      isLoading: isLoading ?? this.isLoading,
      isUploaded: isUploaded ?? this.isUploaded,
      error: error,
    );
  }

  @override
  List<Object?> get props => [avatar, isAvatarValid, isLoading, isUploaded, error];
}