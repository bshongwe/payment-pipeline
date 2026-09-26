       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYHSM.
      ******************************************************************
      * Security Services – sole owner of HSM interaction
      * DUKPT: KSN mandatory; BDK never leaves HSM
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY COMMSTAT.
       LINKAGE SECTION.
           COPY HSMREQ.
           COPY HSMRSP.

       PROCEDURE DIVISION USING HSM-REQUEST HSM-RESPONSE.
       MAIN.
           INITIALIZE HSM-RESPONSE
           EVALUATE TRUE
               WHEN CMD-PIN-VERIFY
                    PERFORM DO-PIN-VERIFY
               WHEN CMD-ARQC-VERIFY-ARPC
                    PERFORM DO-ARQC-ARPC
               WHEN CMD-MAC-VERIFY
                    PERFORM DO-MAC-VERIFY
               WHEN OTHER
                    MOVE "99" TO HSM-STATUS
                    MOVE "INVCMD" TO HSM-REASON-CODE
           END-EVALUATE
           GOBACK.

       DO-PIN-VERIFY.
      * Build vendor command (Thales/SafeNet/Atalla).
      * For DUKPT the HSM re-derives IPEK from BDK+KSN (counter masked)
      * then regenerates the transaction key and verifies the PIN block.
      * COBOL never sees clear key or clear PIN.
           IF KSN = SPACES
              MOVE "05" TO HSM-STATUS
              MOVE "NOKSN" TO HSM-REASON-CODE
              EXIT PARAGRAPH
           END-IF
      * CALL low-level driver PAYHSMI with constructed command
      * On success: HSM-OK, on bad PIN: HSM-PIN-INCORRECT
           .

       DO-ARQC-ARPC.
      * EMV ARQC verification + ARPC generation (HSM command KQ/KW or EE2018)
           .

       DO-MAC-VERIFY.
      * ISO 8583 MAC (ANSI X9.19 or ISO 16609) using the appropriate key
      * Data is the binary message from MTI through the field before MAC
           .