part of 'edit_product_bloc.dart';

sealed class EditProductEvent extends Equatable {
  const EditProductEvent();

  @override
  List<Object> get props => [];
}

final class EditProductNameChanged extends EditProductEvent {
  const EditProductNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];

  @override
  String toString() => "EditProductNameChanged( name: $name )";
}

final class EditProductExpiresAtChanged extends EditProductEvent {
  const EditProductExpiresAtChanged(this.expiresAt);

  final DateTime expiresAt;

  @override
  List<Object> get props => [expiresAt];

  @override
  String toString() => "EditProductExpiresAtChanged( expiresAt: $expiresAt )";
}

final class EditProductStoredAtChanged extends EditProductEvent {
  const EditProductStoredAtChanged(this.storedAt);

  final DateTime storedAt;

  @override
  List<Object> get props => [storedAt];

  @override
  String toString() => "EditProductStoredAtChanged( storedAt: $storedAt )";
}

final class EditProductOwnerChanged extends EditProductEvent {
  const EditProductOwnerChanged(this.owner);

  final String owner;

  @override
  List<Object> get props => [owner];

  @override
  String toString() => "EditProductOwnerChanged( owner: $owner )";
}

final class EditProductTagsChanged extends EditProductEvent {
  const EditProductTagsChanged(this.tags);

  final List<String> tags;

  @override
  List<Object> get props => [tags];

  @override
  String toString() => "EditProductTagsChanged( tags: $tags )";
}

final class EditProductSubmitted extends EditProductEvent {
  const EditProductSubmitted();
}
