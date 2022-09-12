import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:search/src/models/json_map.dart';

part 'network_providers_model.g.dart';

/// {@template network_providers}
/// A collection of network providers.
///
/// [NetworkProvidersModel]s are immutable and can be copied using [copyWith],
/// in addition to being serialized and deserialized
/// using [toJson] and [fromJson] respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class NetworkProvidersModel extends Equatable {
  /// {@macro network_providers}
  const NetworkProvidersModel({
    this.name,
  });

  /// The movie topic name.
  final String? name;

  /// Returns a copy of this todo with the given values updated.
  ///
  /// {@macro network_providers}
  NetworkProvidersModel copyWith({
    String? name,
  }) {
    return NetworkProvidersModel(
      name: name ?? this.name,
    );
  }

  /// Deserializes the given [JsonMap] into a [NetworkProvidersModel].
  static NetworkProvidersModel fromJson(JsonMap json) =>
      _$NetworkProvidersModelFromJson(json);

  /// Converts this [NetworkProvidersModel] into a [JsonMap].
  JsonMap toJson() => _$NetworkProvidersModelToJson(this);

  @override
  List<Object?> get props => [name];
}
