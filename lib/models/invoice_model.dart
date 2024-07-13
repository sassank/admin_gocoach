// lib/models/invoice_model.dart
class Invoice {
  String invoiceNumber;
  String clientName;
  double amount;
  DateTime dueDate;
  bool isPaid;

  Invoice({
    required this.invoiceNumber,
    required this.clientName,
    required this.amount,
    required this.dueDate,
    required this.isPaid,
  });
}
