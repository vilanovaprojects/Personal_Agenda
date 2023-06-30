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

       01 Status-Codes.
          02 agenda-status              PIC X(2).

       PROCEDURE DIVISION.

       OPEN OUTPUT AGENDA.
       CLOSE AGENDA.

       STOP RUN.
