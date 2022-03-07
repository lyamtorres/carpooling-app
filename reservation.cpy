           DISPLAY '|====================================|'
           DISPLAY '|===========Bonjour ,vous aller proceder==========|'
           DISPLAY '|=========== à une reservation      ===========|'
           DISPLAY ' '

           DISPLAY '*********************************'
           DISPLAY 'veuillez donnez une ville de depart '
     $
       ACCEPT  wnomvilleD
       DISPLAY 'veuillez donnez une ville d arrivée' '
       ACCEPT  wnomvilleA
       DISPLAY '-====================================-'.
       OPEN INPUT fannonce
       MOVE 0 TO Wfin
      *>*********RECHERCHER une annonce ************************************
       MOVE wnomvilleD TO fa_lieudepart
       START fannonce, KEY IS = fa_lieudepart
       INVALID KEY
       DISPLAY  'Nous n assurons aucun trajet au départ '
       DISPLAY   '----de cette ville -------'
       NOT INVALID KEY
       PERFORM WITH TEST AFTER UNTIL Wfin = 1
           READ fannonce NEXT
           AT END MOVE 1 TO Wfin
           NOT AT END
           IF wnomvilleD = fa_lieudepart THEN
               DISPLAY 'Trajet de  :', fa_lieudepart
               DISPLAY ' à ', fa_lieudarrive
               DISPLAY 'est à  : ',fa_prix
               DISPLAY 'la date de départ est le  : ',fa_date_depart
           END-IF
           END-READ
       END-PERFORM
       CLOSE fannonce.
