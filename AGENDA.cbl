       IDENTIFICATION DIVISION.
       PROGRAM-ID. AGENDA.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT AGENDA ASSIGN TO "AGENDA.DAT"
                 ORGANIZATION IS INDEXED
                 ACCESS MODE IS DYNAMIC
                 RECORD KEY IS agenda-code
                 FILE STATUS IS agenda-status.

       DATA DIVISION.
       FILE SECTION.

       FD AGENDA.
       01  Agenda-Rec.
           02  agenda-code             PIC 9(6).
           02  agenda-name             PIC X(35).
           02  agenda-surname          PIC X(35).
           02  agenda-address          PIC X(40).
           02  agenda-b-date           PIC X(14).
           02  agenda-city             PIC X(20).

       WORKING-STORAGE SECTION.

       01  WK01.
           03 WE-L07C014 PIC 9(006).
           03 WE-L09C014 PIC X(035).
           03 WE-L11C014 PIC X(035).
           03 WE-L13C014 PIC X(040).
           03 WE-L15C014 PIC X(010).
           03 WE-L15C036 PIC X(020).
           03 WE-L19C011 PIC X(001).
             88 exit-yes  VALUE 'Y'.

       01 Status-Codes.
          02 agenda-status              PIC X(2).
             88 No-Error-Found        VALUE "00".
             88 Rec-ALREADY-EXIST     VALUE "22".

       01 WE-L17C014 PIC X(026).

       SCREEN SECTION.

       01  SCREEN-01.
           03 BLANK SCREEN  BACKGROUND-COLOR 7.
           03 LINE 03 COLUMN 01 VALUE
           "PERSONAL AGENDA"
                       FOREGROUND-COLOR 0 BACKGROUND-COLOR 7.
           03 LINE 05 COLUMN 25 VALUE
           "CONTACTS"
                       FOREGROUND-COLOR 0 BACKGROUND-COLOR 7.
           03 LINE 07 COLUMN 01 VALUE
           "CODE:"
                       FOREGROUND-COLOR 0 BACKGROUND-COLOR 7.
           03 WX-L07C014 PIC 9(006)
                        LINE 07 COLUMN 014
                         TO   WE-L07C014
                       FOREGROUND-COLOR 7 BACKGROUND-COLOR 1.
           03 LINE 09 COLUMN 01 VALUE
           "NAME:"
                       FOREGROUND-COLOR 0 BACKGROUND-COLOR 7.
           03 WX-L09C014 PIC X(035)
                        LINE 09 COLUMN 014
                        USING WE-L09C014
                       FOREGROUND-COLOR 7 BACKGROUND-COLOR 1.
           03 LINE 11 COLUMN 01 VALUE
           "SURNAME:"
                       FOREGROUND-COLOR 0 BACKGROUND-COLOR 7.
           03 WX-L11C014 PIC X(035)
                        LINE 11 COLUMN 014
                        USING WE-L11C014
                       FOREGROUND-COLOR 7 BACKGROUND-COLOR 1.
           03 LINE 13 COLUMN 01 VALUE
           "ADDRESS:"
                       FOREGROUND-COLOR 0 BACKGROUND-COLOR 7.
           03 WX-L13C014 PIC X(040)
                        LINE 13 COLUMN 014
                        USING WE-L13C014
                       FOREGROUND-COLOR 7 BACKGROUND-COLOR 1.
           03 LINE 15 COLUMN 01 VALUE
           "BORN DATE:"
                       FOREGROUND-COLOR 0 BACKGROUND-COLOR 7.
           03 WX-L15C014 PIC X(010)
                        LINE 15 COLUMN 014
                        USING WE-L15C014
                       FOREGROUND-COLOR 7 BACKGROUND-COLOR 1.
           03 LINE 15 COLUMN 28 VALUE
           "CITY:"
                       FOREGROUND-COLOR 0 BACKGROUND-COLOR 7.
           03 WX-L15C036 PIC X(020)
                        LINE 15 COLUMN 036
                        USING WE-L15C036
                       FOREGROUND-COLOR 7 BACKGROUND-COLOR 1.


           03 WX-L17C014 PIC X(026)
                        LINE 17 COLUMN 015
                        USING WE-L17C014
                       FOREGROUND-COLOR 0 BACKGROUND-COLOR 7.

           03 LINE 19 COLUMN 01 VALUE
           "EXIT"
                       FOREGROUND-COLOR 0 BACKGROUND-COLOR 7.
           03 WX-L19C011 PIC X(001)
                        LINE 19 COLUMN 011
                        USING WE-L19C011
                       FOREGROUND-COLOR 7 BACKGROUND-COLOR 1.
           03 LINE 19 COLUMN 15 VALUE
           "write Y to exit"
                       FOREGROUND-COLOR 0 BACKGROUND-COLOR 7.

       PROCEDURE DIVISION.

       PERFORM INITIAL-PROCEDURE.
       PERFORM PROCEDURE001.

       INITIAL-PROCEDURE.
       MOVE SPACES TO WE-L17C014.

       PROCEDURE001.
           INITIALIZE WK01.
           MOVE ZEROS TO WE-L07C014.
           DISPLAY SCREEN-01.
           ACCEPT  SCREEN-01.

           IF exit-yes
             STOP RUN
           ELSE
             PERFORM PROCEDURE002
           END-IF.

       PROCEDURE002.
         OPEN I-O AGENDA.
         MOVE WE-L07C014 TO agenda-code.
         MOVE WE-L09C014 TO agenda-name.
         MOVE WE-L11C014 TO agenda-surname.
         MOVE WE-L13C014 TO agenda-address.
         MOVE WE-L15C014 TO agenda-b-date.
         MOVE WE-L15C036 TO agenda-city.

         WRITE Agenda-Rec
           INVALID KEY
           IF Rec-ALREADY-EXIST
             MOVE "CONTACT ALREADY EXIST" TO WE-L17C014
           ELSE
             MOVE "ANOTHER ERROR OCCURS" TO WE-L17C014
           END-IF
         END-WRITE.

         IF No-Error-Found
           MOVE "CONTACT SAVED SUCCESSFULLY" TO WE-L17C014
         END-IF.

         CLOSE AGENDA.


         PERFORM PROCEDURE001.
