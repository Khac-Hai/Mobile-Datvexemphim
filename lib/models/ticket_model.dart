class Ticket {
  final String movie;
  final String cinema;
  final String timeSlot;
  final List<String> seats;
  final int total;
  final DateTime date;

  Ticket({
    required this.movie,
    required this.cinema,
    required this.timeSlot,
    required this.seats,
    required this.total,
    required this.date,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      movie: json['movie'] ?? '',
      cinema: json['cinema'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
      seats: List<String>.from(json['seats'] ?? []),
      total: json['total'] ?? 0,
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movie': movie,
      'cinema': cinema,
      'timeSlot': timeSlot,
      'seats': seats,
      'total': total,
      'date': date.toIso8601String(),
    };
  }
}
