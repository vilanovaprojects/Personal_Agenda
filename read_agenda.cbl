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
           88  END-AGENDA VALUE HIGH-VALUES.
           02  agenda-code             PIC 9(6).
           02  agenda-name             PIC X(35).
           02  agenda-surname          PIC X(35).
           02  agenda-address          PIC X(40).
           02  agenda-b-date           PIC X(14).
           02  agenda-city             PIC X(20).

       WORKING-STORAGE SECTION.

       01 Status-Codes.
          02 agenda-status              PIC X(2).
             88 No-Error-Found        VALUE "00".
             88 Rec-Not-Found         VALUE "23".


       PROCEDURE DIVISION.

       OPEN INPUT AGENDA.

       READ AGENDA NEXT RECORD
           AT END SET END-AGENDA TO TRUE
       END-READ.

       PERFORM SHOW-REG UNTIL END-AGENDA.

       SHOW-REG.

         DISPLAY Agenda-Rec.

         READ AGENDA NEXT RECORD
           AT END SET END-AGENDA TO TRUE
         END-READ.
       END-SHOW-REG.

       ACCEPT agenda-name.


       CLOSE AGENDA.
             STOP RUN.
