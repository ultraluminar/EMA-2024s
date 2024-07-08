part of 'edit_product_bloc.dart';

sealed class EditProductEvent extends Equatable {
  const EditProductEvent();
}

final class EditProductNameChanged extends EditProductEvent {
  const EditProductNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class EditProductExpiresAtChanged extends EditProductEvent {
  const EditProductExpiresAtChanged(this.expiresAt);

  final ExpirationDate expiresAt;

  @override
  List<Object> get props => [expiresAt];
}

final class EditProductExpiresDaysAfterOpen extends EditProductEvent {
  const EditProductExpiresDaysAfterOpen(this.expiresDaysAfterOpen);

  final int expiresDaysAfterOpen;

  @override
  List<Object> get props => [expiresDaysAfterOpen];
}

final class EditProductSubmitted extends EditProductEvent {
  const EditProductSubmitted();

  @override
  List<Object?> get props => [];
}
