// lib/models/invoice_model.dart
class Invoice {
  final String invoiceNumber;
  final String clientName;
  final double amount;
  final DateTime dueDate;
  bool isPaid;
  final String pdfPath;

  Invoice({
    required this.invoiceNumber,
    required this.clientName,
    required this.amount,
    required this.dueDate,
    required this.isPaid,
    required this.pdfPath,
  });
}
