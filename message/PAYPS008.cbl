IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYPS008.
      ******************************************************************
      * Maps PS008MAP onto pacs.008.001.08, sends via PayInc transport,
      * processes returned pacs.002 (status report).
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY COMMSTAT.
           COPY PS008MAP.
           01  WS-PACS008-XML             PIC X(8000).
           01  WS-PACS002-XML             PIC X(4000).

       LINKAGE SECTION.
           COPY PAYREQ.
           COPY PAYSTAT.

       PROCEDURE DIVISION USING PAYMENT-REQUEST MODULE-STATUS.
       MAIN-CONTROL.
           INITIALIZE MODULE-STATUS

           PERFORM MAP-TO-PACS008
           PERFORM SEND-VIA-TRANSPORT
           IF NOT STATUS-OK
               GOBACK
           END-IF

           PERFORM RECEIVE-PACS002
           PERFORM PROCESS-PACS002

           GOBACK.

       MAP-TO-PACS008.
      *    Field-by-field mapping PS008MAP -> pacs.008.001.08 elements
      *    Kept isolated so XSD version bumps only touch this paragraph
           CONTINUE.

       SEND-VIA-TRANSPORT.
      *    mTLS / MQ call to PayInc — CALL "PAYTRANS" or EXEC CICS WEB
           CONTINUE.

       RECEIVE-PACS002.
      *    Synchronous or correlated async receive of status report
           CONTINUE.

       PROCESS-PACS002.
      *    Map pacs.002 status codes -> MODULE-STATUS / REASON-CODE
           CONTINUE.