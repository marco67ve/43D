# 4-3D - Tic-Tac-Toe Tridimensionale (1987-1989)

Gioco di strategia 3D per DOS/VGA - Il primo progetto ludico in QuickBASIC.

## 🎮 Caratteristiche

- **Cubo 4×4×4**: 64 posizioni giocabili
- **76 combinazioni vincenti**: 4 diagonali cubo + 72 linee varie
- **IA competitiva**: Strategia difensiva/offensiva con euristica geometrica
- **Grafica isometrica VGA**: Rendering prospettico custom
- **Supporto mouse**: INT 33h Microsoft Mouse Driver
- **Sistema punteggio**: Top-4 persistente con bonus tempo/mosse
- **Ottimizzato 8088**: Funziona fluido su 4.77 MHz!

## 🕹️ Controlli

- **Mouse**: Clicca sulle posizioni del cubo
- **Tasto destro**: Passa il turno
- **ESC**: Termina

## 🏆 Punteggio
```
Punti = 11.010 - (100 × mosse) - secondi
Obiettivo: 10.000 punti (10 mosse in 10 secondi)
```

## 🔧 Requisiti

- VGA (640×480×16 colori)
- Mouse driver installato (MOUSE.COM)
- DOS 3.0+
- 8088 @ 4.77 MHz minimum

## 📊 Algoritmi

**Mapping 3D → Array lineare:**
```
Index = (piano-1)×16 + (riga-1)×4 + colonna
```

**Strategia IA:**
1. Cerca vittoria immediata
2. Blocca vittoria avversaria
3. Gioca posizioni strategiche (spigoli/centri)

## 🎨 Note Tecniche

- Array lineare 64 elementi simula cubo 4³
- GOSUB per performance su hardware limitato
- Comandi DRAW per grafica vettoriale
- INT 33h per mouse handling
- Debouncing 250ms sui click

## 🐛 Bug Noti

Nessuno! Il codice è stabile dal 1989.

## 📜 Licenza

Public Domain (PD 1989)

---

*"Il codice può sembrare semplice, ma funziona perfettamente da 37 anni."*  
— Marco da Venezia

## 📖 Documentazione

- **[Manuale completo](43D.TXT)** - Istruzioni dettagliate, controlli, strategia
- **[Guida rapida](43D-QUICK.TXT)** - Reference card per iniziare subito

### ⚠️ Note Importanti

**REQUISITI OBBLIGATORI:**
- Scheda grafica **VGA** (640×480×16 colori)
- **Mouse** con driver installato (MOUSE.COM)

Il programma **terminerà automaticamente** se manca VGA o mouse.

**PRIMO AVVIO:**
Per far iniziare il computer, premi il **tasto destro del mouse**
all'inizio della partita. Di default il giocatore ha sempre
la prima mossa.
```

---

## **PERCHÉ IL FILE DOC È IMPORTANTE:**
```
╔════════════════════════════════════════════════════╗
║  SENZA ISTRUZIONI:                                 ║
║  • "Come si gioca?"                                ║
║  • "Serve il mouse?"                               ║
║  • "Perché non parte?"                             ║
║  • "Come faccio iniziare il computer?"             ║
║  • "Cos'è questo cubo?"                            ║
║                                                    ║
║  CON 43D.DOC:                                      ║
║  • Tutto chiaro! ✅                                ║
║  • Requisiti espliciti ✅                          ║
║  • Controlli spiegati ✅                           ║
║  • Strategia suggerita ✅                          ║
║  • Risoluzione problemi ✅                         ║
╚════════════════════════════════════════════════════╝
```

## 📸 Screenshots

![Gameplay](43D-01.png)

*Partita in corso - Il computer (blu) completa la diagonale principale 
del cubo vincendo con 4 mosse in linea (1→22→43→64). Grafica VGA 
isometrica con UI professionale.*

### Design Highlights
- Cubo 4×4×4 in prospettiva isometrica
- Color coding: Rosso (giocatore) vs Blu (computer)
- Linea gialla evidenzia il tris vincente
- UI organizzata: Info (sx), Gioco (centro), Controlli (dx)
- Top-4 scoreboard stile arcade

### Principi di Design
- Geometria pulita e precisa
- Contrasti chiari per leggibilità
- Layout bilanciato (golden ratio)
- Feedback visivo immediato
- Palette VGA 16 colori ottimizzata

