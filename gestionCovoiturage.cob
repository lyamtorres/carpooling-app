       IDENTIFICATION DIVISION.
       PROGRAM-ID. gestionCovoiturage.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT futilisateur ASSIGN TO "utilisateur.dat"
           ORGANIZATION INDEXED
           ACCESS MODE is DYNAMIC
           RECORD KEY IS fu_telephone
           ALTERNATE RECORD KEY IS fu_type WITH DUPLICATES
           ALTERNATE RECORD KEY IS fu_immatriculation
           FILE STATUS IS cr_futilisateur.

           SELECT freservation ASSIGN TO "reservation.dat"
           ORGANIZATION INDEXED
           ACCESS MODE is DYNAMIC
           RECORD KEY IS fres_code
           ALTERNATE RECORD KEY IS fres_voyageur WITH DUPLICATES
           ALTERNATE RECORD KEY IS fres_conducteur WITH DUPLICATES
           FILE STATUS IS cr_freservation.


           SELECT fstatistiques ASSIGN TO "statistiques.dat"
           ORGANIZATION INDEXED
           ACCESS MODE is DYNAMIC
           RECORD KEY IS fs_code
           ALTERNATE RECORD KEY IS fs_villeD WITH DUPLICATES
           ALTERNATE RECORD KEY IS fs_villeA WITH DUPLICATES
           ALTERNATE RECORD KEY IS fs_conducteur WITH DUPLICATES
           FILE STATUS IS cr_fstatistiques.

           SELECT fannonce ASSIGN TO "annonce.dat"
           ORGANIZATION INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS fa_code
           ALTERNATE RECORD KEY IS fa_lieu_depart WITH DUPLICATES
           ALTERNATE RECORD KEY IS fa_lieu_darrive  WITH DUPLICATES
           FILE STATUS IS cr_fannonce.
       DATA DIVISION.
       FILE SECTION.

       FD futilisateur.
       01 tamp_futilisateur.
           02 fu_telephone PIC 9(10).
           02 fu_nom PIC A(20).
           02 fu_prenom PIC A(30).
           02 fu_mdp PIC X(10).
           02 fu_type PIC 9(1).
           02 fu_solde PIC 9(4).
           02 fu_immatriculation PIC X(9).
           02 fu_nbplace PIC 9(5).

       FD freservation.
       01 tamp_freservation.
           02 fres_code PIC 9(6).
           02 fres_voyageur PIC 9(10).
           02 fres_conducteur PIC 9(10).
           02 fres_statut_reservation PIC 9(1).
           02 fres_date_reservation.
               03 fres_annee  PIC  9(4).
               03 fres_mois PIC  9(2).
               03 fres_jour PIC  9(2).

       FD fannonce.
       01 tamp_fannonce.
           02 fa_code PIC 9(6).
           02 fa_prix PIC 9(8).
           02 fa_place_max PIC 9(1).
           02 fa_lieu_depart PIC X(30).
           02 fa_lieu_darrive PIC X(30).
           02 fa_lieu_rdv PIC X(30).
           02 fa_conducteur PIC A(10).
           02 fa_date_depart.
              03 fa_annee  PIC  9(4).
              03 fa_mois PIC  9(2).
              03 fa_jour  PIC  9(2).

       FD fstatistiques.
       01 tamp_fstatistiques.
           02 fs_code PIC 9(6).
           02 fs_villeD PIC X(30).
           02 fs_villeA PIC X(30).
           02 fs_conducteur PIC A(10).
           02 fs_prix PIC 9(8).

       WORKING-STORAGE SECTION.
       77 cr_futilisateur PIC 9(2).
       77 cr_freservation PIC 9(2).
       77 cr_fannonce PIC 9(2).
       77 cr_fstatistiques PIC 9(2).
           *> toure
       01 wutilisateur.
           02 wu_telephone PIC 9(10).
           02 wu_nom PIC A(20).
           02 wu_prenom PIC A(30).
           02 wu_mdp PIC X(10).
           02 wu_type PIC 9(1).
           02 wu_solde PIC 9(4).
           02 wu_immatriculation PIC X(9).
           02 wu_nbplace PIC 9(5).
       77 w_teluser PIC 9(10).
       77 w_text PIC 9(30).
       77 w_test PIC 9(1).

       *> lyam
       01 w_annonce.
           02 w_code PIC 9(6).
           02 w_prix PIC 9(8).
           02 w_place_max PIC 9(1).
           02 w_lieu_depart PIC X(30).
           02 w_lieu_darrive PIC X(30).
           02 w_lieu_rdv PIC X(30).
           02 w_conducteur PIC A(10).
           02 w_date_depart.
              03 w_annee  PIC  9(4).
              03 w_mois PIC  9(2).
              03 w_jour  PIC  9(2).
       77 Wfin PIC 9(1).
        *> pour récuperer la date du système
       01 SYS-DATE6.
           03 AA   PIC 99.
           03 MM  PIC 99.
           03 JJ    PIC 99.

       PROCEDURE DIVISION.
           OPEN I-O futilisateur
           IF cr_futilisateur=35 THEN
              OPEN OUTPUT futilisateur
           END-IF
           CLOSE futilisateur
           OPEN I-O freservation
           IF cr_freservation=35 THEN
              OPEN OUTPUT freservation
           END-IF
           CLOSE freservation
           OPEN I-O fannonce
           IF cr_fannonce=35 THEN
              OPEN OUTPUT fannonce
           END-IF
           CLOSE fannonce
           *> page identification et connexion
          *> ACCEPT SYS-DATE6 FROM DATE
           DISPLAY "bonjour"

           *> Affiche la page de connexion
           *> PERFORM AFFICHE_PAGE_CONNEXION

           PERFORM SUPPRIMER_ANNONCE

           STOP RUN.

           *> copy "compte.cpy".
           copy "publication.cpy".

           END PROGRAM gestionCovoiturage.
