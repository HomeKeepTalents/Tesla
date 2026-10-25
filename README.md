# HXN - Tesla

Painel desportivo para o browser do Tesla e para telemóvel. A velocidade vem do GPS do browser. A potência da bateria, a consumir ou a regenerar, é calculada em tempo real a partir dessa velocidade.

## O que tem

- **Personalizado**: emblema **HXN · Model Y** no topo, e o cálculo da potência usa o peso e a aerodinâmica do Model Y.
- Dois discos de vidro ("liquid glass") sobre luz colorida em movimento:
  - **Velocidade** de 0 a 300 km/h, com arco que acende com a velocidade, zona vermelha a partir de 250, velocidade máxima e o modo de condução.
  - **Conta-rotações**: as rotações do motor escolhido no menu **Som**, com a escala e a zona vermelha desse motor (GT3 0–10 mil com vermelho aos 9000, Aventador e Huracán 0–10, 458 0–10, AMG GT 63 e Supra 0–8, A45 0–8, Elétrico 0–20 mil rpm do motor elétrico). São as mesmas rotações que o som usa, por isso o ponteiro cai a cada passagem de caixa. Dentro está a **mudança engrenada (1 a 8)**, que sobe e desce com a velocidade: 1 até 20 km/h, 2 até 40, 3 até 60, 4 até 85, 5 até 110, 6 até 140, 7 até 180 e 8 acima disso. Perto da zona vermelha o anel da mudança pisca a vermelho (luz de passagem de caixa).
- **Modos de condução** no topo: **Sport** (vermelho), **Eco** (verde) e **Comfort** (azul). Mudam as cores do arco de velocidade, da luz de fundo e dos botões. Em **Comfort** os mostradores passam ao estilo clássico da Mercedes-Benz: aro prateado com brilho azul, mostrador preto com números brancos (velocidade de 20 em 20), ponteiro vermelho a partir do centro com rasto iluminado e velocidade pequena no centro. O modo escolhido fica guardado.
- **Gráfico de potência dos últimos 60 s**: laranja acima de zero (a consumir), azul abaixo (a regenerar), com os picos do último minuto. O botão **Gráfico** mostra ou oculta o gráfico (sem ele, os discos ficam maiores); a escolha fica guardada.
- Viagem no rodapé: distância, kWh gastos, kWh regenerados, **consumo** da viagem (kWh gastos menos kWh regenerados), % recuperado e **tempo de viagem**.
- **Som do motor** (botão **Som**): Mercedes-AMG GT 63 (V8 biturbo), Porsche 911 GT3 (boxer 6), Lamborghini Aventador SVJ (V12), Lamborghini Huracán (V10), Ferrari 458 Italia (V8 de cambota plana), Toyota Supra MK4 (6 em linha biturbo, com o "stu-tu-tu" do turbo), Mercedes-AMG A45 S reprogramado com 460 cv (4 cilindros 2.0 turbo, rouco, turbo forte e os estalos mais agressivos de todos) e Elétrico, com volume. O som é sintetizado na hora, não são gravações: cada explosão de cada cilindro é gerada pela ordem de ignição do motor e passa por "tubos de escape" que ressoam, com a bancada esquerda e a direita em lados diferentes do estéreo. Daí vem o carácter de cada um: o V8 de cambota cruzada do AMG tem explosões irregulares (borbulhar grave, estalos e assobio do turbo), o boxer 6 do GT3 grita até 9000 rpm, e o V12 do SVJ é agudo e suave, com passagens de caixa violentas. As rotações seguem a velocidade e a mudança de 1 a 8; acelerar abre o som. **Estalos** em todos os motores: crepitar durante 1–3 s quando levantas o pé a rotações altas (mais denso no início), estalos em cada passagem de caixa e em cada redução, com estalos curtos e rebentamentos grandes com "murro" grave. O AMG é o que mais crepita, o SVJ tem os rebentamentos maiores e o GT3 um crepitar mais seco e agudo. Uma reverberação curta dá espaço ao som. No menu **Som**, debaixo dos motores, há dois interruptores: **Estalos** (liga ou desliga o crepitar e os rebentamentos) e **Válvulas de escape** (abertas: mais alto, mais graves e estalos fortes; fechadas: mais baixo, abafado e estalos suaves). Ficam guardados com a escolha do motor e não se aplicam ao Elétrico. O som só arranca depois de tocares num botão, como exigem os browsers.
- Botões: GPS, Demo, Repor (viagem a zero), Gráfico, Som e Ecrã inteiro.
- **Vista** (botão com o ícone de controlos, ao lado do relógio): cada toque troca entre
  - **Completa**: botões com texto, modos de condução e indicadores no topo;
  - **Ícones**: os botões passam a ícones redondos;
  - **Limpa**: esconde as opções e deixa os mostradores, o gráfico (se estiver ligado), a viagem e o relógio;
  - **Mínima**: esconde também a barra de baixo com as estatísticas e os botões. Toca outra vez no botão de vista para voltar à vista completa.
  A vista escolhida fica guardada.
- O GPS arranca sozinho ao abrir a app. Se o browser não der localização, passa para a demonstração.
- O ecrã fica ligado e a app funciona sem internet depois de aberta uma vez.
- Ecrã na horizontal (Tesla, tablet): discos lado a lado. Telemóvel ao alto: um por cima do outro.

## Como a potência é calculada

A cada leitura do GPS, a app calcula a aceleração e estima a potência necessária com um modelo físico de um Model 3/Y:

- massa × aceleração (acelerar gasta, travar regenera);
- resistência do ar (cresce com o quadrado da velocidade);
- atrito dos pneus;
- rendimento do motor (90%), rendimento da regeneração (75%, até 90 kW) e 0,4 kW de consumo do carro.

Dá a tendência certa e valores próximos da realidade em estrada plana. Não conhece subidas, descidas, vento nem o ar condicionado. O GPS atualiza cerca de 1 vez por segundo, por isso a potência responde com esse atraso. Os valores do carro estão no bloco `CAR` de `src/app.html`; se tiveres outro modelo, ajusta a massa (`mass`).

## Tempo de viagem

O tempo **só conta com o carro em andamento**. Como a app usa só o GPS, isso é deduzido do movimento (não aparece no ecrã):
- começa a contar depois de 2 segundos seguidos em movimento. Assim, um erro do GPS com o carro estacionado não arranca o relógio;
- num semáforo ou no trânsito continua a contar; só pára depois de 3 minutos parado;
- depois de mais de 10 minutos parado, a próxima condução começa uma viagem nova;
- a viagem fica guardada no browser, por isso não se perde se a página recarregar. Ao fim de 6 horas sem uso começa de novo;
- **Repor** põe tudo a zero.

## Publicar (GitHub Pages)

A app precisa de um endereço `https://` para o GPS funcionar. O GitHub dá um de graça:

1. No repositório, vai a **Settings → Pages**.
2. Em **Build and deployment**, escolhe **Deploy from a branch**, o ramo `main` e a pasta `/docs`. Carrega em **Save**.
3. Passado um minuto a app fica em **https://homekeeptalents.github.io/Tesla/**.

Sempre que fizeres push de alterações, o GitHub atualiza o endereço sozinho.

## Publicar no Cloudflare Workers (alternativa)

O ficheiro `wrangler.jsonc` publica a pasta `docs/` num worker chamado `tesla`.

**Pelo painel do Cloudflare, ligado ao GitHub:** em **Workers & Pages → Create → Import a repository**, escolhe `HomeKeepTalents/Tesla` e preenche:
- **Build command:** deixa vazio (a pasta `docs/` já vem pronta)
- **Deploy command:** `npx wrangler deploy`

A partir daí, cada push para `main` publica sozinho. O endereço fica `https://tesla.<a-tua-conta>.workers.dev`.

**Pelo terminal** (precisa de Node.js instalado):

```bash
npx wrangler login
npx wrangler deploy
```

## Usar no browser do Tesla

1. No ecrã do carro abre o **Browser** e escreve https://homekeeptalents.github.io/Tesla/. Guarda-o nos favoritos.
2. Autoriza a localização quando o browser perguntar.

## Instalar no telemóvel

Abre https://homekeeptalents.github.io/Tesla/ no telemóvel.
- **iPhone (Safari):** Partilhar → Adicionar ao ecrã principal.
- **Android (Chrome):** menu ⋮ → Instalar app.

## Ficheiros

- `src/app.html`: a app (ecrã, GPS, cálculo da potência, tempo de viagem).
- `build.sh`: gera `docs/index.html` a partir de `src/app.html`. Corre-o sempre que alterares o código, antes do commit.
- `docs/`: a app pronta a publicar (página, manifesto, ícone, funcionamento sem internet). É esta pasta que o GitHub Pages e o Cloudflare publicam.
- `wrangler.jsonc`: configuração do Cloudflare Workers.

> Usa a app com o ecrã fixo e não mexas nela a conduzir.
