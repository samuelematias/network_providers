import 'package:flutter/material.dart';

/// {@template alert_widget}
/// The page responsabilite to render the list of movies.
/// {@endtemplate}
class AlertWidget extends StatelessWidget {
  /// {@macro alert_widget}
  const AlertWidget({
    super.key,
    required this.alertIcon,
    required this.alertMessage,
    this.alertButtonLabel = '',
    this.alertButtonOnPressed,
  });

  /// The icon data for the alert.
  final IconData alertIcon;

  /// The text for the alert.
  final String alertMessage;

  /// The text label for the alert button.
  final String alertButtonLabel;

  /// The on pressed function for the alert button.
  /// can be null.
  final VoidCallback? alertButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    final showAlertButton =
        alertButtonOnPressed != null && alertButtonLabel.isNotEmpty;
    return Column(
      children: [
        Icon(
          alertIcon,
          size: 40,
        ),
        const SizedBox(height: 16),
        Text(alertMessage),
        if (showAlertButton) ...[
          TextButton(
            onPressed: alertButtonOnPressed,
            child: Text(alertButtonLabel),
          )
        ]
      ],
    );
  }
}
