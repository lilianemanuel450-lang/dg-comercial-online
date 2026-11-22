import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../providers/cart_provider.dart';
import '../../providers/orders_provider.dart';
import '../../providers/notifications_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/formatters.dart';
import 'order_confirmation_screen.dart';

enum _DeliveryOption { normal, rapida, retirada }

enum _PaymentMethod { cartao, transferencia, carteira, referencia }

extension on _PaymentMethod {
  String get label {
    switch (this) {
      case _PaymentMethod.cartao:
        return 'Cartão de Crédito';
      case _PaymentMethod.transferencia:
        return 'Transferência bancária';
      case _PaymentMethod.carteira:
        return 'Carteira digital';
      case _PaymentMethod.referencia:
        return 'Pagamento por referência';
    }
  }

  IconData get icon {
    switch (this) {
      case _PaymentMethod.cartao:
        return Icons.credit_card_rounded;
      case _PaymentMethod.transferencia:
        return Icons.account_balance_rounded;
      case _PaymentMethod.carteira:
        return Icons.account_balance_wallet_rounded;
      case _PaymentMethod.referencia:
        return Icons.receipt_long_rounded;
    }
  }
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _step = 0;
  final _formKeys = List.generate(3, (_) => GlobalKey<FormState>());

  // Etapa 1
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  // Etapa 2
  final _provinceCtrl = TextEditingController();
  final _municipalityCtrl = TextEditingController();
  final _neighborhoodCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _numberCtrl = TextEditingController();
  final _referenceCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  // Etapa 3
  _DeliveryOption _delivery = _DeliveryOption.normal;

  // Etapa 4
  _PaymentMethod _payment = _PaymentMethod.cartao;
  bool _processing = false;

  static const _titles = ['Dados pessoais', 'Endereço', 'Entrega', 'Pagamento'];

  double get _shippingCost {
    switch (_delivery) {
      case _DeliveryOption.normal:
        return context.read<CartProvider>().shipping;
      case _DeliveryOption.rapida:
        return 5000.0;
      case _DeliveryOption.retirada:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(title: Text(_titles[_step])),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: List.generate(_titles.length, (i) {
                final active = i <= _step;
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: i == _titles.length - 1 ? 0 : 6),
                    height: 5,
                    decoration: BoxDecoration(
                      color: active ? AppColors.primary : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildStep(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, -2)),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  if (_step > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _step--),
                        child: const Text('Voltar'),
                      ),
                    ),
                  if (_step > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _processing ? null : () => _onContinue(cart),
                      child: _processing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Text(_step == 3 ? 'Confirmar pedido' : 'Continuar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return Form(
          key: _formKeys[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _field(_nameCtrl, 'Nome completo', Icons.person_outline_rounded),
              const SizedBox(height: 12),
              _field(_phoneCtrl, 'Telefone', Icons.phone_outlined,
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 12),
              _field(_emailCtrl, 'Email', Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress),
            ],
          ),
        );
      case 1:
        return Form(
          key: _formKeys[1],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _field(_provinceCtrl, 'Província', Icons.map_outlined),
              const SizedBox(height: 12),
              _field(_municipalityCtrl, 'Município', Icons.location_city_outlined),
              const SizedBox(height: 12),
              _field(_neighborhoodCtrl, 'Bairro', Icons.holiday_village_outlined),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(flex: 2, child: _field(_streetCtrl, 'Rua', Icons.signpost_outlined)),
                  const SizedBox(width: 12),
                  Expanded(child: _field(_numberCtrl, 'Número', Icons.numbers_rounded)),
                ],
              ),
              const SizedBox(height: 12),
              _field(_referenceCtrl, 'Referência', Icons.place_outlined, required: false),
              const SizedBox(height: 12),
              _field(_notesCtrl, 'Observações', Icons.notes_rounded, required: false, maxLines: 2),
            ],
          ),
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _deliveryTile(_DeliveryOption.normal, 'Entrega normal', '3 a 7 dias úteis',
                (context.read<CartProvider>().shipping == 0 ? 'Grátis' : AppFormatters.price(context.read<CartProvider>().shipping))),
            _deliveryTile(_DeliveryOption.rapida, 'Entrega rápida', '1 a 2 dias úteis',
                AppFormatters.price(5000.0)),
            _deliveryTile(_DeliveryOption.retirada, 'Levantamento em ponto físico',
                'Disponível hoje', 'Grátis'),
          ],
        );
      case 3:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text('Forma de pagamento', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            for (final method in _PaymentMethod.values) _paymentTile(method),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Este pedido será registado como aguardando pagamento. A confirmação real depende da integração com o meio de pagamento escolhido.',
                style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
              ),
            ),
          ],
        );
    }
  }

  Widget _field(TextEditingController ctrl, String label, IconData icon,
      {TextInputType? keyboardType, bool required = true, int maxLines = 1}) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (v) {
        if (!required) return null;
        if (v == null || v.trim().isEmpty) return 'Campo obrigatório';
        return null;
      },
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
    );
  }

  Widget _deliveryTile(_DeliveryOption option, String title, String subtitle, String price) {
    final selected = _delivery == option;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => setState(() => _delivery = option),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 1.5 : 1),
          ),
          child: Row(
            children: [
              Radio<_DeliveryOption>(
                value: option,
                groupValue: _delivery,
                activeColor: AppColors.primary,
                onChanged: (v) => setState(() => _delivery = v!),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    Text(subtitle, style: const TextStyle(color: AppColors.secondaryText, fontSize: 12)),
                  ],
                ),
              ),
              Text(price, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentTile(_PaymentMethod method) {
    final selected = _payment == method;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => setState(() => _payment = method),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 1.5 : 1),
          ),
          child: Row(
            children: [
              Icon(method.icon, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(child: Text(method.label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
              Radio<_PaymentMethod>(
                value: method,
                groupValue: _payment,
                activeColor: AppColors.primary,
                onChanged: (v) => setState(() => _payment = v!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onContinue(CartProvider cart) async {
    if (_step < 2) {
      final formValid = _formKeys[_step].currentState?.validate() ?? true;
      if (!formValid) return;
      setState(() => _step++);
      return;
    }
    if (_step == 2) {
      setState(() => _step++);
      return;
    }

    // Etapa final: cria o pedido
    setState(() => _processing = true);
    await Future.delayed(const Duration(milliseconds: 900));

    final address = DeliveryAddress(
      province: _provinceCtrl.text,
      municipality: _municipalityCtrl.text,
      neighborhood: _neighborhoodCtrl.text,
      street: _streetCtrl.text,
      number: _numberCtrl.text,
      reference: _referenceCtrl.text,
      notes: _notesCtrl.text,
    );

    final total = cart.subtotal + _shippingCost - cart.discount;

    final order = context.read<OrdersProvider>().createOrder(
          items: cart.items.toList(),
          subtotal: cart.subtotal,
          shipping: _shippingCost,
          discount: cart.discount,
          total: total,
          paymentMethod: _payment.label,
          address: address,
        );

    context.read<NotificationsProvider>().add(
          'Pedido recebido',
          'Seu pedido ${order.id} foi recebido e está aguardando pagamento.',
        );

    cart.clear();

    if (!mounted) return;
    setState(() => _processing = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => OrderConfirmationScreen(order: order)),
    );
  }
}
