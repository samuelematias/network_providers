import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:search/src/constants/constants.dart';
import 'package:search/src/models/models.dart';

/// {@template network_providers_repository}
/// A cubit that handle the business logic.
/// {@endtemplate}
class NetworkProvidersRepository {
  /// Read the entire json and,
  /// return the list of the network provider.
  Future<List<NetworkProvidersModel>> readJson() async {
    final response = await rootBundle.loadString(providersJson);
    final body = json.decode(response) as List;
    return body.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return NetworkProvidersModel(
        name: map['name'] as String,
      );
    }).toList();
  }
}
