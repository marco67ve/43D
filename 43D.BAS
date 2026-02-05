'4-3D versione 3.03 - 1987/89
'Richiede VGA e mouse
'Senza VGA o superiore, restituisce il controllo al DOS
'Se mouse non istallato, esce al DOS
'Ok su 8088/4.77 MHz

DECLARE SUB Editor (Edit$)
DECLARE SUB Disegna ()
DECLARE SUB MostraRecord ()
DECLARE SUB Punteggi ()
DECLARE SUB Fine ()

COMMON SHARED T, Time

  DEF SEG = &H40
  IF NOT (PEEK(&H17) AND &H20) <> 0 THEN
    PRINT "Il gioco richiede che il mouse sia installato"
    END
  END IF
  DEF SEG

  CLEAR
  DIM Array(64)
  DIM SHARED TBr$(6)
  DIM SHARED inreg%(10), outreg%(10)

  Disegna
  MostraRecord
   
  T = TIMER
  RANDOMIZE T

Player:

  IF Pass AND Time = 0 THEN Turn = 1: PriMossa = 1000
  IF Turn = 1 GOTO Computer
   
  k$ = INKEY$: IF k$ = CHR$(27) THEN Fine
  
  inreg%(0) = 3: CALL INT86OLD(&H33, inreg%(), outreg%())
   
  kM = outreg%(1)
  xM = outreg%(2)
  yM = outreg%(3)
 
  A = 0
  x = 0
  y = 0
 
  'primo piano
  IF yM > 20 AND yM < 30 THEN
    A = CINT(1 + (outreg%(2) - 240) / 75)
    IF A < 1 OR A > 4 THEN A = 0
    y = 25: x = (240 - 75) + 75 * A
  END IF
  IF yM > 40 AND yM < 50 THEN
    A = CINT(1 + 4 + (outreg%(2) - 220) / 75)
    IF A < 5 OR A > 8 THEN A = 0
    y = 45: x = (220 - 75) + 75 * (A - 4)
  END IF
  IF yM > 60 AND yM < 70 THEN
    A = CINT(1 + 8 + (outreg%(2) - 200) / 75)
    IF A < 9 OR A > 12 THEN A = 0
    y = 65: x = (200 - 75) + 75 * (A - 8)
  END IF
  IF yM > 80 AND yM < 90 THEN
    A = CINT(1 + 12 + (outreg%(2) - 180) / 75)
    IF A < 13 OR A > 16 THEN A = 0
    y = 85: x = (180 - 75) + 75 * (A - 12)
  END IF
  'secondo piano
  IF yM > 95 AND yM < 105 THEN
    A = CINT(1 + (outreg%(2) - 240) / 75) + 16
    IF A < 17 OR A > 20 THEN A = 0
    y = 100: x = (240 - 75) + 75 * (A - 16)
  END IF
  IF yM > 115 AND yM < 125 THEN
    A = CINT(1 + 4 + (outreg%(2) - 220) / 75) + 16
    IF A < 21 OR A > 24 THEN A = 0
    y = 120: x = (220 - 75) + 75 * (A - 4 - 16)
  END IF
  IF yM > 135 AND yM < 145 THEN
    A = CINT(1 + 8 + (outreg%(2) - 200) / 75) + 16
    IF A < 25 OR A > 28 THEN A = 0
    y = 140: x = (200 - 75) + 75 * (A - 8 - 16)
  END IF
  IF yM > 155 AND yM < 165 THEN
    A = CINT(1 + 12 + (outreg%(2) - 180) / 75) + 16
    IF A < 29 OR A > 32 THEN A = 0
    y = 160: x = (180 - 75) + 75 * (A - 12 - 16)
  END IF
  'terzo piano
  IF yM > 170 AND yM < 180 THEN
    A = CINT(1 + (outreg%(2) - 240) / 75) + 32
    IF A < 33 OR A > 36 THEN A = 0
    y = 175: x = (240 - 75) + 75 * (A - 32)
  END IF
  IF yM > 190 AND yM < 200 THEN
    A = CINT(1 + 4 + (outreg%(2) - 220) / 75) + 32
    IF A < 37 OR A > 40 THEN A = 0
    y = 195: x = (220 - 75) + 75 * (A - 4 - 32)
  END IF
  IF yM > 210 AND yM < 220 THEN
    A = CINT(1 + 8 + (outreg%(2) - 200) / 75) + 32
    IF A < 41 OR A > 44 THEN A = 0
    y = 215: x = (200 - 75) + 75 * (A - 8 - 32)
  END IF
  IF yM > 230 AND yM < 240 THEN
    A = CINT(1 + 12 + (outreg%(2) - 180) / 75) + 32
    IF A < 45 OR A > 48 THEN A = 0
    y = 235: x = (180 - 75) + 75 * (A - 12 - 32)
  END IF
   
  'quarto piano
  IF yM > 245 AND yM < 255 THEN
    A = CINT(1 + (outreg%(2) - 240) / 75) + 48
    IF A < 49 OR A > 52 THEN A = 0
    y = 250: x = (240 - 75) + 75 * (A - 48)
  END IF
  IF yM > 265 AND yM < 275 THEN
    A = CINT(1 + 4 + (outreg%(2) - 220) / 75) + 48
    IF A < 53 OR A > 56 THEN A = 0
    y = 270: x = (220 - 75) + 75 * (A - 4 - 48)
  END IF
  IF yM > 285 AND yM < 295 THEN
    A = CINT(1 + 8 + (outreg%(2) - 200) / 75) + 48
    IF A < 57 OR A > 60 THEN A = 0
    y = 290: x = (200 - 75) + 75 * (A - 8 - 48)
  END IF
  IF yM > 305 AND yM < 315 THEN
    A = CINT(1 + 12 + (outreg%(2) - 180) / 75) + 48
    IF A < 61 OR A > 64 THEN A = 0
    y = 310: x = (180 - 75) + 75 * (A - 12 - 48)
  END IF
  
  'LOCATE 28, 1: PRINT A; x; y
  
  IF kM THEN click = TIMER: WHILE TIMER - click < .25: WEND
  IF kM = 2 THEN Pass = 1
  IF kM = 1 THEN
    IF xM > 520 AND xM < 625 THEN
      IF yM > 13 AND yM < 70 THEN Fine
      IF yM > 93 AND yM < 150 THEN RUN
    END IF
    IF A = 0 GOTO Player
    Turn = 4
    value = 1
    GOSUB Ok
    IF Ok = 0 GOTO Player ELSE GOSUB Verify
    value = 9
    tris = 27
    Time = Time + 1
    Turn = 1
  END IF
 
  GOTO Player

Computer:
   
  Pass = 0
  GOSUB Qtris1
    IF Qtris = tris THEN
      IF Array(22) = 0 THEN B = 22
      IF Array(43) = 0 THEN B = 43
      IF Array(64) = 0 THEN B = 64
      IF Array(1) = 0 THEN B = 1
      GOTO Replay
    END IF
     
  GOSUB Qtris2
    IF Qtris = tris THEN
      IF Array(27) = 0 THEN B = 27
      IF Array(38) = 0 THEN B = 38
      IF Array(49) = 0 THEN B = 49
      IF Array(16) = 0 THEN B = 16
      GOTO Replay
    END IF

  GOSUB Qtris3
    IF Qtris = tris THEN
      IF Array(23) = 0 THEN B = 23
      IF Array(42) = 0 THEN B = 42
      IF Array(61) = 0 THEN B = 61
      IF Array(4) = 0 THEN B = 4
      GOTO Replay
    END IF
     
  GOSUB Qtris4
    IF Qtris = tris THEN
      IF Array(26) = 0 THEN B = 26
      IF Array(39) = 0 THEN B = 39
      IF Array(52) = 0 THEN B = 52
      IF Array(13) = 0 THEN B = 13
      GOTO Replay
    END IF
  
  FOR i = 0 TO 3
    GOSUB Qtris5
    IF Qtris = tris THEN
      IF Array(21 + i) = 0 THEN B = 21 + i
      IF Array(41 + i) = 0 THEN B = 41 + i
      IF Array(61 + i) = 0 THEN B = 61 + i
      IF Array(1 + i) = 0 THEN B = 1 + i
      GOTO Replay
    END IF
    GOSUB Qtris6
    IF Qtris = tris THEN
      IF Array(25 + i) = 0 THEN B = 25 + i
      IF Array(37 + i) = 0 THEN B = 37 + i
      IF Array(49 + i) = 0 THEN B = 49 + i
      IF Array(13 + i) = 0 THEN B = 13 + i
      GOTO Replay
    END IF
  NEXT

  FOR i = 0 TO 12 STEP 4
    GOSUB Qtris7
    IF Qtris = tris THEN
      IF Array(18 + i) = 0 THEN B = 18 + i
      IF Array(35 + i) = 0 THEN B = 35 + i
      IF Array(52 + i) = 0 THEN B = 52 + i
      IF Array(1 + i) = 0 THEN B = 1 + i
      GOTO Replay
    END IF
    GOSUB Qtris8
    IF Qtris = tris THEN
      IF Array(19 + i) = 0 THEN B = 19 + i
      IF Array(34 + i) = 0 THEN B = 34 + i
      IF Array(4 + i) = 0 THEN B = 4 + i
      IF Array(49 + i) = 0 THEN B = 49 + i
      GOTO Replay
    END IF
  NEXT

  FOR i = 0 TO 48 STEP 16
    GOSUB Qtris9
    IF Qtris = tris THEN
      IF Array(6 + i) = 0 THEN B = 6 + i
      IF Array(11 + i) = 0 THEN B = 11 + i
      IF Array(16 + i) = 0 THEN B = 16 + i
      IF Array(1 + i) = 0 THEN B = 1 + i
      GOTO Replay
    END IF
    GOSUB Qtris10
    IF Qtris = tris THEN
      IF Array(7 + i) = 0 THEN B = 7 + i
      IF Array(10 + i) = 0 THEN B = 10 + i
      IF Array(13 + i) = 0 THEN B = 13 + i
      IF Array(4 + i) = 0 THEN B = 4 + i
      GOTO Replay
    END IF
  NEXT
  
  FOR j = 0 TO 3
    FOR i = 0 TO 12 STEP 4
    GOSUB Qtris11
      IF Qtris = tris THEN
        IF Array(17 + i + j) = 0 THEN B = 17 + i + j
        IF Array(33 + i + j) = 0 THEN B = 33 + i + j
        IF Array(49 + i + j) = 0 THEN B = 49 + i + j
        IF Array(1 + i + j) = 0 THEN B = 1 + i + j
        GOTO Replay
      END IF
    NEXT
  NEXT
       
  FOR j = 0 TO 48 STEP 16
    FOR i = 0 TO 3
    GOSUB Qtris12
      IF Qtris = tris THEN
        IF Array(5 + i + j) = 0 THEN B = 5 + i + j
        IF Array(9 + i + j) = 0 THEN B = 9 + i + j
        IF Array(13 + i + j) = 0 THEN B = 13 + i + j
        IF Array(1 + i + j) = 0 THEN B = 1 + i + j
        GOTO Replay
      END IF
    NEXT
  NEXT
  
  FOR i = 0 TO 12 STEP 4
    FOR j = 0 TO 48 STEP 16
    GOSUB Qtris13
      IF Qtris = tris THEN
        IF Array(2 + i + j) = 0 THEN B = 2 + i + j
        IF Array(3 + i + j) = 0 THEN B = 3 + i + j
        IF Array(4 + i + j) = 0 THEN B = 4 + i + j
        IF Array(1 + i + j) = 0 THEN B = 1 + i + j
        GOTO Replay
      END IF
    NEXT
  NEXT

  IF tris = 27 THEN tris = 3: GOTO Computer
  IF tris = 3 THEN tris = 2: GOTO Computer
  IF tris = 2 THEN tris = 18: GOTO Computer
  IF tris = 18 THEN tris = 9: GOTO Computer
   
  'prima risposta
  IF A = 1 OR A = 4 OR A = 13 OR A = 16 OR A = 49 OR A = 52 OR A = 61 OR A = 64 THEN
    'sugli spigoli del cubo
    pr = INT(8 * RND + 1)
    IF pr = 1 THEN B = 1
    IF pr = 2 THEN B = 4
    IF pr = 3 THEN B = 13
    IF pr = 4 THEN B = 16
    IF pr = 5 THEN B = 49
    IF pr = 6 THEN B = 52
    IF pr = 7 THEN B = 61
    IF pr = 8 THEN B = 64
  ELSE
    'sul perimetro dei piani esclusi angoli
    FOR i = 0 TO 63 STEP 16
      pr = INT(2 * RND)
      IF A = i + 2 OR A = i + 3 THEN
        IF pr = 0 THEN B = i + 1 ELSE B = i + 4
      END IF
      IF A = i + 5 OR A = i + 9 THEN
        IF pr = 0 THEN B = i + 1 ELSE B = i + 13
      END IF
      IF A = i + 8 OR A = i + 12 THEN
        IF pr = 0 THEN B = i + 4 ELSE B = i + 16
      END IF
      IF A = i + 14 OR A = i + 15 THEN
        IF pr = 0 THEN B = i + 13 ELSE B = i + 16
      END IF
      IF A = i + 6 OR A = i + 11 THEN
        IF pr = 0 THEN B = i + 1 ELSE B = i + 16
      END IF
      IF A = i + 7 OR A = i + 10 THEN
        IF pr = 0 THEN B = i + 4 ELSE B = i + 13
      END IF

      pr = INT(3 * RND)
      'sugli angoli dei piani
      IF A = i + 1 THEN
        IF pr = 0 THEN B = i + 4
        IF pr = 1 THEN B = i + 13
        IF pr = 2 THEN B = i + 16
      END IF
      IF A = i + 4 THEN
        IF pr = 0 THEN B = i + 1
        IF pr = 1 THEN B = i + 13
        IF pr = 2 THEN B = i + 16
      END IF
      IF A = i + 13 THEN
        IF pr = 0 THEN B = i + 1
        IF pr = 1 THEN B = i + 4
        IF pr = 2 THEN B = i + 16
      END IF
      IF A = i + 16 THEN
        IF pr = 0 THEN B = i + 1
        IF pr = 1 THEN B = i + 4
        IF pr = 2 THEN B = i + 13
      END IF
    NEXT
  END IF

Replay:

  GOSUB XY
  xC = x1: yC = y1
  GOSUB Ok
  IF Ok = 0 GOTO Computer ELSE GOSUB Verify
  Turn = 4
  GOTO Player

XY:

  IF B = 1 THEN x1 = 240: y1 = 25
  IF B = 2 THEN x1 = 315: y1 = 25
  IF B = 3 THEN x1 = 390: y1 = 25
  IF B = 4 THEN x1 = 465: y1 = 25
 
  IF B = 5 THEN x1 = 220: y1 = 45
  IF B = 6 THEN x1 = 295: y1 = 45
  IF B = 7 THEN x1 = 370: y1 = 45
  IF B = 8 THEN x1 = 445: y1 = 45
 
  IF B = 9 THEN x1 = 200: y1 = 65
  IF B = 10 THEN x1 = 275: y1 = 65
  IF B = 11 THEN x1 = 350: y1 = 65
  IF B = 12 THEN x1 = 425: y1 = 65
 
  IF B = 13 THEN x1 = 180: y1 = 85
  IF B = 14 THEN x1 = 255: y1 = 85
  IF B = 15 THEN x1 = 330: y1 = 85
  IF B = 16 THEN x1 = 405: y1 = 85
 
  IF B = 17 THEN x1 = 240: y1 = 100
  IF B = 18 THEN x1 = 315: y1 = 100
  IF B = 19 THEN x1 = 390: y1 = 100
  IF B = 20 THEN x1 = 465: y1 = 100
 
  IF B = 21 THEN x1 = 220: y1 = 120
  IF B = 22 THEN x1 = 295: y1 = 120
  IF B = 23 THEN x1 = 370: y1 = 120
  IF B = 24 THEN x1 = 445: y1 = 120
   
  IF B = 25 THEN x1 = 200: y1 = 140
  IF B = 26 THEN x1 = 275: y1 = 140
  IF B = 27 THEN x1 = 350: y1 = 140
  IF B = 28 THEN x1 = 425: y1 = 140
 
  IF B = 29 THEN x1 = 180: y1 = 160
  IF B = 30 THEN x1 = 255: y1 = 160
  IF B = 31 THEN x1 = 330: y1 = 160
  IF B = 32 THEN x1 = 405: y1 = 160
 
  IF B = 33 THEN x1 = 240: y1 = 175
  IF B = 34 THEN x1 = 315: y1 = 175
  IF B = 35 THEN x1 = 390: y1 = 175
  IF B = 36 THEN x1 = 465: y1 = 175
 
  IF B = 37 THEN x1 = 220: y1 = 195
  IF B = 38 THEN x1 = 295: y1 = 195
  IF B = 39 THEN x1 = 370: y1 = 195
  IF B = 40 THEN x1 = 445: y1 = 195
   
  IF B = 41 THEN x1 = 200: y1 = 215
  IF B = 42 THEN x1 = 275: y1 = 215
  IF B = 43 THEN x1 = 350: y1 = 215
  IF B = 44 THEN x1 = 425: y1 = 215
 
  IF B = 45 THEN x1 = 180: y1 = 235
  IF B = 46 THEN x1 = 255: y1 = 235
  IF B = 47 THEN x1 = 330: y1 = 235
  IF B = 48 THEN x1 = 405: y1 = 235
 
  IF B = 49 THEN x1 = 240: y1 = 250
  IF B = 50 THEN x1 = 315: y1 = 250
  IF B = 51 THEN x1 = 390: y1 = 250
  IF B = 52 THEN x1 = 465: y1 = 250
 
  IF B = 53 THEN x1 = 220: y1 = 270
  IF B = 54 THEN x1 = 295: y1 = 270
  IF B = 55 THEN x1 = 370: y1 = 270
  IF B = 56 THEN x1 = 445: y1 = 270
 
  IF B = 57 THEN x1 = 200: y1 = 290
  IF B = 58 THEN x1 = 275: y1 = 290
  IF B = 59 THEN x1 = 350: y1 = 290
  IF B = 60 THEN x1 = 425: y1 = 290
 
  IF B = 61 THEN x1 = 180: y1 = 310
  IF B = 62 THEN x1 = 255: y1 = 310
  IF B = 63 THEN x1 = 330: y1 = 310
  IF B = 64 THEN x1 = 405: y1 = 310
   
  RETURN

Ok:

  IF Turn = 1 THEN c = B ELSE c = A
   
  IF Array(c) = 0 THEN
    Ok = 1
    Array(c) = value
    IF Turn = 4 THEN xC = x: yC = y
    inreg%(0) = 2: CALL INT86OLD(&H33, inreg%(), outreg%())
    FOR r = 1 TO 6
      CIRCLE (xC, yC), r, Turn, , , .6
    NEXT
    CIRCLE (xC, yC), 7, 15, , , .6
    SOUND 6000, .1
    inreg%(0) = 1: CALL INT86OLD(&H33, inreg%(), outreg%())
  ELSE
    Ok = 0
  END IF
 
  RETURN

Win:

  inreg%(0) = 0: CALL INT86OLD(&H33, inreg%(), outreg%())
 
  B = pI
  GOSUB XY
  x2 = x1: y2 = y1
  B = pF
  GOSUB XY
  LINE (x1, y1)-(x2, y2), 14
 
  LINE (25, 280)-(140, 430), 0, BF
  LINE (15, 270)-(130, 420), 14, BF
  LINE (22, 277)-(123, 413), 0, BF
  LINE (15, 270)-(130, 420), 15, B
   
  COLOR 11: LOCATE 24, 5: PRINT USING "MOSSE:  ##"; Time;
  
  IF Turn = 4 THEN
    LOCATE 20, 5: PRINT "HAI VINTO!"
    SOUND 1000, 5
    Punteggi
  ELSE
    LOCATE 20, 5: PRINT "HAI PERSO!"
    SOUND 50, 5
  END IF
   
  inreg%(0) = 1: CALL INT86OLD(&H33, inreg%(), outreg%())
   
  WHILE k$ <> CHR$(27)
    k$ = INKEY$
    IF k$ = CHR$(27) THEN Fine
    inreg%(0) = 3: CALL INT86OLD(&H33, inreg%(), outreg%())
    kM = outreg%(1)
    xM = outreg%(2)
    yM = outreg%(3)
    IF xM > 520 AND xM < 625 AND kM THEN
      IF yM > 13 AND yM < 70 THEN Fine
      IF yM > 93 AND yM < 150 THEN RUN
    END IF
  WEND

Qtris1:
  'Qtris diagonale del cubo
  pI = 1: pF = 64
  Qtris = Array(1) + Array(22) + Array(43) + Array(64)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN

Qtris2:
  'Qtris diagonale del cubo
  pI = 16: pF = 49
  Qtris = Array(16) + Array(27) + Array(38) + Array(49)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN

Qtris3:
  'Qtris diagonale del cubo
  pI = 4: pF = 61
  Qtris = Array(4) + Array(23) + Array(42) + Array(61)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN

Qtris4:
  'Qtris diagonale del cubo
  pI = 13: pF = 52
  Qtris = Array(13) + Array(26) + Array(39) + Array(52)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN

Qtris5:
  'Qtris diagonali facce verticali di profilo
  pI = 1 + i: pF = 61 + i
  Qtris = Array(1 + i) + Array(21 + i) + Array(41 + i) + Array(61 + i)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN

Qtris6:
  pI = 13 + i: pF = 49 + i
  Qtris = Array(13 + i) + Array(25 + i) + Array(37 + i) + Array(49 + i)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN

Qtris7:
  'Qtris diagonali facce verticali di prospetto
  pI = 1 + i: pF = 52 + i
  Qtris = Array(1 + i) + Array(18 + i) + Array(35 + i) + Array(52 + i)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN
     
Qtris8:
  pI = 4 + i: pF = 49 + i
  Qtris = Array(4 + i) + Array(19 + i) + Array(34 + i) + Array(49 + i)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN

Qtris9:
  'Qtris orrizzontali diagonali
  pI = 1 + i: pF = 16 + i
  Qtris = Array(1 + i) + Array(6 + i) + Array(11 + i) + Array(16 + i)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN

Qtris10:
  pI = 4 + i: pF = 13 + i
  Qtris = Array(4 + i) + Array(7 + i) + Array(10 + i) + Array(13 + i)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN

Qtris11:
  'Qtris verticali
  pI = 1 + i + j: pF = 49 + i + j
  Qtris = Array(1 + i + j) + Array(17 + i + j) + Array(33 + i + j) + Array(49 + i + j)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN
 
Qtris12:
  'Qtris orrizzontali in largo
  pI = 1 + i + j: pF = 13 + i + j
  Qtris = Array(1 + i + j) + Array(5 + i + j) + Array(9 + i + j) + Array(13 + i + j)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN

Qtris13:
  'Qtris orrizzontali in lungo
  pI = 1 + i + j: pF = 4 + i + j
  Qtris = Array(1 + i + j) + Array(2 + i + j) + Array(3 + i + j) + Array(4 + i + j)
  IF Qtris = 4 OR Qtris = 36 THEN RETURN Win
  RETURN

Verify:

  GOSUB Qtris1
  GOSUB Qtris2
  GOSUB Qtris3
  GOSUB Qtris4
  FOR i = 0 TO 3
    GOSUB Qtris5
    GOSUB Qtris6
  NEXT
  FOR i = 0 TO 12 STEP 4
    GOSUB Qtris7
    GOSUB Qtris8
  NEXT
  FOR i = 0 TO 48 STEP 16
    GOSUB Qtris9
    GOSUB Qtris10
  NEXT
  FOR j = 0 TO 3
    FOR i = 0 TO 12 STEP 4
      GOSUB Qtris11
    NEXT
  NEXT
  FOR j = 0 TO 48 STEP 16
    FOR i = 0 TO 3
      GOSUB Qtris12
    NEXT
  NEXT
  FOR i = 0 TO 12 STEP 4
    FOR j = 0 TO 48 STEP 16
      GOSUB Qtris13
    NEXT
  NEXT

  RETURN

SUB Disegna

  SCREEN 12: CLS

  inreg%(0) = 0: CALL INT86OLD(&H33, inreg%(), outreg%())

  PAINT (1, 175), "UUUUU"
  LINE (160, 23)-(510, 333), 0, BF
  LINE (150, 13)-(500, 323), 7, BF
  LINE (150, 13)-(500, 323), 15, B
  LINE (0, 0)-(639, 479), 15, B

  y = 25
  FOR x = 240 TO 180 STEP -20
    PSET (x, y)
    DRAW "c0d225r75u225r75d225r75u225"
    y = y + 20
  NEXT
  
  FOR y = 85 TO 375 STEP 75
    PSET (180, y)
    DRAW "c0r225e60l225g60br75e60br75g60 br75be20l225be20r225"
  NEXT
  
  LINE (25, 23)-(140, 220), 0, BF
  LINE (15, 13)-(130, 210), 3, BF
  LINE (23, 20)-(123, 203), 0, BF
  LINE (15, 13)-(130, 210), 15, B
  
  LINE (533, 23)-(630, 80), 0, BF
  LINE (525, 13)-(620, 70), 4, BF
  LINE (532, 20)-(613, 63), 0, BF
  LINE (525, 13)-(621, 70), 15, B
  LOCATE 3, 69: PRINT "TERMINA"

  LINE (535, 103)-(630, 160), 0, BF
  LINE (525, 93)-(620, 150), 2, BF
  LINE (532, 100)-(613, 143), 0, BF
  LINE (525, 93)-(621, 150), 15, B
  LOCATE 8, 69: PRINT "RIPARTI"
  
  xu$ = "c14r30f1l32g1r34 g1l32f1r30g1l27"
  xC$ = "c14r27f1l30g1r32 g1l30f1r27"
  xd$ = "c14r27f1l30g1r32 f1l34f1r32g1l30"
  yl$ = "c14d21g1u23h1d25 g1u27g1d25h1u23"
  yr$ = "c14d23g1u25h1d27 h1u25g1d23h1u21"

  x = 60: y = 40
  PSET (x + 2, y + 26): DRAW xC$
  PSET (x + 37, y + 1): DRAW yr$
  PSET (x + 37, y + 32): DRAW yr$
  PSET (x + 0, y + 2): DRAW yl$
  x = 30: y = 110
  PSET (x + 1, y - 5): DRAW xu$
  PSET (x + 2, y + 26): DRAW xC$
  PSET (x + 37, y + 1): DRAW yr$
  PSET (x + 37, y + 32): DRAW yr$
  PSET (x + 2, y + 56): DRAW xd$
  x = 80
  PSET (x + 2, y + 26): DRAW xC$
  PSET (x + 37, y + 1): DRAW yr$
  PSET (x + 37, y + 32): DRAW yr$
  PSET (x + 2, y + 56): DRAW xd$
  PSET (x + -2, y + 33): DRAW yl$
  
  FOR i = 1 TO 4
    FOR x = 180 TO 475 STEP 75
      FOR y = 85 TO 310 STEP 75
        CIRCLE (x + xi, y - yi), 3, 8
      NEXT
    NEXT
    xi = xi + 20: yi = yi + 20
  NEXT
 
  inreg%(0) = 1: CALL INT86OLD(&H33, inreg%(), outreg%())
  
END SUB

SUB Editor (Edit$)
 
  DIM Edit$(0 TO 15)
 
  r1 = CSRLIN: C1 = POS(1): Limit = 0
 
  DO
  A$ = INKEY$
    IF LEN(A$) = 1 THEN
      col = POS(1): n = 1 + col - C1
      IF A$ = CHR$(13) THEN
       FOR i = 1 TO n - 1: Edit$ = Edit$ + Edit$(i): NEXT
       IF Edit$ = "" THEN Edit$ = "43D"
       LOCATE 22, 5: PRINT Edit$
       EXIT DO
      END IF
      IF A$ = CHR$(8) THEN
       IF col < C1 + 1 THEN col = C1 + 1
       LOCATE r1, col - 1: PRINT "."; : LOCATE r1, col - 1
       Edit$(n - 1) = ""
      END IF
      no = ASC(UCASE$(A$))
      IF (no > 64 AND no < 91) OR (no > 47 AND no < 58) OR no = 32 THEN
       IF col > C1 + 9 + Limit THEN
        col = C1 + 9 + Limit
        n = 9 + Limit + 1
       END IF
       Edit$(n) = UCASE$(A$)
       LOCATE r1, col: PRINT CHR$(no);
      ELSE
       A$ = ""
      END IF
      Edit$(n) = UCASE$(A$)
    END IF
  LOOP

END SUB

SUB Fine

  inreg%(0) = 0: CALL INT86OLD(&H33, inreg%(), outreg%())
  
  A$ = "컴컴컴컴컴컴컴� 43D - Version 3.03 - PD 1989 By Marco da Venezia 컴컴컴컴컴컴컴�"
 
  DO
    c = c + 1
    IF c = 8 THEN c = 1
    COLOR 8 + c: LOCATE 30, 1: PRINT A$;
    LOCATE 3, 69: PRINT "HIT ESC"
    SLEEP (1)
  LOOP WHILE INKEY$ = ""
  SCREEN 0
  END

END SUB

SUB MostraRecord

  inreg%(0) = 2: CALL INT86OLD(&H33, inreg%(), outreg%())

  LINE (230, 350)-(435, 470), 0, BF
  LINE (220, 340)-(425, 460), 1, BF
  LINE (228, 348)-(417, 452), 0, BF
  LINE (231, 374)-(413, 374), 1, BF
  LINE (219, 339)-(426, 461), 15, B
  
  COLOR 15
  LOCATE 23, 37: PRINT "T O P - 4"
  LOCATE 25, 31: PRINT "1  -"
  LOCATE , 31:   PRINT "2  -"
  LOCATE , 31:   PRINT "3  -"
  LOCATE , 31:   PRINT "4  -"
  LOCATE 25
 
  OPEN "SCORES.43D" FOR APPEND AS #1: CLOSE
  OPEN "SCORES.43D" FOR INPUT AS #1
  WHILE NOT EOF(1)
    A = A + 1
    INPUT #1, r$
    TBr$(A) = r$
    LOCATE , 34: PRINT r$
  WEND
  CLOSE

  inreg%(0) = 1: CALL INT86OLD(&H33, inreg%(), outreg%())

END SUB

SUB Punteggi
  
 'P = 10000 in 10 mosse in 10 secondi
  P = INT(11010 - (100 * Time) - (TIMER - T)) + PriMossa
  
  IF P <= VAL(TBr$(4)) THEN
    LOCATE 22, 5
    IF P > 0 THEN PRINT USING "TOP: #####"; P ELSE PRINT " OUT TIME "
    EXIT SUB
  END IF
   
  LOCATE 19, 5: PRINT "IMMETTI IL"
  LOCATE 20, 5: PRINT " TUO NOME "
   
  LOCATE 22, 5: PRINT "..........";
  LOCATE , 5, 1
 
  Editor Edit$

  Name$ = Edit$

  TBr$(5) = STR$(P) + " - " + Name$

  FOR i = 1 TO 5
  FOR j = 1 TO 5
    IF VAL(TBr$(j)) < VAL(TBr$(j + 1)) THEN SWAP TBr$(j), TBr$(j + 1)
  NEXT
  NEXT

  OPEN "SCORES.43D" FOR OUTPUT AS #1
  FOR i = 1 TO 4
    PRINT #1, TBr$(i)
  NEXT
  CLOSE
  
  MostraRecord

END SUB

