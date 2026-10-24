# Volt Velocímetro

Painel desportivo para o browser do Tesla e para telemóvel. A velocidade vem do GPS do browser. A potência da bateria, a consumir ou a regenerar, é calculada em tempo real a partir dessa velocidade.

## O que tem

- Dois mostradores com moldura hexagonal, ao estilo de um painel desportivo:
  - **Velocidade** de 0 a 300 km/h, com banda vermelha que acende com a velocidade, ponteiro laranja, zona vermelha a partir de 250, velocidade máxima e P/D.
  - **Potência**: 0 no topo, consumo para a direita até 300 kW (laranja → vermelho) e regeneração para a esquerda até 100 kW (azul). Mostra também o consumo médio em Wh/km.
- Viagem no rodapé: distância, kWh gastos, kWh regenerados, **consumo** da viagem (kWh gastos menos kWh regenerados, desde o início da viagem), % recuperado e **tempo de viagem**.
- Botões: GPS, Demo, Repor (viagem a zero) e Ecrã inteiro.
- O GPS arranca sozinho ao abrir a app. Se o browser não der localização, passa para a demonstração.
- O ecrã fica ligado e a app funciona sem internet depois de aberta uma vez.
- Ecrã na horizontal (Tesla, tablet): mostradores lado a lado. Telemóvel ao alto: um por cima do outro.

## Como a potência é calculada

A cada leitura do GPS, a app calcula a aceleração e estima a potência necessária com um modelo físico de um Model 3/Y:

- massa × aceleração (acelerar gasta, travar regenera);
- resistência do ar (cresce com o quadrado da velocidade);
- atrito dos pneus;
- rendimento do motor (90%), rendimento da regeneração (75%, até 90 kW) e 0,4 kW de consumo do carro.

Dá a tendência certa e valores próximos da realidade em estrada plana. Não conhece subidas, descidas, vento nem o ar condicionado. O GPS atualiza cerca de 1 vez por segundo, por isso a potência responde com esse atraso. Os valores do carro estão no bloco `CAR` de `src/app.html`; se tiveres outro modelo, ajusta a massa (`mass`).

## Tempo de viagem

A app mede a viagem sozinha:
- conta enquanto o carro anda, e as paragens curtas (semáforos, trânsito) até 3 minutos também contam;
- se o carro ficar parado mais tempo, o relógio pára; se ficar parado mais de 10 minutos, a próxima condução começa uma viagem nova;
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
