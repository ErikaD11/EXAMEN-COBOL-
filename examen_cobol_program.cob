
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXAMEN-COBOL.
       AUTHOR. STRAPPBERRY.
       DATE-WRITTEN. 06/2024.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CSV-FILE ASSIGN TO "datos.csv"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  CSV-FILE.
       01  CSV-RECORD PIC X(200).

       WORKING-STORAGE SECTION.
       01  WS-OPTION PIC X.
       01  WS-NAME PIC X(30).
       01  WS-LASTNAME PIC X(30).
       01  WS-EMAIL PIC X(50).
       01  WS-PASSWORD PIC X(30).

       01  WS-MENU.
           05  FILLER PIC X(10) VALUE "C D - CD".
           05  FILLER PIC X(15) VALUE "Capturar Datos".
           05  FILLER PIC X(10) VALUE "G A - GA".
           05  FILLER PIC X(20) VALUE "Generar Archivo CSV".
           05  FILLER PIC X(10) VALUE "E S C".
           05  FILLER PIC X(05) VALUE "Salir".

       01  WS-RECORD-LINE PIC X(200).

       SCREEN SECTION.
       01  LOGIN-SCREEN.
           05 BLANK SCREEN.
           05 LINE 3 COLUMN 20 VALUE "Introduzca sus Datos".
           05 LINE 5 COLUMN 20 VALUE "Nombre de Usuario:".
           05 LINE 5 COLUMN 40 PIC X(30) USING WS-NAME.
           05 LINE 6 COLUMN 20 VALUE "Contraseña:".
           05 LINE 6 COLUMN 40 PIC X(30) USING WS-PASSWORD.
           05 LINE 8 COLUMN 20 VALUE "E - Entrar".

       PROCEDURE DIVISION.
       MAIN-PARAGRAPH.
           PERFORM LOGIN-PROCESS.

       MENU-PARAGRAPH.
           DISPLAY WS-MENU.
           ACCEPT WS-OPTION.
           EVALUATE WS-OPTION
               WHEN "CD"
                   PERFORM CAPTURAR-DATOS
               WHEN "GA"
                   PERFORM GENERAR-CSV
               WHEN "ESC"
                   PERFORM EXIT-PROGRAM
               WHEN OTHER
                   DISPLAY "Opcion no valida."
           END-EVALUATE
           GO TO MENU-PARAGRAPH.

       LOGIN-PROCESS.
           DISPLAY LOGIN-SCREEN.
           ACCEPT WS-NAME.
           ACCEPT WS-PASSWORD.

       CAPTURAR-DATOS.
           DISPLAY "Introduzca sus Datos".
           ACCEPT WS-NAME.
           ACCEPT WS-LASTNAME.
           ACCEPT WS-EMAIL.
           ACCEPT WS-PASSWORD.

       GENERAR-CSV.
           OPEN OUTPUT CSV-FILE.
           STRING WS-NAME "," WS-LASTNAME "," WS-EMAIL "," WS-PASSWORD
               DELIMITED BY SIZE INTO WS-RECORD-LINE.
           WRITE CSV-RECORD FROM WS-RECORD-LINE.
           CLOSE CSV-FILE.
           DISPLAY "Archivo CSV generado exitosamente.".

       EXIT-PROGRAM.
           DISPLAY "Gracias por usar el programa. Saliendo...".
           STOP RUN.

       END PROGRAM EXAMEN-COBOL.
