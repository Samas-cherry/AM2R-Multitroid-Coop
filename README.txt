================================================================================
                    AM2R MULTITROID CO-OP - MANUAL DO MOD
================================================================================
Criador do Mod Co-op: Samuka_beludo
Base original: AM2R Multitroid (milesthenerd, DodoBirby, VanessaMae1087)
Jogo base original: Another Metroid 2 Remake (DoctorM64 & Martin Piecyk)
Versão: 1.9.2-coop
Data de Lançamento: Outubro de 2026
Idioma: Português do Brasil (PT-BR)
================================================================================

1. INTRODUÇÃO E OBJETIVO
--------------------------------------------------------------------------------
O AM2R Multitroid Co-op é uma modificação profunda que eu fiz por que sempre
quis jogar algum jogo de Metroid com algum amigo, eu não sei muito de
programação e começei a estudar tem pouco tempo, mas eu mesmo assim quis
tentar fazer algo que ninguém fez até então: Trazer a experiência AM2R totalmente
de forma cooperativa.

Peço a compreensão da comunidade ao tentar entender o que fiz aqui. Não pensei
em lucros, fama ou qualquer tipo de ganho que poderia ter com isso (o que seria
bem errado), e inclusive estou com muito receio da comunidade de metroid
me julgar por ter utilizado a ajuda de IA para ler e editar boa parte dos códigos,
eu só fiz algo que minha criança interior de 10 anos almejava tanto ter um dia:
Algum co-op de Metroid. Eu espero que as atribuições e todos os créditos
foram dados devidamente, nunca usei Github nem Reddit como plataforma
então não sei direito como postar corretamente isso, mas eu estou tentando.

Diferente do Multitroid original onde os jogadores apenas viam a Samus um do 
outro e compartilhavam o mapa, mas os monstros e salas existiam de forma 
isolada para cada um, este mod conecta o mundo de SR388 entre os jogadores 
em tempo real.

--------------------------------------------------------------------------------
2. PRINCIPAIS NOVIDADES E FUNCIONALIDADES CO-OP
--------------------------------------------------------------------------------

[+] SINCRONIZAÇÃO TOTAL DE INIMIGOS E BOSSES:
    - Monstros comuns, Metroids e chefes têm posição, vida (HP), animações, 
      ataques, projéteis e mortes 100% sincronizados entre quem estiver na sala.
    - Se um jogador mata um monstro ou chefe, ele morre instantaneamente para 
      todos os outros.

[+] SISTEMA DE AUTORIDADE DINÂMICA (TRANSFERÊNCIA DE HOST):
    - O primeiro jogador a entrar na sala se torna a autoridade daquela sala.
    - Se o jogador que é o host da sala sair dela, mas outro jogador permanecer,
      a autoridade é transferida automaticamente e sem engasgos para o jogador 
      que ficou. Os inimigos continuam mortos e nada reaparece indevidamente.

[+] ITENS PRINCIPAIS COMPARTILHADOS:
    - Ao pegar melhorias essenciais de progressão (Mísseis iniciais, Super 
      Mísseis, Power Bombs, Trajes Varia/Gravity, Beams, Space Jump, Screw Attack,
      Speed Booster, etc.), o upgrade é desbloqueado para AMBOS os jogadores.

[+] TANQUES DE EXPANSÃO INDEPENDENTES:
    - Tanques de expansão de energia (E-Tanks) e tanques extras de munição 
      (Mísseis, Super Mísseis e Power Bombs) são individuais.
    - Cada jogador pode explorar e coletar suas próprias expansões, garantindo 
      que cada um construa seu próprio inventário sem "roubar" o do amigo.

[+] BALANCEAMENTO DINÂMICO DE DIFICULDADE (DYNAMIC HP SCALING):
    - Para que o jogo continue desafiador jogando em dupla ou mais:
      * Inimigos comuns ganham +20% de HP para cada jogador adicional na sala.
      * Chefes e Metroids ganham +40% de HP para cada jogador adicional na sala.

[+] RESPAWN INDIVIDUAL NO ÚLTIMO SAVE POINT:
    - Se um jogador morrer, ele ressurge de forma independente no seu próprio 
      último ponto de salvamento visitado, sem desconectar ou interromper a 
      partida do parceiro.

--------------------------------------------------------------------------------
3. COMO INSTALAR (VIA AM2RLAUNCHER)
--------------------------------------------------------------------------------
Requisitos:
- AM2RLauncher (versão 2.3.0 ou mais recente)
- Jogo original limpo: AM2R 1.1 (arquivo data.win do 1.1)

Passo a Passo:
1. Baixe o arquivo: "AM2R_Multitroid_Coop_Launcher_Mod.zip".
2. Abra o AM2RLauncher.
3. Vá na aba "Mod Settings" (Configurações de Mods).
4. Clique em "Install Mod from Zip" (Instalar Mod via Zip) e selecione o arquivo 
   "AM2R_Multitroid_Coop_Launcher_Mod.zip".
5. O launcher irá validar seus arquivos do AM2R 1.1 e criar automaticamente o 
   perfil "AM2R Multitroid Co-op".
6. Clique no perfil e aperte "Play" para iniciar o jogo!

--------------------------------------------------------------------------------
4. COMO HOSPEDAR E CONECTAR NO SERVIDOR (DEDICATED SERVER)
--------------------------------------------------------------------------------
Para jogar juntos, um dos jogadores (ou uma máquina terceira) precisa rodar o 
servidor dedicado:

1. Baixe e extraia o pacote: "AM2R_Multitroid_Coop_Server.zip".
2. Execute o arquivo: "AM2R Server.exe".
3. Uma janela preta do servidor será aberta, aguardando conexões na porta UDP 6510.

Jogando pela mesma rede local (LAN):
- O host vê seu IP local (ex: 192.168.1.X) via Prompt de Comando (ipconfig).
- Os outros jogadores entram no menu multijogador do jogo, digitam esse IP local 
  e a porta 6510, e conectam.

Jogando pela Internet:
- Opção A (Rede Virtual - Mais fácil): Usem o Radmin VPN, ZeroTier ou Tailscale.
  Basta todos entrarem na mesma rede virtual e conectar usando o IP virtual do host.
- Opção B (Port Forwarding): Abra a porta UDP 6510 no roteador do host, direcionando 
  para o IP local do seu computador. Os outros jogadores conectam no seu IP público.

--------------------------------------------------------------------------------
5. COMANDOS E ATALHOS NO JOGO
--------------------------------------------------------------------------------
- No menu principal: Selecione "Multiplayer" para digitar o IP e porta do servidor.
- F1: Abre o chat / lista de status de conexões e jogadores conectados.
- Tab / Menus: Permite customizar cores e detalhes estéticos da Samus.

--------------------------------------------------------------------------------
6. CRÉDITOS E ATRIBUIÇÕES
--------------------------------------------------------------------------------
* Criador do Mod Co-op (Enemy Sync, Dynamic Host, Scaling de HP, Expansões):
  - Samuka_beludo

* Linhagem do Mod Multitroid:
  - VanessaMae1087 (Multitroid Unofficial-Unofficial 1.9.x)
    https://github.com/VanessaMae1087/AM2R-Multitroid-Unofficial-Unofficial
  - DodoBirby (Multitroid Unofficial Patch & YAM2RP)
    https://github.com/DodoBirby/AM2R-Multitroid-Unofficial-Patch
  - milesthenerd (Criador original do Multitroid e da arquitetura de servidor)
    https://github.com/milesthenerd/AM2R-Multitroid

* Desenvolvedores do AM2R Community Updates (1.2 a 1.5.5):
  - Team-Z e AM2R Community Developers
  - AM2RLauncher: https://github.com/AM2R-Community-Developers/AM2RLauncher

* Jogo Base Original (AM2R 1.1):
  - Milton Guasti (DoctorM64) - Direção, Game Design, Arte e Level Design
  - Martin Piecyk - Programação Principal
  - Blog Oficial: http://metroid2remake.blogspot.com/

* Ferramentas Utilizadas:
  - UndertaleModTool (UTMT) por krzys-h, Grossik e comunidade (GPL-3.0)
    https://github.com/krzys-h/UndertaleModTool
  - YAM2RP por DodoBirby (Licença MIT)
    https://github.com/DodoBirby/YAM2RP
  - XDelta3 por Joshua MacDonald (Apache 2.0 / GPL)
    https://github.com/jmacd/xdelta

--------------------------------------------------------------------------------
7. AVISO LEGAL E DIREITOS AUTORAIS (NINTENDO DISCLAIMER)
--------------------------------------------------------------------------------
- METROID, Samus Aran e todos os nomes, músicas, efeitos sonoros e conceitos 
  visuais pertencem exclusivamente à Nintendo Co., Ltd.
- Este projeto é um fan-game sem fins lucrativos, feito por amor à franquia sob 
  princípios de Fair Use educacional.
- Nenhum arquivo ou código binário protegido por direitos autorais da Nintendo 
  ou do AM2R original é distribuído diretamente neste pacote.
================================================================================
