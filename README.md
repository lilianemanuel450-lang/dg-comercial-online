# DG Comercial Online — App Flutter

App mobile de e-commerce em Flutter, com todas as telas e o fluxo de compra completo funcionando com **dados fictícios em memória** (sem backend/banco de dados ainda, conforme combinado). Fluxo real: navegar → pesquisar → ver produto → carrinho → checkout (4 etapas) → confirmação → acompanhamento do pedido.

## O que já funciona

- Navegação inferior (Início, Categorias, Carrinho, Pedidos, Conta)
- Busca com filtros (categoria, preço, avaliação) e ordenação
- Detalhes do produto com variações (cor/tamanho) e quantidade
- Carrinho com atualização de totais em tempo real
- Checkout em 4 etapas (dados pessoais → endereço → entrega → pagamento)
- Criação de pedido, tela de confirmação e acompanhamento (timeline de status)
- Favoritos, notificações, suporte/FAQ, login e cadastro (simulados)
- Estados vazios/erro (carrinho vazio, sem favoritos, sem pedidos, produto esgotado)

> **Backend:** ainda não implementado, por decisão do escopo atual. O `AuthProvider`, `CartProvider`, `OrdersProvider` etc. já estão isolados em `lib/providers/`, prontos para trocar a lógica local por chamadas a uma API real quando você quiser avançar.

---

## Como rodar no Termux

1. Instale o Flutter dentro do Termux (recomenda-se usar o `proot-distro` com Ubuntu, pois o Flutter SDK completo não roda bem direto no Termux puro):
   ```bash
   pkg update && pkg install proot-distro git -y
   proot-distro install ubuntu
   proot-distro login ubuntu
   ```
2. Dentro do Ubuntu (via proot-distro), instale as dependências e o Flutter:
   ```bash
   apt update && apt install -y curl git unzip xz-utils zip openjdk-17-jdk
   git clone https://github.com/flutter/flutter.git -b stable
   export PATH="$PATH:`pwd`/flutter/bin"
   flutter doctor
   ```
3. Copie este projeto para o dispositivo (veja a seção GitHub abaixo) e rode:
   ```bash
   cd dg_comercial_online
   flutter pub get
   flutter run
   ```
   Para gerar o instalável Android:
   ```bash
   flutter build apk --release
   ```
   O APK fica em `build/app/outputs/flutter-apk/app-release.apk`.

> Build Android completo (Gradle) consome bastante RAM/armazenamento — em celulares mais fracos, prefira deixar o **GitHub Actions** gerar o APK para você (veja abaixo) e apenas baixe o resultado.

---

## Como subir para o GitHub

```bash
cd dg_comercial_online
git init
git add .
git commit -m "Primeira versão do app DG Comercial Online"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/dg-comercial-online.git
git push -u origin main
```

## GitHub Actions (já incluído)

O workflow `.github/workflows/build.yml` compila o APK automaticamente a cada `push` na branch `main`. Depois do push:

1. Vá até a aba **Actions** do repositório no GitHub.
2. Abra a execução mais recente do workflow "Build APK".
3. Baixe o artefato `dg-comercial-online-apk` — é o `.apk` pronto para instalar no Android.

Isso evita ter que compilar o app inteiro no celular via Termux.

---

## Estrutura do projeto

```
lib/
  main.dart                 → ponto de entrada
  theme/                     → cores e tema visual (laranja/branco da marca)
  models/                    → Product, ProductCategory, CartItem, Order, AppUser...
  data/mock_data.dart         → produtos e categorias de demonstração
  providers/                  → estado do app (carrinho, favoritos, pedidos, auth, notificações)
  widgets/                    → componentes reutilizáveis (ProductCard, CategoryCard, etc.)
  navigation/main_shell.dart  → bottom navigation
  screens/                    → todas as telas, organizadas por fluxo
```

## Próximos passos sugeridos

1. Trocar `ProductImagePlaceholder` por imagens reais dos produtos.
2. Ligar `AuthProvider`, `CartProvider` e `OrdersProvider` a uma API/backend real (o código já está isolado para isso).
3. Configurar ícone do app e nome de pacote Android (`android/app/build.gradle` e `android/app/src/main/AndroidManifest.xml`) — gerados automaticamente ao rodar `flutter create .` dentro da pasta, caso as pastas `android/` e `ios/` ainda não existam no seu ambiente.

> **Nota:** este projeto contém apenas a pasta `lib/` e arquivos de configuração — as pastas nativas `android/`, `ios/`, `web/` etc. são geradas automaticamente pelo comando `flutter create .` executado dentro da pasta do projeto, na primeira vez que você configurar o ambiente Flutter (isso não pôde ser feito aqui por não haver o SDK Flutter disponível neste ambiente de geração de código).
