       AFFICHER_OPTIONS_ANNONCES.
           PERFORM WITH TEST AFTER UNTIL w_opt >= 0 AND w_opt <= 4
               DISPLAY "|| GESTION DES ANNONCES ||"
               DISPLAY " "
               DISPLAY "Veuillez saisir l'option souhaite."
               DISPLAY "1 - Publier une annonce"
               DISPLAY "2 - Modifier une annonce"
               DISPLAY "3 - Supprimer une annonce"
               DISPLAY "4 - Afficher toutes les annonces"
               DISPLAY "0 - Sortir"
               ACCEPT w_opt
           END-PERFORM

           EVALUATE w_opt
           WHEN 1
               PERFORM PUBLIER_ANNONCE
           WHEN 2
               PERFORM MODIFIER_ANNONCE
           WHEN 3
               PERFORM SUPPRIMER_ANNONCE
           WHEN 4
               PERFORM AFFICHER_ANNONCES_UTILISATEUR_2
           WHEN 0
               DISPLAY "A bientot !"
           END-EVALUATE.

       PUBLIER_ANNONCE.
           DISPLAY '|| PUBLIER UNE NOUVELLE ANNONCE ||'
           DISPLAY ' '

           PERFORM SAISIR_DATE_DEPART

           DISPLAY "Veuillez saisir votre point de depart."
           ACCEPT w_lieu_depart
           DISPLAY " "
           DISPLAY "Veuillez saisir votre point d'arrivee."
           ACCEPT w_lieu_darrive
           DISPLAY " "
           DISPLAY "Veuillez saisir un lieu de rendez-vous."
           ACCEPT w_lieu_rdv
           DISPLAY " "

           PERFORM SAISIR_VOYAGEUR

           PERFORM SAISIR_PRIX

           *>  ajout de l'annonce
           *>  note : il faut augmenter fa_code de 1 a chaque execution
           MOVE 2 TO w_code
           MOVE wu_telephone TO w_conducteur
           MOVE w_annonce TO tamp_fannonce
           OPEN I-O fannonce
               WRITE tamp_fannonce
               INVALID KEY
                   DISPLAY "Impossible d'ajouter."
                   DISPLAY " "
               NOT INVALID KEY
                   DISPLAY "Ajout effectue."
                   DISPLAY " "
               END-WRITE
           CLOSE fannonce

           PERFORM AFFICHER_OPTIONS_ANNONCES.

       MODIFIER_ANNONCE.
           DISPLAY "|| MODIFIER UNE ANNONCE ||"
           DISPLAY " "

           PERFORM AFFICHER_ANNONCES_UTILISATEUR

           DISPLAY "Veuillez saisir le code de l'annonce a modifier."
           ACCEPT w_code
           DISPLAY " "

           OPEN I-O fannonce
           MOVE w_code TO fa_code

           READ fannonce
           INVALID KEY
               DISPLAY "Cet identifiant n'existe pas."
               DISPLAY " "
           NOT INVALID KEY
           MOVE tamp_fannonce TO w_annonce

           PERFORM WITH TEST AFTER UNTIL w_reponse = 'o' OR
               w_reponse = 'O' OR w_reponse = 'n' OR w_reponse = 'N'
               DISPLAY "Voulez-vous changer la date de depart ? (O/N)"
               ACCEPT w_reponse
               DISPLAY " "
               IF w_reponse = 'o' OR w_reponse = 'O' THEN
                   PERFORM SAISIR_DATE_DEPART
               END-IF
           END-PERFORM

           PERFORM WITH TEST AFTER UNTIL w_reponse = 'o' OR
           w_reponse = 'O' OR w_reponse = 'n' OR w_reponse = 'N'
               DISPLAY "Voulez-vous changer le point de depart ? (O/N)"
               ACCEPT w_reponse
               DISPLAY " "
               IF w_reponse = 'o' OR w_reponse = 'O' THEN
                   DISPLAY "Veuillez saisir votre point de depart."
                   ACCEPT w_lieu_depart
                   DISPLAY " "
               END-IF
           END-PERFORM

           PERFORM WITH TEST AFTER UNTIL w_reponse = 'o' OR
           w_reponse = 'O' OR w_reponse = 'n' OR w_reponse = 'N'
               DISPLAY "Voulez-vous changer le point d'arrivee ? (O/N)"
               ACCEPT w_reponse
               DISPLAY " "
               IF w_reponse = 'o' OR w_reponse = 'O' THEN
                   DISPLAY "Veuillez saisir votre point d'arrivee."
                   ACCEPT w_lieu_darrive
                   DISPLAY " "
               END-IF
           END-PERFORM

           PERFORM WITH TEST AFTER UNTIL w_reponse = 'o' OR
           w_reponse = 'O' OR w_reponse = 'n' OR w_reponse = 'N'
               DISPLAY "Voulez-vous changer le lieu de rendez-vous ?"
               DISPLAY "(O/N)"
               ACCEPT w_reponse
               DISPLAY " "
               IF w_reponse = 'o' OR w_reponse = 'O' THEN
                   DISPLAY "Veuillez saisir un lieu de rendez-vous."
                   ACCEPT w_lieu_rdv
                   DISPLAY " "
               END-IF
           END-PERFORM

           PERFORM WITH TEST AFTER UNTIL w_reponse = 'o' OR
           w_reponse = 'O' OR w_reponse = 'n' OR w_reponse = 'N'
               DISPLAY "Voulez-vous changer le nombre de voyageurs ?"
               DISPLAY "(O/N)"
               ACCEPT w_reponse
               DISPLAY " "
               IF w_reponse = 'o' OR w_reponse = 'O' THEN
                   PERFORM SAISIR_VOYAGEUR
               END-IF
           END-PERFORM

           PERFORM WITH TEST AFTER UNTIL w_reponse = 'o' OR
           w_reponse = 'O' OR w_reponse = 'n' OR w_reponse = 'N'
               DISPLAY "Voulez-vous changer le prix du voyage ? (O/N)"
               ACCEPT w_reponse
               DISPLAY " "
               IF w_reponse = 'o' OR w_reponse = 'O' THEN
                   PERFORM SAISIR_PRIX
               END-IF
           END-PERFORM

           MOVE w_annonce TO tamp_fannonce
           REWRITE tamp_fannonce
           DISPLAY "Votre annonce a ete modifie."
           DISPLAY " "
           END-READ

           CLOSE fannonce

           PERFORM AFFICHER_OPTIONS_ANNONCES.

       SUPPRIMER_ANNONCE.
           DISPLAY "|| SUPPRIMER UNE ANNNONCE ||"
           DISPLAY " "
           PERFORM AFFICHER_ANNONCES_UTILISATEUR
           DISPLAY "Veuillez saisir le code de l'annonce a supprimer."
           ACCEPT w_code
           DISPLAY " "
           *> supprimer l'annnonce selectionne
           OPEN I-O fannonce
           MOVE w_code TO fa_code
           READ fannonce
           INVALID KEY
               DISPLAY "Cet identifiant n'existe pas."
               DISPLAY " "
           NOT INVALID KEY
               DELETE fannonce RECORD
               DISPLAY "Votre annonce a ete supprimee."
               DISPLAY " "
           END-READ
           CLOSE fannonce

           PERFORM AFFICHER_OPTIONS_ANNONCES.

       AFFICHER_ANNONCES.
           DISPLAY "Voici la liste d'annonces en cours :"
           DISPLAY " "
           OPEN INPUT fannonce
           MOVE 1 TO w_fin

           PERFORM WITH TEST AFTER UNTIL w_fin = 0
           READ fannonce NEXT
           AT END MOVE 0 TO w_fin
           NOT AT END
               DISPLAY "Code : " fa_code
               DISPLAY "Prix : " fa_prix
               DISPLAY "Places : " fa_place_max
               DISPLAY "Depart : " fa_lieu_depart
               DISPLAY "Arrivee : " fa_lieu_darrive
               DISPLAY "Rendez-vous : " fa_lieu_rdv
               DISPLAY "Conducteur : " fa_conducteur
               DISPLAY "Date de depart : " fa_date_depart
           END-READ
           END-PERFORM

           CLOSE fannonce.

       AFFICHER_ANNONCES_UTILISATEUR.
           OPEN INPUT fannonce
           MOVE 1 TO w_fin
           MOVE wu_telephone TO fa_conducteur
           START fannonce, KEY IS = fa_conducteur
           INVALID KEY
               DISPLAY "Pas d'annonces en cours."
           NOT INVALID KEY
               PERFORM WITH TEST AFTER UNTIL w_fin = 0
               READ fannonce NEXT
               AT END MOVE 0 TO w_fin
               NOT AT END
                   DISPLAY "Code : " fa_code
                   DISPLAY "Prix : " fa_prix
                   DISPLAY "Places : " fa_place_max
                   DISPLAY "Depart : " fa_lieu_depart
                   DISPLAY "Arrivee : " fa_lieu_darrive
                   DISPLAY "Rendez-vous : " fa_lieu_rdv
                   DISPLAY "Conducteur : " fa_conducteur
                   DISPLAY "Date de depart : " fa_date_depart
                   DISPLAY " "
               END-READ
               END-PERFORM
           END-START

           CLOSE fannonce.

       AFFICHER_ANNONCES_UTILISATEUR_2.
           PERFORM AFFICHER_ANNONCES_UTILISATEUR
           PERFORM AFFICHER_OPTIONS_ANNONCES.

       AJOUTER_CODE.
           OPEN I-O fcode
           SET w_code_annonce TO 1
           SET w_code_reservation TO 2
           MOVE w_code_reservation TO fc_code
           MOVE w_code_annonce TO fc_code_annonce
           DISPLAY fc_code
           DISPLAY fc_code_annonce
           WRITE tamp_fcode
           END-WRITE
           CLOSE fcode.

       LIRE_CODE.
           OPEN INPUT fcode
           MOVE 1 TO w_fin
           PERFORM WITH TEST AFTER UNTIL w_fin = 0
               READ fcode
                   AT END MOVE 0 TO w_fin
                   NOT AT END DISPLAY fc_code_annonce
               END-READ
           END-PERFORM
           CLOSE fcode.

       SAISIR_DATE_DEPART.
           MOVE FUNCTION CURRENT-DATE to WS-CURRENT-DATE-DATA
           DISPLAY "Vous allez d'abord saisir la date de depart."
           DISPLAY "ATTENTION ! Vous pouvez uniquement publier des"
           DISPLAY "annonces pour l'annee en cours."
           DISPLAY " "
           SET w_annee TO WS-CURRENT-YEAR
           PERFORM WITH TEST AFTER UNTIL w_mois >= WS-CURRENT-MONTH
           AND w_mois <= 12
               DISPLAY "Veuillez saisir le mois souhaite."
               DISPLAY "("WS-CURRENT-MONTH " - 12)"
               ACCEPT w_mois
           END-PERFORM

           IF w_mois = 4 OR w_mois = 6 OR w_mois = 9 OR w_mois = 11 THEN
               SET w_dernier_jour TO 30
           ELSE
               IF w_mois = 2 THEN
                   SET w_dernier_jour TO 28
               ELSE
                   SET w_dernier_jour TO 31
               END-IF
           END-IF

           IF w_mois = WS-CURRENT-MONTH THEN
               SET w_premier_jour TO WS-CURRENT-DAY
           ELSE
               SET w_premier_jour TO 1
           END-IF

           PERFORM WITH TEST AFTER UNTIL w_jour >= w_premier_jour
               AND w_jour <= w_dernier_jour
               DISPLAY "Maintenant, veuillez saisir le jour."
               DISPLAY "("w_premier_jour " - " w_dernier_jour")"
               ACCEPT w_jour
               DISPLAY " "
           END-PERFORM.

       SAISIR_VOYAGEUR.
           OPEN I-O futilisateur
           MOVE wu_telephone TO fu_telephone
           READ futilisateur
           INVALID KEY
               DISPLAY "Cet identifiant n'existe pas."
               DISPLAY " "
           NOT INVALID KEY
               PERFORM WITH TEST AFTER UNTIL w_place_max >= 1 AND
               w_place_max <= fu_nbplace
                   DISPLAY "Veuillez saisir le nombre de voyageurs."
                   DISPLAY "(1 - " fu_nbplace")"
                   ACCEPT w_place_max
                   DISPLAY " "
               END-PERFORM
           END-READ
           CLOSE fannonce.

       SAISIR_PRIX.
           PERFORM WITH TEST AFTER UNTIL w_prix_annonce >= 5
               DISPLAY "Veuillez saisir le prix du voyage."
               DISPLAY "(Minimum 5)"
               ACCEPT w_prix_annonce
               DISPLAY " "
           END-PERFORM.
