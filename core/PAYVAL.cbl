IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYVAL.
      ******************************************************************
      * Card status, velocity, and daily limit checks.
      * READ-ONLY against card master. No updates, no journaling.
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY COMMSTAT.
           01  WS-CARD-MASTER-REC.
               05  WS-CARD-STATUS         PIC X(01).
               05  WS-DAILY-LIMIT         PIC 9(11)V99.
               05  WS-DAILY-USED          PIC 9(11)V99.
               05  WS-VELOCITY-COUNT      PIC 9(03).

       LINKAGE SECTION.
           COPY PAYREQ.
           COPY PAYSTAT.

       PROCEDURE DIVISION USING PAYMENT-REQUEST MODULE-STATUS.
       MAIN-CONTROL.
           INITIALIZE MODULE-STATUS

           PERFORM READ-CARD-MASTER
           IF NOT STATUS-OK
               GOBACK
           END-IF

           PERFORM CHECK-CARD-STATUS
           IF NOT STATUS-OK
               GOBACK
           END-IF

           PERFORM CHECK-VELOCITY
           IF NOT STATUS-OK
               GOBACK
           END-IF

           PERFORM CHECK-DAILY-LIMIT

           GOBACK.

       READ-CARD-MASTER.
      *    EXEC CICS READ / SELECT — read-only, no locking
           CONTINUE.

       CHECK-CARD-STATUS.
           IF WS-CARD-STATUS NOT = "A"
               SET STATUS-BUSINESS-REJECT TO TRUE
               MOVE "CARDBLK" TO REASON-CODE
           END-IF.

       CHECK-VELOCITY.
           IF WS-VELOCITY-COUNT > 999
               SET STATUS-BUSINESS-REJECT TO TRUE
               MOVE "VELEXC" TO REASON-CODE
           END-IF.

       CHECK-DAILY-LIMIT.
           IF (WS-DAILY-USED + REQ-AMOUNT) > WS-DAILY-LIMIT
               SET STATUS-BUSINESS-REJECT TO TRUE
               MOVE "LIMEXC" TO REASON-CODE
           END-IF.