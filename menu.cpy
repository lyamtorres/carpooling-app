    *> page identification et connexion


       AFFICHE_PAGE_CONNEXION.

           PERFORM WITH TEST AFTER UNTIL w_test > 0 AND w_test < 4
           
                DISPLAY "------------ GESTION COVOITURAGE ------------"
                DISPLAY "1.   INSCRIPTION"
                DISPLAY "2.   CONNEXION"
                DISPLAY "3.   QUITTER"
                ACCEPT w_test
           END-PERFORM

           EVALUATE w_test
           WHEN 1
                PERFORM INSCRIPTION
                PERFORM CONNEXION
           WHEN 2
                PERFORM CONNEXION
           WHEN 3
                DISPLAY "A TRES BIENTOT"

           END-EVALUATE.    
    
    *> menu principal
       AFFICHE_MENU.

           PERFORM WITH TEST AFTER UNTIL w_test > 0 AND w_test < 6
           
                DISPLAY "------------ GESTION COVOITURAGE ------------"
                DISPLAY "1.   RESERVATIONS"
                DISPLAY "2.   ANNONCES"
                DISPLAY "3.   MON COMPTE"
                DISPLAY "4.   ADMINISTRATION"
                DISPLAY "5.   QUITTER"
                ACCEPT w_test
           END-PERFORM

           EVALUATE w_test
           WHEN 1
                DISPLAY "RESERVATION"
           WHEN 2
                DISPLAY "ANNONCES"
           WHEN 3
                PERFORM PAGE_PROFIL
           WHEN 4
                DISPLAY "ADMINSTRATION"
           WHEN 5
                DISPLAY "A TRES BIENTOT"

           END-EVALUATE.

    *> menu profi
       PAGE_PROFIL.

           PERFORM WITH TEST AFTER UNTIL w_test > 0 AND w_test < 7
           
                DISPLAY "------------ GESTION COVOITURAGE ------------"
                DISPLAY "---------------------------------------------"
                DISPLAY "|               MON PROFIL                  |"
                DISPLAY "---------------------------------------------"
                DISPLAY "1.   VOIR PROFIL"
                DISPLAY "2.   RECHARCHER MON COMPTE"
                DISPLAY "3.   MODIFIER MOT DE PASSE"
                DISPLAY "4.   MODIFIER STATUS COMPTE"
                DISPLAY "5.   SUPPRIMMER MON COMPTE"
                DISPLAY "6.   RETOUR"
                ACCEPT w_test
           END-PERFORM

           EVALUATE w_test
           WHEN 1
                PERFORM VOIR_PROFIL
                
           WHEN 2
                PERFORM RECHARGE_COMPTE
                
           WHEN 3
                PERFORM CHANGE_MPD
                
           WHEN 4
                
                PERFORM CHANGE_STATUS
           WHEN 5
                
                PERFORM SUPPRIME_COMPTE
          WHEN 6
                
                PERFORM AFFICHE_MENU

           END-EVALUATE.

