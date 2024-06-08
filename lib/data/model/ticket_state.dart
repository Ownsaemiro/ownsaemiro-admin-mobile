import 'dart:convert';

class TicketState {
  final String eventId;
  final String userId;
  final String deviceId;
  final String ticketHash;

  TicketState({
    required this.eventId,
    required this.userId,
    required this.deviceId,
    required this.ticketHash,
  });

  factory TicketState.fromString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);

    return TicketState(
      eventId: json["ticket_id"],
      userId: json["user_id"],
      deviceId: json["device_id"],
      ticketHash: json["event_hash"],
    );
  }
}
