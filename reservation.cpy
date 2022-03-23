DISPLAY '|====================================|'
           DISPLAY '|===========Bonjour ,vous aller proceder==========|'
<<<<<<< HEAD
           DISPLAY '|=========== � une reservation      ===========|'
=======
           DISPLAY '|=========== à une reservation      ===========|'
>>>>>>> a54a6c2c51f7291b2f65f620527ccc702b93b89a
           DISPLAY ' '
           DISPLAY '*********************************'
           DISPLAY 'veuillez donnez une ville de depart '
     
       ACCEPT  wnomvilleD
<<<<<<< HEAD
       DISPLAY 'veuillez donnez une ville d arriv�e'
=======
       DISPLAY 'veuillez donnez une ville d arrivée' '
>>>>>>> a54a6c2c51f7291b2f65f620527ccc702b93b89a
       ACCEPT  wnomvilleA
       DISPLAY '-====================================-'.
       OPEN INPUT fannonce
       MOVE 0 TO Wfin
      *>*********RECHERCHER une annonce ************************************
       MOVE wnomvilleD TO fa_lieudepart
       START fannonce, KEY IS = fa_lieudepart
       INVALID KEY
<<<<<<< HEAD
       DISPLAY  'Nous n assurons aucun trajet au d�part '
=======
       DISPLAY  'Nous n assurons aucun trajet au départ '
>>>>>>> a54a6c2c51f7291b2f65f620527ccc702b93b89a
       DISPLAY   '----de cette ville -------'
       NOT INVALID KEY
       PERFORM WITH TEST AFTER UNTIL Wfin = 1
           READ fannonce NEXT
           AT END MOVE 1 TO Wfin
           NOT AT END
           IF wnomvilleD = fa_lieudepart THEN
               DISPLAY 'Trajet de  :', fa_lieudepart
<<<<<<< HEAD
               DISPLAY ' � ', fa_lieudarrive
               DISPLAY 'est �  : ',fa_prix
               DISPLAY 'la date de d�part est le  : ',fa_date_depart
=======
               DISPLAY ' à ', fa_lieudarrive
               DISPLAY 'est à  : ',fa_prix
               DISPLAY 'la date de départ est le  : ',fa_date_depart
>>>>>>> a54a6c2c51f7291b2f65f620527ccc702b93b89a
           END-IF
           END-READ
       END-PERFORM
       CLOSE fannonce.