// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class BusModel {
  final String destination;
  final String origin;
  final String departureDate;
  final String departureTime;
  final String pickupPoint;
  final String busType;
  final String busClass;
  final int noOfSeats;
  final int ticketPrice;
  final List bookedSeats;
  final String busNo;
  final String agents;
  final String agentsNo;
  BusModel({
    required this.destination,
    required this.origin,
    required this.departureDate,
    required this.departureTime,
    required this.pickupPoint,
    required this.busType,
    required this.busClass,
    required this.noOfSeats,
    required this.ticketPrice,
    required this.bookedSeats,
    required this.busNo,
    required this.agents,
    required this.agentsNo,
  });

  BusModel copyWith({
    String? destination,
    String? origin,
    String? departureDate,
    String? departureTime,
    String? pickupPoint,
    String? busType,
    String? busClass,
    int? noOfSeats,
    int? ticketPrice,
    List? bookedSeats,
    String? busNo,
    String? agents,
    String? agentsNo,
  }) {
    return BusModel(
      destination: destination ?? this.destination,
      origin: origin ?? this.origin,
      departureDate: departureDate ?? this.departureDate,
      departureTime: departureTime ?? this.departureTime,
      pickupPoint: pickupPoint ?? this.pickupPoint,
      busType: busType ?? this.busType,
      busClass: busClass ?? this.busClass,
      noOfSeats: noOfSeats ?? this.noOfSeats,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      bookedSeats: bookedSeats ?? this.bookedSeats,
      busNo: busNo ?? this.busNo,
      agents: agents ?? this.agents,
      agentsNo: agentsNo ?? this.agentsNo,
    );
  }

  toJson() {
    return <String, dynamic>{
      'destination': destination,
      'origin': origin,
      'pickupPoint': pickupPoint,
      'busType': busType,
      'busClass': busClass,
      'noOfSeats': noOfSeats,
      'ticketPrice': ticketPrice,
      'bookedSeats': bookedSeats,
      'busNo': busNo,
      'agents': agents,
      'agentsNo': agentsNo,
      "departureDate": departureDate,
      "departureTime": departureTime,
    };
  }

  factory BusModel.fromMap(Map<String, dynamic> map) {
    return BusModel(
      destination: map['destination'] as String,
      origin: map['origin'] as String,
      departureDate: map['departureDate'] as String,
      departureTime: map['departureTime'] as String,
      pickupPoint: map['pickupPoint'] as String,
      busType: map['busType'] as String,
      busClass: map['busClass'] as String,
      noOfSeats: map['noOfSeats'] as int,
      ticketPrice: map['ticketPrice'] as int,
      bookedSeats: List.from((map['bookedSeats'] as List)),
      busNo: map['busNo'] as String,
      agents: map['agents'] as String,
      agentsNo: map['agentsNo'] as String,
    );
  }

  factory BusModel.fromJson(String source) =>
      BusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BusModel(destination: $destination, origin: $origin, departureDate: $departureDate, departureTime: $departureTime, pickupPoint: $pickupPoint, busType: $busType, busClass: $busClass, noOfSeats: $noOfSeats, ticketPrice: $ticketPrice, bookedSeats: $bookedSeats, busNo: $busNo, agents: $agents, agentsNo: $agentsNo)';
  }

  @override
  bool operator ==(covariant BusModel other) {
    if (identical(this, other)) return true;

    return other.destination == destination &&
        other.origin == origin &&
        other.departureDate == departureDate &&
        other.departureTime == departureTime &&
        other.pickupPoint == pickupPoint &&
        other.busType == busType &&
        other.busClass == busClass &&
        other.noOfSeats == noOfSeats &&
        other.ticketPrice == ticketPrice &&
        listEquals(other.bookedSeats, bookedSeats) &&
        other.busNo == busNo &&
        other.agents == agents &&
        other.agentsNo == agentsNo;
  }

  @override
  int get hashCode {
    return destination.hashCode ^
        origin.hashCode ^
        departureDate.hashCode ^
        departureTime.hashCode ^
        pickupPoint.hashCode ^
        busType.hashCode ^
        busClass.hashCode ^
        noOfSeats.hashCode ^
        ticketPrice.hashCode ^
        bookedSeats.hashCode ^
        busNo.hashCode ^
        agents.hashCode ^
        agentsNo.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'destination': destination,
      'origin': origin,
      'departureDate': departureDate,
      'departureTime': departureTime,
      'pickupPoint': pickupPoint,
      'busType': busType,
      'busClass': busClass,
      'noOfSeats': noOfSeats,
      'ticketPrice': ticketPrice,
      'bookedSeats': bookedSeats,
      'busNo': busNo,
      'agents': agents,
      'agentsNo': agentsNo,
    };
  }
}
