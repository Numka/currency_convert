import 'dart:convert';

import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  const Currency({
    required this.id,
    required this.symbol,
    required this.type,
    required this.rateUsd,
    required this.currencySymbol,
  });

  final String id;
  final String symbol;
  final String type;
  final double rateUsd;
  final String? currencySymbol;

  static const empty = Currency(
    id: '',
    symbol: '',
    type: '',
    rateUsd: 0,
    currencySymbol: '',
  );

  Currency copyWith({
    String? id,
    String? symbol,
    String? type,
    double? rateUsd,
    String? currencySymbol,
  }) {
    return Currency(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
      rateUsd: rateUsd ?? this.rateUsd,
      currencySymbol: currencySymbol ?? this.currencySymbol,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'symbol': symbol,
      'type': type,
      'rateUsd': rateUsd,
      'currencySymbol': currencySymbol,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map['id'] as String,
      symbol: map['symbol'] as String,
      type: map['type'] as String,
      rateUsd: double.parse(map['rateUsd'] as String),
      currencySymbol: map['currencySymbol'] as String?,
    );
  }

  String toJson() => json.encode(toMap());
  factory Currency.fromJson(Map<String, String> json) => Currency.fromMap(json);

  @override
  List<Object?> get props => [id, symbol, type, rateUsd];
}
