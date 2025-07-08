# EcosystemChallenge — PencilKit Drawing App  
*Desenvolvido por Letícia Bezerra para Apple Developer Academy IFCE*

---

## Visão Geral

Este projeto é um estudo prático e funcional do **PencilKit**, framework da Apple para desenho com Apple Pencil e toque. O objetivo foi criar um app de desenho livre com interface totalmente customizada, explorando as possibilidades e desafios do PencilKit, e entregando uma experiência intuitiva e visualmente agradável.

---

## O que foi feito

- Controles visuais completos para:
  - Caneta, borracha e seleção de cores
  - Ajuste de espessura da caneta e da borracha via sliders e botões
  - Controle de opacidade com slider e botões de incremento/decremento
  - Troca rápida e visual entre caneta e borracha
  - Botões de desfazer e refazer com animações suaves e feedback visual
  - Destaque visual nos botões de cor para indicar a cor ativa
  - Seleção aleatória de cores e tipos de caneta para variar a experiência

- Interface com grade pontilhada de fundo para referência visual

- Prompt criativo com timer para incentivar desafios de desenho

---

## Por que PencilKit e UIKit?

- **PencilKit** oferece desenho de alta performance, suporte nativo à Apple Pencil, e acesso ao modelo de dados do desenho (strokes, inks, paths), permitindo personalização avançada e integração futura com outras frameworks (ex: SharePlay).

- **UIKit** com padrão **MVC** foi escolhido pela sua maturidade e simplicidade para organizar a interface e a lógica, separando claramente dados (Model), interface (View) e controle (Controller).

- Essa combinação é amplamente usada por desenvolvedores iOS para apps com interface gráfica rica e lógica direta.

---

## Arquitetura do Projeto

| Camada      | Responsabilidade                                | Exemplos de Classes/Structs                |
|-------------|------------------------------------------------|--------------------------------------------|
| **Model**   | Estado das ferramentas e configurações         | `DrawingState`, `ToolManager`, `ToolSet`  |
| **View**    | Componentes visuais customizados                | `DotGridView`, `PopupBubbleView`, `ToolButtonsView`, `DrawingHeaderView` |
| **Controller** | Lógica de interação e coordenação da UI       | `DrawingViewController`                     |

---

## Destaques Técnicos do `DrawingViewController`

- Configura e gerencia o `PKCanvasView` para desenho com zoom, pan e background transparente.

- Centraliza o estado das ferramentas via `ToolManager` e sincroniza com o canvas.

- Implementa popups animados para ajuste de espessura e opacidade da caneta e borracha, com controle de visibilidade e interação.

- Atualiza dinamicamente os botões de undo/redo conforme o estado do desenho.

- Gerencia toques para fechar popups automaticamente ao clicar fora, garantindo interface limpa.

- Fornece feedback visual claro para seleção de ferramenta e cor.

- Integração com `undoManager` para desfazer/refazer ações.

---

## Desafios Superados

- **PencilKit não oferece interface pronta**, então tudo foi criado do zero: controles personalizados, sliders responsivos, popups, sincronização de estado e comunicação entre componentes.

- Ajustar corretamente o controle de espessura e opacidade exigiu atenção e testes, especialmente para garantir que a interface respondesse de forma natural e fluida.

---

## Próximos Passos e Melhorias

- Exportação dos desenhos em formatos PNG ou PDF.

- Integração colaborativa via SharePlay para desenho em grupo.

- Múltiplos prompts dinâmicos para desafios variados.

- Animações e efeitos visuais aprimorados nos traços.

- Sincronização com iCloud para backup automático.

---

## Como Rodar

1. Clone o repositório.  
2. Abra no Xcode 14 ou superior.  
3. Rode em simulador ou dispositivo iOS 16+.  
4. Use Apple Pencil ou toque para desenhar.

---
