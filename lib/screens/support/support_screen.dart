import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  static const _faqs = [
    ('Como acompanho meu pedido?', 'Acesse "Pedidos" no menu inferior e toque no pedido desejado para ver a linha do tempo de entrega.'),
    ('Quais formas de pagamento são aceitas?', 'Cartão de crédito, transferência bancária, carteira digital e pagamento por referência.'),
    ('Como faço para trocar ou devolver um produto?', 'Entre em contacto com o nosso suporte em até 7 dias após o recebimento do pedido.'),
    ('O que fazer se meu pagamento não foi confirmado?', 'Verifique o status em "Meus pedidos". Caso persista, contacte o suporte informando o número do pedido.'),
    ('Como funciona o frete?', 'O valor e prazo de entrega são calculados na etapa de checkout, de acordo com a opção escolhida.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(title: const Text('Ajuda e suporte')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.support_agent_rounded, color: Colors.white, size: 32),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text('Estamos aqui para ajudar!\nFale connosco quando precisar.',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Perguntas frequentes', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 10),
          ..._faqs.map((faq) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)),
                child: ExpansionTile(
                  shape: const RoundedRectangleBorder(side: BorderSide.none),
                  title: Text(faq.$1, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(faq.$2, style: const TextStyle(color: AppColors.secondaryText)),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 10),
          const Text('Contacto', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 10),
          _contactTile(Icons.chat_bubble_outline_rounded, 'Chat com o suporte'),
          _contactTile(Icons.email_outlined, 'suporte@dgcomercialonline.com'),
          _contactTile(Icons.phone_outlined, '+244 900 000 000'),
        ],
      ),
    );
  }

  Widget _contactTile(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
          const Icon(Icons.chevron_right_rounded, color: AppColors.secondaryText),
        ],
      ),
    );
  }
}
