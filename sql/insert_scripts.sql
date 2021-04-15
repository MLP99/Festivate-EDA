CREATE TABLE festival
(
    festival_id INT NOT NULL UNIQUE,
    naam VARCHAR(60),
    omschrijving VARCHAR(200),
    datum DATE,
    plaats VARCHAR(60),
    leeftijd INT,
    organisator VARCHAR(60),
    begintijd DATETIME,
    eindtijd DATETIME,

    CONSTRAINT PK_festival
    PRIMARY KEY(festival_id)
)

/* Eerste koppeling met partners en met tussentabel (festival_partners)  */

CREATE TABLE partners
(
    partner_id INT NOT NULL UNIQUE,
    naam VARCHAR(60),

    CONSTRAINT PK_partners
    PRIMARY KEY (partner_id)
)


CREATE TABLE festival_partners
(
    partner_id INT NOT NULL,
    festival_id INT NOT NULL,
    datum DATE,

    CONSTRAINT FK_festival_partners_partners
    FOREIGN KEY (partner_id)
        REFERENCES partners(partner_id),

    CONSTRAINT FK_festival_partners_festival
    FOREIGN KEY(festival_id)
        REFERENCES festival(festival_id)
)

/* Tweede koppeling met sponsoren en met beschikbare_middelen */

CREATE TABLE sponsoren
(
    sponsor_id INT NOT NULL UNIQUE,
    naam VARCHAR(60),
    beschrijving VARCHAR(200),

    CONSTRAINT PK_sponsoren
    PRIMARY KEY(sponsor_id)
)


CREATE TABLE beschikbare_middelen
(
    item_id INT NOT NULL UNIQUE,
    festival_id INT NOT NULL,
    sponsor_id INT NOT NULL,
    item VARCHAR(60),
    omschrijving VARCHAR(200),
	aantal INT,
    waarde DECIMAL(10,2),

    CONSTRAINT PK_beschikbare_middelen
    PRIMARY KEY(item_id),

    CONSTRAINT FK_beschikbare_middelen_festival
    FOREIGN KEY(festival_id)
        REFERENCES festival(festival_id),

    CONSTRAINT FK_beschikbare_middelen_sponsoren
    FOREIGN KEY(sponsor_id)
    REFERENCES sponsoren(sponsor_id)
)

/* Derde koppeling met festival_categorie en tussentabel(festival_categorie_festival) */

CREATE TABLE festival_categorie
(
    categorie_id INT NOT NULL UNIQUE,
    naam VARCHAR(60),
    omschrijving VARCHAR(200),
    genre VARCHAR(30),

    CONSTRAINT PK_festival_categorie
    PRIMARY KEY(categorie_id)
)

CREATE TABLE festival_categorie_festival
(
    festival_id INT NOT NULL,
    categorie_id INT NOT NULL,

    CONSTRAINT FK_festival_categorie_festival_festival
    FOREIGN KEY(festival_id)
        REFERENCES festival(festival_id),
        
    CONSTRAINT FK_festival_categorie_festival_festival_categorie
    FOREIGN KEY(categorie_id)
        REFERENCES festival_categorie(categorie_id)
)

/* Vierde koppeling ticket categorie met de tabel tickets / bezoeker */

CREATE TABLE ticket_categorie
(
    ticket_categorie INT NOT NULL UNIQUE,
    soort VARCHAR(40),
    prijs DECIMAL(10,2),
    aantal INT,

    CONSTRAINT PK_ticket_categorie
    PRIMARY KEY (ticket_categorie)
)

CREATE TABLE bezoeker
(
    bezoeker_id INT NOT NULL UNIQUE,
    voornaam VARCHAR(60) NOT NULL,
    achternaam VARCHAR(60) NOT NULL,
    geslacht VARCHAR(20) NOT NULL,
    geboorte_datum DATE NOT NULL,
    woonplaats VARCHAR(60) NOT NULL,
    email_adres VARCHAR(100)NOT NULL UNIQUE,
    mobielnummer INT NOT NULL UNIQUE,

    CONSTRAINT PK_bezoeker
    PRIMARY KEY (bezoeker_id)
)

CREATE TABLE tickets
(
    ticket_id INT NOT NULL ,
    bezoeker_id INT NOT NULL,
    festival_id INT NOT NULL,
    ticket_categorie INT NOT NULL,
    aantal INT,

    CONSTRAINT PK_tickets
    PRIMARY KEY(ticket_id),

    CONSTRAINT FK_tickets_ticket_categorie
    FOREIGN KEY(ticket_categorie)
        REFERENCES ticket_categorie(ticket_categorie),
    
    CONSTRAINT FK_tickets_bezoeker
    FOREIGN KEY(bezoeker_id)
        REFERENCES bezoeker(bezoeker_id),

    CONSTRAINT FK_tickets_festival
    FOREIGN KEY(festival_id)
        REFERENCES festival(festival_id)
)

/* Koppeling verkoop_producten met bezoeker */

CREATE TABLE verkoop_producten
(
    verkoop_id INT NOT NULL UNIQUE,
    naam VARCHAR(60),
    prijs DECIMAL(10,2),
    aantal INT,

    CONSTRAINT PK_verkoop_producten
    PRIMARY KEY(verkoop_id),
)

CREATE TABLE verkoop_producten_festival
(
    festival_id INT NOT NULL,
    verkoop_id INT NOT NULL,

    CONSTRAINT FK_verkoop_producten_festival_festival
    FOREIGN KEY(festival_id)
        REFERENCES festival(festival_id),
    
    CONSTRAINT FK_verkoop_producten_festival_verkoop_producten
    FOREIGN KEY(verkoop_id)
        REFERENCES verkoop_producten(verkoop_id)
)

/* Koppeling met tussentabel Aanmeldingen tussen festival en bezoeker */

CREATE TABLE aanmeldingen
(
    festival_id INT NOT NULL,
    bezoeker_id INT NOT NULL,

    CONSTRAINT FK_aanmeldingen_festival
    FOREIGN KEY(festival_id)
        REFERENCES festival(festival_id),

    CONSTRAINT FK_aanmeldingen_bezoeker
    FOREIGN KEY(bezoeker_id)
    REFERENCES bezoeker(bezoeker_id)
)

/* Koppeling tussen inkoop en festival en daarna tussentabel inkoop festival */

CREATE TABLE inkoop
(
    inkoop_id INT NOT NULL UNIQUE,
    product VARCHAR(60),
    prijs DECIMAL(10,2),
    aantal INT,
    leverancier VARCHAR(60),

    CONSTRAINT PK_inkoop
    PRIMARY KEY(inkoop_id)
)

CREATE TABLE inkoop_festival
(
    festival_id INT NOT NULL,
    inkoop_id INT NOT NULL,

    CONSTRAINT FK_inkoop_festival_festival
    FOREIGN KEY(festival_id)
        REFERENCES festival(festival_id),

    CONSTRAINT FK_inkoop_festival_inkoop
    FOREIGN KEY(inkoop_id)
        REFERENCES inkoop(inkoop_id)
)

/* Koppeling locatie - festival en tussentabel locatie_festival */

CREATE TABLE locatie
(
    locatie_id INT NOT NULL UNIQUE,
    naam VARCHAR(60),
    adres VARCHAR(60),
    plaats VARCHAR(60),
    areas INT,
    bezoekers_capiciteit INT,

    CONSTRAINT PK_locatie
    PRIMARY KEY(locatie_id)
)


CREATE TABLE locatie_festival
(
    locatie_id INT NOT NULL ,
    festival_id INT NOT NULL ,
    datum DATE,

    CONSTRAINT FK_locatie_festival_locatie
    FOREIGN KEY(locatie_id)
        REFERENCES locatie(locatie_id),
    
    CONSTRAINT FK_locatie_festival_festival
    FOREIGN KEY(festival_id)
        REFERENCES festival(festival_id)
)

CREATE TABLE campagne
(
    campagne_id INT NOT NULL UNIQUE,
    campagne_categorie VARCHAR(60),
    naam VARCHAR(40),
    beschrijving VARCHAR(200),
    startdatum DATETIME,
    einddatum DATETIME,
    kosten DECIMAL(10,2),

    CONSTRAINT PK_campagne
    PRIMARY KEY(campagne_id)
)

CREATE TABLE campagne_festival
(
    festival_id INT NOT NULL,
    campagne_id INT NOT NULL,

    CONSTRAINT FK_campagne_festival_festival
    FOREIGN KEY (festival_id)
        REFERENCES festival(festival_id),

    CONSTRAINT FK_campagne_festival_campagne
    FOREIGN KEY(campagne_id)
        REFERENCES campagne(campagne_id)
)

/* Laatste 4 koppelingen */

CREATE TABLE werknemers
(
    werknemer_id INT NOT NULL UNIQUE,
    voornaam VARCHAR(60) NOT NULL,
    achternaam VARCHAR(60) NOT NULL,
    geboorte_datum DATE,
    functie VARCHAR(30),
    woonplaats VARCHAR(50),
    emailadres VARCHAR(60) NOT NULL UNIQUE,
    telefoonnummer INT NOT NULL UNIQUE,
    geslacht VARCHAR(20),

    CONSTRAINT PK_werknemers
    PRIMARY KEY(werknemer_id)
)

CREATE TABLE werkzaamheden
(
    werkzaamheden_id INT NOT NULL,
    titel VARCHAR(20),
    omschrijving VARCHAR(200),
    startdatum DATE,
    einddatum DATE,

    CONSTRAINT PK_werkzaamheden
    PRIMARY KEY(werkzaamheden_id)
)

CREATE TABLE werknemers_werkzaamheden
(
    werkzaamheden_id INT NOT NULL,
    werknemer_id INT NOT NULL,

    CONSTRAINT FK_werknemers_werkzaamheden_werkzaamheden
    FOREIGN KEY(werkzaamheden_id)
        REFERENCES werkzaamheden(werkzaamheden_id),

    CONSTRAINT FK_werknemers_werkzaamheden_werknemers
    FOREIGN KEY(werknemer_id)
        REFERENCES werknemers(werknemer_id)
)

CREATE TABLE werkzaamheden_festival
(
    festival_id INT NOT NULL,
    werkzaamheden_id INT NOT NULL,

    CONSTRAINT FK_werkzaamheden_festival_festival
    FOREIGN KEY(festival_id)
        REFERENCES festival(festival_id),
    
    CONSTRAINT FK_werkzaamheden_festival_werknemers_werkzaamheden
    FOREIGN KEY(werkzaamheden_id)
        REFERENCES werkzaamheden(werkzaamheden_id)
)


/* Inserts */
/*festival insert*/
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (1, 'Mysteryland', 'Dance festival dat sinds 1993 gehouden wordt in Nederland.', '2021-08-27', 'Haarlemmermeer', 18, 'ID & T', '2021-08-27 13:00:00', '2021-08-30 00:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (2, 'Emporium', 'Dance festival dat sinds 2005 gehouden wordt in Nederland.', '2021-05-29', 'Wijchen', 18, 'The Matrixx', '2021-05-29 12:00:00', '2021-05-30 00:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (3, 'Intents Festival', 'Intents Festival is een drie dagen durend dancefestival. De voornaamste muziekstijlen op intents zijn hardstyle, freestyle en hardcore.', '2021-06-04', 'Oisterwijk', 17, 'Intents Events BV', '2021-06-04 12:00:00', '2021-06-06 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (4, 'Paaspop', 'Paaspop is een driedaags muziekfestival dat elk jaar tijdens het paasweekend plaatsvind in het Nederlandse Schijndel.', '2021-04-02', 'Schijndel', 0, 'Paaspop Events', '2021-04-02 13:30:00', '2021-04-05 02:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (5, 'Defqon.1', 'Defqon.1 is een Nederlands dancefestival dat georganiseerd wordt door Q-dance. Het wordt sinds 2011 gebouden op het evenementen terrein in Biddinghuizen naast Walibi Holland in Flevoland.', '2021-06-25', 'Biddinghuizen', 18, 'Q-dance', '2021-06-25 11:00:00', '2021-06-27 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (6, 'Titanium Festival', 'Zojuist heeft de organisatie van TITANIUM Festival de line-up voor de allereerste editie van het evenement bekendgemaakt.','2021-05-08', 'Vianen', 18,' BKJN Events', '2021-05-08 11:00:00', ' 2021-05-08 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (7, 'Dauw Pop', 'Dauwpop komt in 2021 net zo hard terug! Zet daarom zaterdag 29 mei in je agenda, zodat je zeker weet dat je die dag vrij houdt.','2021-05-29', 'Haarle', 0,' EV Hands', '2021-05-29 11:30:00', ' 2021-05-29 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (8, 'Secret Forest Festival', 'Op zaterdag 29 mei zal Secret Forest Festival weer terug te vinden zijn in Groningen! Dit jaar zal volgens de organisatie het dikste festival van het Noorden wel weer plaatsvinden.','2021-05-29', 'Groningen', 18,'', '2021-05-29 14:00:00', '2021-05-30 01:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (9, 'Drift Festival', 'Dubbel zoveel Drift! De 9e editie van Drift Festival wordt een driegaagse! Op donderdag 10 juni t/m zaterdag 12 juni geven ruim 80 artiesten acte de presence op zeven stages in en rondom de Vasim.','2021-06-10', 'Nijmegen', 18,'Drift', '2021-06-10 14:00:00', ' 2021-06-13 00:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (10, 'Verknipt Festival', 'Maar liefst 95% heeft zijn of haar kaartje bewaard voor Verknipt Festival op 12 juni 2021.','2021-06-12', 'Utrecht', 18,'', '2021-06-12 12:00:00', ' 2021-06-12 23:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (11, 'Solar', 'Solar Weekend Festival is een vierdaags muziekfestival dat sinds 2005 door Extrema georganiseerd wordt bij de Maasplassen bij recreatiegebied De Weerd bij Roermond.', '2021-07-29', 'Roermond', 18, '', '2021-07-29 11:00:00', '2021-07-31 23:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (12, 'Zeezout', 'Dance festival dat sinds 1993 gehouden wordt in Nederland.', '2021-08-27', 'Haarlemmermeer', 18, 'ID & T', '2021-08-27 13:00:00', '2021-08-30 00:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (13, 'Draaimolen', 'Op zaterdag 5 september wordt ZeeZout festival opnieuw georganiseerd. Bij de Tuinen van West kun je dan het festival seizoen mooi afsluiten.', '2021-09-05', 'Amsterdam', 18, 'Thuishaven', '2021-09-05 13:00:00', '2021-09-06 00:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (14, 'Woo hah', 'WOO HAH! is een hiphopfestival dat sinds 2014 jaarlijks plaatsvindt in Tilburg. Het festival wordt georganiseerd door Mojo Concerts en 013 Poppodium binnen de Tilburgse Spoorzone.', '2021-07-09', 'Hilvarenbeek', 0, '', '2021-07-09 11:00:00', '2021-07-12 00:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (15, 'Pinkpop', 'Pinkpop is een jaarlijks, driedaags popfestival in Landgraaf, dat sinds 1970 normaal gesproken in het weekeinde van Pinksteren plaatsvindt.', '2021-06-18', 'Landgraaf', 0, '', '2021-06-18 13:00:00', '2021-06-21 00:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (16, 'Mysteryland', 'Dance festival dat sinds 1993 gehouden wordt in Nederland.', '2019-08-23', 'Haarlemmermeer', 18, 'ID & T', '2019-08-23 13:00:00', '2019-08-25 00:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (17, 'Emporium', 'Dance festival dat sinds 2005 gehouden wordt in Nederland.', '2019-05-25', 'Wijchen', 18, 'The Matrixx', '2019-05-25 12:00:00', '2019-05-26 00:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (18, 'Intents Festival', 'Intents Festival is een drie dagen durend dancefestival. De voornaamste muziekstijlen op intents zijn hardstyle, freestyle en hardcore.', '2019-05-31', 'Oisterwijk', 17, 'Intents Events BV', '2019-05-31 12:00:00', '2019-06-02 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (19, 'Paaspop', 'Paaspop is een driedaags muziekfestival dat elk jaar tijdens het paasweekend plaatsvind in het Nederlandse Schijndel.', '2019-04-19', 'Schijndel', 0, 'Paaspop Events', '2019-04-19 13:30:00', '2019-04-19 02:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (20, 'Defqon.1', 'Defqon.1 is een Nederlands dancefestival dat georganiseerd wordt door Q-dance. Het wordt sinds 2011 gebouden op het evenementen terrein in Biddinghuizen naast Walibi Holland in Flevoland.', '2019-06-28', 'Biddinghuizen', 18, 'Q-dance', '2019-06-28 11:00:00', '2019-06-30 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (21, 'Titanium Festival', 'Zojuist heeft de organisatie van TITANIUM Festival de line-up voor de allereerste editie van het evenement bekendgemaakt.','2019-05-18', 'Vianen', 18,' BKJN Events', '2019-05-18 11:00:00', ' 2019-05-18 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (22, 'Dauw Pop', 'Dauwpop komt in 2019 net zo hard terug! Zet daarom zaterdag 30 mei in je agenda, zodat je zeker weet dat je die dag vrij houdt.','2019-05-30', 'Haarle', 0,' EV Hands', '2019-05-30 11:30:00', ' 2019-05-30 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (23, 'Secret Forest Festival', 'Op zaterdag 25 mei zal Secret Forest Festival weer terug te vinden zijn in Groningen! Dit jaar zal volgens de organisatie het dikste festival van het Noorden wel weer plaatsvinden.','2019-05-25', 'Groningen', 18,'', '2019-05-25 14:00:00', '2019-05-26 01:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (24, 'Drift Festival', 'Dubbel zoveel Drift! De 9e editie van Drift Festival wordt een driegaagse! Op donderdag 8 juni t/m zaterdag 9 juni geven ruim 80 artiesten acte de presence op zeven stages in en rondom de Vasim.','2019-06-08', 'Nijmegen', 18,'Drift', '2019-06-08 14:00:00', ' 2019-06-09 00:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (25, 'Verknipt Festival', 'Maar liefst 95% heeft zijn of haar kaartje bewaard voor Verknipt Festival op 22 juni 2019.','2019-06-22', 'Utrecht', 18,'', '2019-06-22 12:00:00', ' 2019-06-22 23:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (26, 'Solar', 'Solar Weekend Festival is een vierdaags muziekfestival dat sinds 2005 door Extrema georganiseerd wordt bij de Maasplassen bij recreatiegebied De Weerd bij Roermond.', '2019-08-01', 'Roermond', 18, '', '2019-08-01 11:00:00', '2019-08-01 23:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (27, 'Zeezout', 'Dance festival dat sinds 1993 gehouden wordt in Nederland.', '2019-09-07', 'Haarlemmermeer', 18, 'ID & T', '2019-09-07 13:00:00', '2019-09-08 00:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (28, 'Draaimolen', 'Op zaterdag 14 september wordt Draaimolen festival opnieuw georganiseerd. Bij de Tuinen van West kun je dan het festival seizoen mooi afsluiten.', '2019-09-14', 'Amsterdam', 18, 'Thuishaven', '2019-09-14 13:00:00', '2019-09-15 00:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (29, 'Woo hah', 'WOO HAH! is een hiphopfestival dat sinds 2014 jaarlijks plaatsvindt in Tilburg. Het festival wordt georganiseerd door Mojo Concerts en 013 Poppodium binnen de Tilburgse Spoorzone.', '2019-07-12', 'Hilvarenbeek', 0, '', '2019-07-12 11:00:00', '2019-07-14 00:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (30, 'Pinkpop', 'Pinkpop is een jaarlijks, driedaags popfestival in Landgraaf, dat sinds 1970 normaal gesproken in het weekeinde van Pinksteren plaatsvindt.', '2019-06-08', 'Landgraaf', 0, '', '2019-06-08 13:00:00', '2019-06-11 00:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (31, 'Mysteryland', 'Dance festival dat sinds 1993 gehouden wordt in Nederland.', '2018-08-25', 'Haarlemmermeer', 18, 'ID & T', '2018-08-25 13:00:00', '2018-08-26 00:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (32, 'Emporium', 'Dance festival dat sinds 2005 gehouden wordt in Nederland.', '2018-05-26', 'Wijchen', 18, 'The Matrixx', '2018-05-26 12:00:00', '2018-05-27 00:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (33, 'Intents Festival', 'Intents Festival is een drie dagen durend dancefestival. De voornaamste muziekstijlen op intents zijn hardstyle, freestyle en hardcore.', '2018-06-01', 'Oisterwijk', 17, 'Intents Events BV', '2018-06-01 12:00:00', '2018-06-03 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (34, 'Paaspop', 'Paaspop is een driedaags muziekfestival dat elk jaar tijdens het paasweekend plaatsvind in het Nederlandse Schijndel.', '2018-03-30', 'Schijndel', 0, 'Paaspop Events', '2018-03-30 13:30:00', '2018-04-01 02:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (35, 'Defqon.1', 'Defqon.1 is een Nederlands dancefestival dat georganiseerd wordt door Q-dance. Het wordt sinds 2011 gebouden op het evenementen terrein in Biddinghuizen naast Walibi Holland in Flevoland.', '2018-06-22', 'Biddinghuizen', 18, 'Q-dance', '2018-06-22 11:00:00', '2018-06-24 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (36, 'Titanium Festival', 'Zojuist heeft de organisatie van TITANIUM Festival de line-up voor de allereerste editie van het evenement bekendgemaakt.','2018-05-18', 'Vianen', 18,' BKJN Events', '2018-05-18 11:00:00', ' 2018-05-18 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (37, 'Dauw Pop', 'Dauwpop komt in 2018 net zo hard terug! Zet daarom zaterdag 26 mei in je agenda, zodat je zeker weet dat je die dag vrij houdt.','2018-05-26', 'Haarle', 0,' EV Hands', '2018-05-26 11:30:00', ' 2018-05-26 23:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (38, 'Secret Forest Festival', 'Op zaterdag 25 mei zal Secret Forest Festival weer terug te vinden zijn in Groningen! Dit jaar zal volgens de organisatie het dikste festival van het Noorden wel weer plaatsvinden.','2018-05-25', 'Gronigen', 18,'', '2018-05-25 14:00:00', '2018-05-26 01:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (39, 'Drift Festival', 'Dubbel zoveel Drift! De 9e editie van Drift Festival wordt een driegaagse! Op zaterdag 9 juni geven ruim 80 artiesten acte de presence op zeven stages in en rondom de Vasim.','2018-06-09', 'Nijmegen', 18,'Drift', '2018-06-09 14:00:00', ' 2018-06-010 00:00:00');
INSERT INTO festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd)
VALUES (40, 'Verknipt Festival', 'Maar liefst 95% heeft zijn of haar kaartje bewaard voor Verknipt Festival op 28 juli 2018.','2018-07-28', 'Utrecht', 18,'', '2018-07-28 12:00:00', ' 2018-07-28 23:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (41, 'Solar', 'Solar Weekend Festival is een vierdaags muziekfestival dat sinds 2005 door Extrema georganiseerd wordt bij de Maasplassen bij recreatiegebied De Weerd bij Roermond.', '2018-08-02', 'Roermond', 18, '', '2018-08-02 11:00:00', '2018-08-05 23:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (42, 'Zeezout', 'Dance festival dat sinds 1993 gehouden wordt in Nederland.', '2018-09-07', 'Haarlemmermeer', 18, 'ID & T', '2018-09-07 13:00:00', '2018-09-08 00:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (43, 'Draaimolen', 'Op zaterdag 8 september wordt Draaimolen festival opnieuw georganiseerd. Bij de Tuinen van West kun je dan het festival seizoen mooi afsluiten.', '2018-09-08', 'Amsterdam', 18, 'Thuishaven', '2018-09-08 13:00:00', '2018-09-09 00:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (44, 'Woo hah', 'WOO HAH! is een hiphopfestival dat sinds 2014 jaarlijks plaatsvindt in Tilburg. Het festival wordt georganiseerd door Mojo Concerts en 013 Poppodium binnen de Tilburgse Spoorzone.', '2018-07-13', 'Hilvarenbeek', 0, '', '2018-07-13 11:00:00', '2018-07-15 00:00:00');
INSERT INTO Festival (festival_id, naam, omschrijving, datum, plaats, leeftijd, organisator, begintijd, eindtijd) 
VALUES (45, 'Pinkpop', 'Pinkpop is een jaarlijks, driedaags popfestival in Landgraaf, dat sinds 1970 normaal gesproken in het weekeinde van Pinksteren plaatsvindt.', '2018-06-15', 'Landgraaf', 0, '', '2018-06-15 13:00:00', '2018-06-17 00:00:00');



/*partners insert*/
INSERT INTO partners VALUES(1, 'Bavaria');
INSERT INTO partners VALUES(2, 'Coca-Cola');
INSERT INTO partners VALUES(3, 'RedBull');
INSERT INTO partners VALUES(4, 'ING');
INSERT INTO partners VALUES(5, 'ABNAMRO');
INSERT INTO partners VALUES(6, '538');
INSERT INTO partners VALUES(7, 'SlamFM');
INSERT INTO partners VALUES(8, 'Absolut.');
INSERT INTO partners VALUES(9, 'Lipton');
INSERT INTO partners VALUES(10, 'Rabobank');
INSERT INTO partners VALUES(11, 'Desperados');
INSERT INTO partners VALUES(12, 'Flugel');
INSERT INTO partners VALUES(13, 'Eristoff');
INSERT INTO partners VALUES(14, 'Heineken');
INSERT INTO partners VALUES(15, 'Grolsch');
INSERT INTO partners VALUES(16, 'Bacardi');
INSERT INTO partners VALUES(17, 'MaKe Events');
INSERT INTO partners VALUES(18, 'ALDA Events');
INSERT INTO partners VALUES(19, 'In2Event');
INSERT INTO partners VALUES(20, 'Bas Events');

/*festival_partners insert*/
insert into festival_partners values(12, 3, '2021-06-04');
insert into festival_partners values(11, 2, '2021-05-29');
insert into festival_partners values(18, 5, '2021-04-02');
insert into festival_partners values(20, 9, '2021-06-10');
insert into festival_partners values(4, 1, '2021-08-27');
insert into festival_partners values(15, 6, '2021-05-08');
insert into festival_partners values(10, 7, '2021-05-29');
insert into festival_partners values(16, 8, '2021-05-29');
insert into festival_partners values(9, 4, '2021-04-02');
insert into festival_partners values(13, 5, '2021-06-25');
insert into festival_partners values(1, 10, '2021-06-12');
insert into festival_partners values(2, 12, '2021-08-27');
insert into festival_partners values(3, 11, '2021-07-29');
insert into festival_partners values(5, 13, '2021-09-05');
insert into festival_partners values(4, 14, '2021-07-09');
insert into festival_partners values(6, 15, '2021-06-18');
insert into festival_partners values(7, 25, '2019-06-22');
insert into festival_partners values(8, 24, '2019-06-08');
insert into festival_partners values(10, 19, '2019-04-19');
insert into festival_partners values(14, 26, '2019-08-01');
insert into festival_partners values(17, 27, '2019-09-07');
insert into festival_partners values(19, 28, '2019-09-14');
insert into festival_partners values(20, 29, '2019-07-02');
insert into festival_partners values(1, 30, '2019-06-08');
insert into festival_partners values(3, 18, '2019-05-31');
insert into festival_partners values(4, 17, '2019-05-25');
insert into festival_partners values(5, 20, '2019-06-28');
insert into festival_partners values(11, 24, '2019-06-08');
insert into festival_partners values(12, 16, '2019-08-23');
insert into festival_partners values(8, 21, '2019-05-18');
insert into festival_partners values(10, 22, '2019-05-30');
insert into festival_partners values(16, 23, '2019-05-23');
insert into festival_partners values(12, 31, '2018-08-25');
insert into festival_partners values(11, 32, '2018-05-26');
insert into festival_partners values(18, 33, '2018-06-01');
insert into festival_partners values(20, 34, '2018-03-30');
insert into festival_partners values(4, 35, '2018-06-22');
insert into festival_partners values(15, 36, '2018-05-18');
insert into festival_partners values(10, 37, '2018-05-26');
insert into festival_partners values(16, 38, '2018-05-25');
insert into festival_partners values(11, 39, '2018-06-09');
insert into festival_partners values(18, 40, '2018-07-28');
insert into festival_partners values(20, 41, '2018-08-02');
insert into festival_partners values(4, 42, '2018-09-07');
insert into festival_partners values(15, 43, '2018-09-08');
insert into festival_partners values(10, 44, '2018-07-13');
insert into festival_partners values(16, 45, '2018-06-15');


/*sponsoren insert*/
INSERT INTO sponsoren (
	sponsor_id,
	naam,
	beschrijving
)
VALUES
	(4127, 'Reco', 'Bij RECO huurt u sanitaire voorzieningen. Toiletwagens, plaszuilen en eco toiletten. Huur nu uw sanitaire voorzieningen en verminder wachttijden. Gratis specialistisch advies'),
	(6849, 'Jupiler', 'Jupiler is een Belgisch pilsbier met een marktaandeel van zon 52% in het eigen land. Het bier wordt gebrouwen door brouwerij Piedbœuf.'),
	(4214, 'Stagecrew', 'Welkom op Stagecrewevents.nl. Stagecrew is een jong en vooruitstrevend bedrijf. Wij zijn gespecialiseerd in verhuur, verkoop en realisatie.'),
	(8690, 'Durex', 'Ontdek relatieadvies, seksuele gezondheidstips en leer zelfs om betere seks te hebben, met informatie van onze experts hier bij Durex.nl.'),
	(5832, 'ING', 'Bij ING regelt u zonder gedoe al uw dagelijkse bankzaken. Met oog voor later. Altijd.'),
	(8649, 'KPN', 'Met kpn Hussel stel je al jouw thuis en mobiele abonnementen zelf samen. Internet, mobiel, TV, entertainment en meer. Via het netwerk van Nederland.'),
	(1246, 'Hema', 'Op hema.nl vind je de HEMA winkel met het grootste assortiment. Bestel eenvoudig online en laat je bestelling thuisbezorgen of haal gratis af bij jouw HEMA.'),
	(7503, 'Miele', 'Miele is een Duitse machinefabriek, die vooral bekend werd als fabrikant van huishoudelijke apparatuur.'),
	(3043, 'Red Bull', 'Hier vind je het laatste nieuws, live streams, videos en fotos van de wereld van Red Bull met o.a. motorsport-, bike-, muziek-, stay fit-, watersport'),
	(2940, 'Arriva', 'Openbaar vervoer waar je op kunt vertrouwen, dat is waar wij ons hard voor maken. Of je nou met de trein of bus gaat: wij zorgen voor een goede reis.'),
	(6606, 'TicketSwap', 'Op TicketSwap koop en verkoop je veilig, makkelijk en eerlijk tickets voor concerten, festivals, sportwedstrijden, theater en dagjes weg.'),
	(4973, 'Jumbo', 'Jumbo is een Nederlandse keten van supermarkten van Jumbo Groep Holding B.V., die eigendom is van Stichting Administratiekantoor Van Eerd Groep Holding.'),
	(2442, 'Spar', 'SPAR is de winkel voor de verse, dagelijkse boodschappen. Bestel je boodschappen en laat ze bezorgen of haal ze op in de winkel. Je vindt het bij SPAR.'),
	(0990, 'Sligro', 'Sligro Food Group is een Nederlandse beursgenoteerde onderneming met het hoofdkantoor te Veghel. Tot Sligro Food Group behoren onder meer de bedrijven Sligro en Van Hoeckel.'),
	(1626, 'PayLogic', 'Music festivalklassiek concertsports eventits complicated met de naam en wil tickets en hotelkamers verkopen op mijn website in mijn eigen look&feel. Shuffle.'),
	(2222, 'Geen sponsor', 'Geen sponsor');

/*beschikbare_middelen insert*/
INSERT INTO beschikbare_middelen (
	item_id,
	festival_id,
	sponsor_id,
	item,
	omschrijving,
	aantal,
	waarde
)
VALUES
	(12319, 1, 4127, 'Toiletten', 'Toiletten voor de bezoekers van het festival', 200, 10000),
	(57832, 2, 6849, 'Bier', 'Bier voor de verkoop op het festival', '' ,'' ),
	(35847, 3, 4214, 'Geluidsinstallatie', 'Geluidsinstallatie voor bij de podia', 8, 8000),
	(31235, 4, 8690, 'Condooms', 'Condooms om uit te delen op het festival', 20000, 40000),
	(59774, 5, 5832, 'Budget', 'Budget om het festival te realsieren','', 100000),
	(64399, 6, 8649, 'Versterkers', 'Versterkers om het internetbereik op het festival te versnellen', 100, 10000),
	(02153, 7, 1246, 'Doeken', 'Doeken met drukwerk om de sponsoren in beeld te brengen', 100, 4500),
	(37158, 8, 7503, 'Electronica', 'Ovens en koelkasten om het eten te verzorgen', 30, 9000),
	(50313, 9, 3043, 'Budget', 'Budget om het festival te realiseren', '', 150000),
	(23122, 10, 2940, 'Vervoer', 'Treinen en bussen om de bezoekers naar het festival te brengen', '', 50000),
	(49243, 11, 6606, '', 'Bezoekers kunnen hier de tickets verkopen en kopen', '',''),
	(71009, 12, 4973, 'Eet servies', 'Messen, vorken, lepels, prikkers en doekjes','' , 5000),
	(48834, 13, 2442, 'Vlees', 'Vlees om de catering van vlees te voorzien','' , 75000),
	(04422, 14, 0990, 'Groenten', 'Groente om de catering van vlees te voorzien', '', 50000),
	(45453, 15, 1626, 'Betaalsysteem', 'Betaalsysteem waarbij bezoekers hun tickets kunnen afrekenen','' ,'' ),
	(12910, 16, 4127, 'Toiletten', 'Toiletten voor de bezoekers van het festival', 200, 10000),
	(57833, 17, 6849, 'Bier', 'Bier voor de verkoop op het festival', '' ,'' ),
	(35844, 18, 4214, 'Geluidsinstallatie', 'Geluidsinstallatie voor bij de podia', 8, 8000),
	(31265, 19, 8690, 'Condooms', 'Condooms om uit te delen op het festival', 20000, 40000),
	(59704, 20, 5832, 'Budget', 'Budget om het festival te realsieren','', 100000),
	(64392, 21, 8649, 'Versterkers', 'Versterkers om het internetbereik op het festival te versnellen', 100, 10000),
	(02193, 22, 1246, 'Doeken', 'Doeken met drukwerk om de sponsoren in beeld te brengen', 100, 4500),
	(37138, 23, 7503, 'Electronica', 'Ovens en koelkasten om het eten te verzorgen', 30, 9000),
	(50943, 24, 3043, 'Budget', 'Budget om het festival te realiseren', '', 150000),
	(23442, 25, 2940, 'Vervoer', 'Treinen en bussen om de bezoekers naar het festival te brengen', '', 50000),
	(46643, 26, 6606, '', 'Bezoekers kunnen hier de tickets verkopen en kopen', '',''),
	(78509, 27, 4973, 'Eet servies', 'Messen, vorken, lepels, prikkers en doekjes','' , 5000),
	(46834, 28, 2442, 'Vlees', 'Vlees om de catering van vlees te voorzien','' , 75000),
	(04832, 29, 0990, 'Groenten', 'Groente om de catering van vlees te voorzien', '', 50000),
	(45450, 30, 1626, 'Betaalsysteem', 'Betaalsysteem waarbij bezoekers hun tickets kunnen afrekenen','' ,'' ),
	(12310, 31, 4127, 'Toiletten', 'Toiletten voor de bezoekers van het festival', 200, 10000),
	(57831, 32, 6849, 'Bier', 'Bier voor de verkoop op het festival', '' ,'' ),
	(35849, 33, 4214, 'Geluidsinstallatie', 'Geluidsinstallatie voor bij de podia', 8, 8000),
	(31365, 34, 8690, 'Condooms', 'Condooms om uit te delen op het festival', 20000, 40000),
	(59784, 35, 5832, 'Budget', 'Budget om het festival te realsieren','', 100000),
	(64192, 36, 8649, 'Versterkers', 'Versterkers om het internetbereik op het festival te versnellen', 100, 10000),
	(02198, 37, 1246, 'Doeken', 'Doeken met drukwerk om de sponsoren in beeld te brengen', 100, 4500),
	(37458, 38, 7503, 'Electronica', 'Ovens en koelkasten om het eten te verzorgen', 30, 9000),
	(50923, 39, 3043, 'Budget', 'Budget om het festival te realiseren', '', 150000),
	(23440, 40, 2940, 'Vervoer', 'Treinen en bussen om de bezoekers naar het festival te brengen', '', 50000),
	(46663, 41, 6606, '', 'Bezoekers kunnen hier de tickets verkopen en kopen', '',''),
	(78589, 42, 4973, 'Eet servies', 'Messen, vorken, lepels, prikkers en doekjes','' , 5000),
	(46837, 43, 2442, 'Vlees', 'Vlees om de catering van vlees te voorzien','' , 75000),
	(04836, 44, 0990, 'Groenten', 'Groente om de catering van vlees te voorzien', '', 50000),
	(45455, 45, 1626, 'Betaalsysteem', 'Betaalsysteem waarbij bezoekers hun tickets kunnen afrekenen','' ,'' );

/*festival_categorie insert*/
INSERT INTO festival_categorie (categorie_id, naam, omschrijving, genre)
VALUES (1, 'House', 'Onderdeel van EDM', 'EDM');
INSERT INTO festival_categorie (categorie_id, naam, omschrijving, genre)
VALUES (2, 'Techno', 'Onderdeel van EDM', 'EDM');
INSERT INTO festival_categorie (categorie_id, naam, omschrijving, genre)
VALUES (3, 'Pop', 'Popmuziek is een afkorting van populaire muziek', 'Pop');
INSERT INTO festival_categorie (categorie_id, naam, omschrijving, genre)
VALUES (4, 'Rock', 'Rock is een muziekgenre dat traditioneel gekenmerkt wordt door een bezetting van gitaar, basgitaar en drums, aangevuld met zang en/of andere instrumenten. ', 'Rock');
INSERT INTO festival_categorie (categorie_id, naam, omschrijving, genre)
VALUES (5, 'Techno', 'Techno is een elektronische muziekstijl die het levenslicht zag in de jaren zeventig van de twintigste eeuw, maar zich met name in de jaren 80 ontwikkelde in onder andere Detroit en Frankfurt.', 'EDM');
INSERT INTO festival_categorie (categorie_id, naam, omschrijving, genre)
VALUES (6, 'Hardstyle', 'Hardstyle is een elektronisch muziekgenre dat overeenkomsten vertoont met Hardcore en Hardtrance. Het gemiddelde tempo ligt rond de 150 bpm.', 'EDM');
INSERT INTO festival_categorie (categorie_id, naam, omschrijving, genre)
VALUES (7, 'Hardcore', 'Hardcore house, Rotterdam hardcore of hardcore en hardcore techno in het buitenland, is een muziekgenre dat bekendstaat als de hardste en snelste techno of housemuziek die er is.', 'EDM');
INSERT INTO festival_categorie (categorie_id, naam, omschrijving, genre)
VALUES (8, 'Trance','Trance is een ondersoort van dance waarin de nadruk op de melodie en de euforische sfeer ligt. In het midden van de plaat is vaak een break, die toewerkt naar een climax.', 'EDM');
INSERT INTO festival_categorie (categorie_id, naam, omschrijving, genre)
VALUES (9, 'Trance','Disco is een dansmuziekgenre dat zijn oorsprong vindt in de discotheken.', 'Disco');
INSERT INTO festival_categorie (categorie_id, naam, omschrijving, genre)
VALUES (10, 'Reggae','Reggae is een muzieksoort die afkomstig is van Jamaica. Eerst was op Jamaica de Amerikaanse muziek erg populair. Later begonnen muzikanten zelf met muziek te experimenteren.', 'Reggae');


/*festival_categorie_festival insert*/
INSERT INTO festival_categorie_festival VALUES(1,1);
INSERT INTO festival_categorie_festival VALUES(2,6);
INSERT INTO festival_categorie_festival VALUES(3,6);
INSERT INTO festival_categorie_festival VALUES(4,3);
INSERT INTO festival_categorie_festival VALUES(5,7);
INSERT INTO festival_categorie_festival VALUES(6,7);
INSERT INTO festival_categorie_festival VALUES(7,3);
INSERT INTO festival_categorie_festival VALUES(8,1);
INSERT INTO festival_categorie_festival VALUES(9,2);
INSERT INTO festival_categorie_festival VALUES(10,2);
INSERT INTO festival_categorie_festival VALUES(11,2);
INSERT INTO festival_categorie_festival VALUES(12,8);
INSERT INTO festival_categorie_festival VALUES(13,9);
INSERT INTO festival_categorie_festival VALUES(14,3);
INSERT INTO festival_categorie_festival VALUES(15,4);
INSERT INTO festival_categorie_festival VALUES(16,1);
INSERT INTO festival_categorie_festival VALUES(17,7);
INSERT INTO festival_categorie_festival VALUES(18,7);
INSERT INTO festival_categorie_festival VALUES(19,3);
INSERT INTO festival_categorie_festival VALUES(20,6);
INSERT INTO festival_categorie_festival VALUES(21,6);
INSERT INTO festival_categorie_festival VALUES(22,3);
INSERT INTO festival_categorie_festival VALUES(23,1);
INSERT INTO festival_categorie_festival VALUES(24,5);
INSERT INTO festival_categorie_festival VALUES(25,5);
INSERT INTO festival_categorie_festival VALUES(26,5);
INSERT INTO festival_categorie_festival VALUES(27,9);
INSERT INTO festival_categorie_festival VALUES(28,8);
INSERT INTO festival_categorie_festival VALUES(29,3);
INSERT INTO festival_categorie_festival VALUES(30,4);
INSERT INTO festival_categorie_festival VALUES(31,1);
INSERT INTO festival_categorie_festival VALUES(32,7);
INSERT INTO festival_categorie_festival VALUES(33,7);
INSERT INTO festival_categorie_festival VALUES(34,3);
INSERT INTO festival_categorie_festival VALUES(35,6);
INSERT INTO festival_categorie_festival VALUES(36,6);
INSERT INTO festival_categorie_festival VALUES(37,3);
INSERT INTO festival_categorie_festival VALUES(38,1);
INSERT INTO festival_categorie_festival VALUES(39,5);
INSERT INTO festival_categorie_festival VALUES(40,5);
INSERT INTO festival_categorie_festival VALUES(41,5);
INSERT INTO festival_categorie_festival VALUES(42,9);
INSERT INTO festival_categorie_festival VALUES(43,8);
INSERT INTO festival_categorie_festival VALUES(44,3);
INSERT INTO festival_categorie_festival VALUES(45,4);



/*ticket_categorie insert*/
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal)
VALUES (1, 'Early bird', 46.00, 3200);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal)
VALUES (2, 'Normale ticket', 69.00, 11200);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal)
VALUES (3, 'Groeps ticket', 250.00, 1120);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal)
VALUES (4, 'Early bird', 46.00, 3200);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal)
VALUES (5, 'Normale ticket', 69.00, 11200);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal)
VALUES (6, 'Groeps ticket', 250.00, 1120);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal)
VALUES (7, 'Early bird', 46.00, 3200);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal)
VALUES (8, 'Normale ticket', 69.00, 11200);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal)
VALUES (9, 'Groeps ticket', 250.00, 1120);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal) 
VALUES (10, 'Normale ticket', 69.00, 20000);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal) 
VALUES (11, 'Normale ticket', 69.00, 20000);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal) 
VALUES (12, 'Normale ticket', 69.00, 20000);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal) 
VALUES (13, 'Normale ticket', 69.00, 20000);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal) 
VALUES (14, 'Normale ticket', 69.00, 20000);
INSERT INTO ticket_categorie (ticket_categorie, soort, prijs, aantal) 
VALUES (15, 'Normale ticket', 69.00, 20000);


/*bezoeker insert*/
INSERT INTO bezoeker VALUES (1, 'Jan', 'Peters', 'man', '1990-03-19', 'Voerendaal', 'janpeters@mail.com', 0645362516);
INSERT INTO bezoeker VALUES  (2, 'Piet', 'Jansen', 'man', '1988-01-19', 'Maastricht', 'Pietjansen@mail.com', 0694822516);
INSERT INTO bezoeker VALUES  (3, 'Hans', 'Hendriks', 'man', '2000-01-27', 'Venlo', 'Hanshendriks@mail.com', 0694824536);
INSERT INTO bezoeker VALUES  (4, 'Simone', 'Frederiks', 'vrouw', '2000-05-21', 'Roermond', 'Simonefr@mail.com', 0694820739);
INSERT INTO bezoeker VALUES  (5, 'Lies', 'van Straten', 'vrouw', '1999-11-13', 'Venray', 'liesvstraten@mail.com', 0667260092);
INSERT INTO bezoeker VALUES  (6, 'Erik', 'Smeets', 'man', '2001-12-17', 'Heijen', 'erikje@mail.com', 0628954312);
INSERT INTO bezoeker VALUES  (7, 'Linda', 'Bouwer', 'vrouw', '1992-06-30', 'Utrecht', 'bouwerlinda@mail.com', 0692846512);
INSERT INTO bezoeker VALUES  (8, 'Bob', 'Gerards', 'man', '1989-02-11', 'Venlo', 'BobGerards@mail.com', 0609378241);
INSERT INTO bezoeker VALUES  (9, 'Sanne', 'Toeter', 'vrouw', '2000-12-24', 'Zaandam', 'Sannetoettoet@mail.com', 0656802712);
INSERT INTO bezoeker VALUES  (10, 'Lars', 'Helden', 'man', '1999-03-26', 'Venray', 'Heldjelars@mail.com', 0672040095);
INSERT INTO bezoeker VALUES  (11, 'Luc', 'Konings', 'man', '1997-09-02', 'Rotterdam', 'lucking@mail.com', 0691047538);
INSERT INTO bezoeker VALUES  (12, 'Lis', 'de Rode', 'vrouw', '1998-05-01', '', 'lisderode@mail.com', 0640923854);
INSERT INTO bezoeker VALUES  (13, 'Frederiek', 'Hermans', 'vrouw', '1999-09-16', 'Heerlen', 'Frederiekhermans@mail.com', 0667306222);
INSERT INTO bezoeker VALUES  (14, 'Silke', 'van der Valk', 'vrouw', '1999-02-13', 'Helmond', 'silkevdv@mail.com', 069275022);
INSERT INTO bezoeker VALUES  (15, 'Milan', 'Paters', 'man', '2000-08-19', 'Nijmegen', 'milanpaters@mail.com', 0618401133);
INSERT INTO bezoeker VALUES  (16, 'Tijmen', 'Goudsblom', 'man', '1997-05-14', 'Amersfoort', 'tgoudsblom@gmail.com', 0640952166); 
INSERT INTO bezoeker VALUES  (17, 'Robin', 'van de Hoef', 'man', '1998-02-02', 'Hoogland', 'robinvdhoef@hetnet.nl', 0629429354); 
INSERT INTO bezoeker VALUES  (18, 'Ricardo', 'Sihombing', 'man', '1994-12-25', 'Hooglanderveen', 'rshihombingcharles@gmail.com', 0620119291); 
INSERT INTO bezoeker VALUES  (19, 'Abderahman', 'Oudammani', 'man', '1997-03-10', 'Rotterdam', 'appieoudammani@gmail.com', 0621955595); 
INSERT INTO bezoeker VALUES  (20, 'Sanne', 'Bosschuizen', 'vrouw', '1999-06-22', 'Tilburg', 'sannebosschuizen@hetnet.nl', 0655543246); 
INSERT INTO bezoeker VALUES  (21, 'Sanne', 'Eijbergen', 'vrouw', '1999-09-13', 'Hoogland', 'santjeibergen@gmail.com', 0621244468); 
INSERT INTO bezoeker VALUES  (22, 'Lucas', 'van Halteren', 'man', '1993-01-01', 'Bunschoten-Spakenburg', 'hvanhalteren@gmail.com', 0679540311); 
INSERT INTO bezoeker VALUES  (23, 'Isabelle', 'Snoekie', 'vrouw', '1988-09-24', 'Vathorst', 'snoekie@casema.nl', 0626926860); 
INSERT INTO bezoeker VALUES  (24, 'Lisa', 'Vergunst', 'vrouw', '1999-06-22', 'Vathorst', 'lisanynkevergunst@gmail.com', 0679320196); 
INSERT INTO bezoeker VALUES  (25, 'Quinty', 'Hoksbergen', 'vrouw', '1996-07-28', 'Groningen', 'qhoks@gmail.com', 0654603103); 
INSERT INTO bezoeker VALUES  (26, 'Daan', 'van Elburg', 'man', '1998-03-14', 'Enschede', 'elburgdaan@hetnet.nl', 0677796531); 
INSERT INTO bezoeker VALUES  (27, 'Daan', 'Hofland', 'man', '1991-04-26', 'Amsterdam', 'hoffiedaan@hetnet.nl', 0689522104); 
INSERT INTO bezoeker VALUES  (28, 'Mila', 'Petty', 'vrouw', '1997-08-06', 'Eindhoven', 'pettympetty@gmail.com', 0655412023); 
INSERT INTO bezoeker VALUES  (29, 'Sow', 'Young', 'man', '2000-01-06', 'Roermond', 'sowold@gmail.com', 0655749302); 
INSERT INTO bezoeker VALUES  (30, 'Weyh', 'Tou Haut', 'man', '1994-11-15', 'Helmond', 'weyhhtoocold@gmail.com', 0695883929); 
INSERT INTO bezoeker VALUES (31, 'Mohammed', 'El Khayatti', 'man', '1993-03-04', 'Ottersum', 'MELK@gmail.com', 0642840975);  
INSERT INTO bezoeker VALUES  (32, 'Dirkje', 'Ter Burg', 'vrouw', '1985-04-22', 'Gennep', 'Pietjansen@hotmail.com', 0639384823);  
INSERT INTO bezoeker VALUES  (33, 'Mees', 'Konings', 'vrouw', '2000-11-24', 'Grubbenvorst', 'meeskonings@mail.com', 0676563211);  
INSERT INTO bezoeker VALUES  (34, 'Fransisca', 'Frederiks', 'vrouw', '2000-06-23', 'Ridderkerk', 'FF@yahoo.com', 0645567899);  
INSERT INTO bezoeker VALUES  (35, 'Boudewijn', 'Stockovich', 'man', '1989-11-06', 'Boxmeer', 'BBS@mail.com', 0664758922);  
INSERT INTO bezoeker VALUES  (36, 'Famke', 'van Hout', 'vrouw', '2000-10-23', 'Middelburg', 'framkehout00@gmail.com', 0685957433);  
INSERT INTO bezoeker VALUES  (37, 'Nynke', 'Schuurman', 'vrouw', '1992-04-30', 'Leerdam', 'gekkepaarden@gmail.com', 0678905466);  
INSERT INTO bezoeker VALUES  (38, 'Eefje', ' Jonco', 'vrouw', '1981-08-12', 'Den Haag', 'EefjeJ@hotmail.com', 0654742344);  
INSERT INTO bezoeker VALUES  (39, 'Fabio', 'Lekatompessy', 'man', '1983-11-22', 'Groningen', 'ganggang21@gmail.com', 0646574322);  
INSERT INTO bezoeker VALUES  (40, 'Regina', 'Coolio', 'vrouw', '1992-04-26', 'Groeningen', 'Paardenmeisje3432@hotmail.com', 0654000099);  
INSERT INTO bezoeker VALUES  (41, 'Madelief', 'van Donk', 'vrouw', '1992-11-03', 'Tilburg', 'luckin1g@yahoo.com', 0673847765);  
INSERT INTO bezoeker VALUES  (42, 'Berend', 'Smits', 'man', '1998-05-01', 'Cuijk', 'BotjeB@gmail.com', 0632326655);  
INSERT INTO bezoeker VALUES  (43, 'Barend', 'Lamers', 'man', '2000-11-24 ', 'Haps', 'Baaaaarend@hotmail.com', 0622134567);  
INSERT INTO bezoeker VALUES  (44, 'Silke', 'Bakkers', 'vrouw', '1989-02-14', 'Oploo', 'silkebv@mail.com', 0678437789); 
INSERT INTO bezoeker VALUES  (45, 'Janine', 'van Dijk', 'vrouw', '1974-04-12', 'Arnhem', 'JvD2934@mmail.com', 0689945567); 
INSERT INTO bezoeker VALUES (46, 'Michiel', 'Willemse', 'man', '2001-03-16', 'Amersfoort', 'mwillemse@mail.com', 061702345) 
INSERT INTO bezoeker VALUES (47, 'Pedro', 'Dimono', 'man', '1999-05-29', 'Middelburg', 'pedrodimono@mail.com', 0640982615) 
INSERT INTO bezoeker VALUES (48, 'Suzette', 'de Boer', 'vrouw', '1997-02-01', 'Nijmegen', 'suzetteboer@mail.com', 0694830199) 
INSERT INTO bezoeker VALUES (49, 'Frederica', 'Palla', 'vrouw', '2000-08-18', 'Arnhem', 'fredericavdb@mail.com', 0618560134) 
INSERT INTO bezoeker VALUES (50, 'Milan', 'Knol', 'man', '1995-04-19', 'Zeist', 'milanknol@mail.com', 0600339944) 
INSERT INTO bezoeker VALUES (51, 'Abdul', 'Zwula', 'man', '2002-02-10', 'Rotterdam', 'abdulzwulla@mail.com', 0688297748) 
INSERT INTO bezoeker VALUES (52, 'Aron', 'Daders', 'man', '1991-05-22', 'Nuth', 'arondaders@mail.com', 0616470273) 
INSERT INTO bezoeker VALUES (53, 'Heinrich', 'Sezzen', 'man', '1994-06-30', 'Bedum', 'heinrichsezzen@mail.com', 0600831092) 
INSERT INTO bezoeker VALUES (54, 'Senna', 'Brinte', 'vrouw', '1999-10-19', 'Zandvoort', 'sennab@mail.com', 0600376251) 
INSERT INTO bezoeker VALUES (55, 'Tim', 'de Man', 'man', '2000-01-09', 'Nijmegen', 'mantim@mail.com', 0645829600) 
INSERT INTO bezoeker VALUES (56, 'Erik', 'Rustig', 'man', '1995-03-23', 'Vlissingen', 'erikdoerustig@mail.com', 0664779912) 
INSERT INTO bezoeker VALUES (57, 'Marietje', 'Quadvlieg', 'vrouw', '1988-01-18', 'Biddinghuizen', 'marietjeq@mail.com', 0699012349) 
INSERT INTO bezoeker VALUES (58, 'Minou', 'Kramer', 'vrouw', '2000-02-12', 'Gennep', 'minoukramer@mail.com', 0683761233) 
INSERT INTO bezoeker VALUES (59, 'Katja', 'Barnjard', 'vrouw', '1999-10-29', 'Texel', 'katjab@mail.com', 0698421700) 
INSERT INTO bezoeker VALUES (60, 'Mitch', 'Peters', 'man', '2000-08-19', 'Roermond', 'mitchpeters@mail.com', 0633556133) 
INSERT INTO bezoeker VALUES  (61, 'Nando', 'Seuren', 'man', '1992-03-19', 'Deurne', 'nando@mail.com', 0622769201); 
INSERT INTO bezoeker VALUES  (62, 'Simon', 'Jansen', 'man', '1986-07-20', 'Wageningen', 'simon@outlook.com', 0674029226); 
INSERT INTO bezoeker VALUES  (63, 'Dirk', 'Litjens', 'man', '1999-01-15', 'Leiden', 'dirk@hotmail.com', 0675889202); 
INSERT INTO bezoeker VALUES  (64, 'Gijs', 'Remy', 'man', '1978-08-01', 'Heusden', 'gijs@hotmail.com', 0653729466); 
INSERT INTO bezoeker VALUES  (65, 'Pim', 'Jenniskens', 'man', '1976-05-20', 'Arnhem', 'pim@live.nl', 0692749201); 
INSERT INTO bezoeker VALUES  (66, 'Thijs', 'Dings', 'man', '2000-01-14', 'Urk', 'thijs@gmail.nl', 0675940182); 
INSERT INTO bezoeker VALUES  (67, 'Wouter', 'Van der Waerden', 'man', '2001-02-11', 'Erp', 'wouter@live.nl', 0600829311); 
INSERT INTO bezoeker VALUES  (68, 'Jaap', 'Verbeek', 'man', '1967-01-02', 'Hattem', 'jaap@outlook.com', 0612748201); 
INSERT INTO bezoeker VALUES  (69, 'Lisa', 'Pauwels', 'vrouw', '1965-11-30', 'Amersfort', 'lis@outlook.nl', 0692847501); 
INSERT INTO bezoeker VALUES  (70, 'Marissa', 'Vullings', 'vrouw', '1973-01-27', 'Amersfort', 'marissa@gmail.nl', 0699524018); 
INSERT INTO bezoeker VALUES  (71, 'Pascal', 'Tiel', 'vrouw', '1989-06-21', 'Doesburg', 'pascal@hotmail.com', 0677213012); 
INSERT INTO bezoeker VALUES  (72, 'Eva', 'Thomassen', 'vrouw', '1986-08-19', 'Zaandam', 'eva@gmail.nl', 0682646401); 
INSERT INTO bezoeker VALUES  (73, 'Liselot', 'Jansen', 'vrouw', '1975-09-04', 'Spakenburg', 'liselot@live.com', 0625257482); 
INSERT INTO bezoeker VALUES  (74, 'Jet', 'Kuijpers', 'vrouw', '1969-12-12', 'Naarden', 'jet@live.nl', 0684930302); 
INSERT INTO bezoeker VALUES  (75, 'Vera', 'Slagter', 'vrouw', '1971-11-23', 'Veulen', 'vera@outlook.com', 0674121292); 

/*tickets insert*/
INSERT INTO tickets values (1, 2, 15, 12, 7760);
INSERT INTO tickets values (2, 3, 1, 11, 1164);
INSERT INTO tickets values (3, 4, 2, 10, 155);
INSERT INTO tickets values (4, 5, 3, 9, 176);
INSERT INTO tickets values (5, 6, 4, 7, 1940);
INSERT INTO tickets values (6, 7, 5, 8, 5000);
INSERT INTO tickets values (7, 8, 6, 15, 2000);
INSERT INTO tickets values (8, 9, 7, 14, 250);
INSERT INTO tickets values (9, 10, 8, 13, 2111);
INSERT INTO tickets values (10, 11, 9, 3, 600);
INSERT INTO tickets values (11, 12, 10, 2, 3000);
INSERT INTO tickets values (12, 13, 11, 1, 1000);
INSERT INTO tickets values (13, 14, 12, 6, 2900);
INSERT INTO tickets values (14, 15, 13, 4, 1500);
INSERT INTO tickets values (15, 1, 14, 5, 1700);
INSERT INTO tickets values (16, 30, 30, 12, 7760);
INSERT INTO tickets values (17, 29, 16, 11, 19771); 
INSERT INTO tickets values (18, 28, 17, 10, 18520);
INSERT INTO tickets values (19, 27, 18, 9, 1089);
INSERT INTO tickets values (20, 26, 19, 7, 2940);
INSERT INTO tickets values (21, 25, 20, 8, 11176);
INSERT INTO tickets values (22, 24, 21, 15, 19833);
INSERT INTO tickets values (23, 22, 22, 14, 988);
INSERT INTO tickets values (24, 23, 23, 13, 2110);
INSERT INTO tickets values (25, 21, 24, 3, 2980);
INSERT INTO tickets values (26, 20, 25, 2, 10985);
INSERT INTO tickets values (27, 19, 26, 1, 2700);
INSERT INTO tickets values (28, 18, 27, 6, 10781);
INSERT INTO tickets values (29, 17, 28, 4, 3200);
INSERT INTO tickets values (30, 16, 29, 5, 11189);
INSERT INTO tickets values (31, 32, 15, 12, 7760);
INSERT INTO tickets values (32, 33, 1, 11, 1164);
INSERT INTO tickets values (33, 34, 2, 10, 155);
INSERT INTO tickets values (34, 35, 3, 9, 176);
INSERT INTO tickets values (35, 36, 4, 7, 1940);
INSERT INTO tickets values (36, 37, 5, 8, 5000);
INSERT INTO tickets values (37, 38, 6, 15, 2000);
INSERT INTO tickets values (38, 39, 7, 14, 250);
INSERT INTO tickets values (39, 40, 21, 13, 19833); 
INSERT INTO tickets values (40, 41, 22, 3, 988); 
INSERT INTO tickets values (41, 42, 23, 2, 3000);
INSERT INTO tickets values (42, 43, 24, 1, 2980);
INSERT INTO tickets values (43, 44, 25, 6, 10985);
INSERT INTO tickets values (44, 45, 26, 4, 2700);
INSERT INTO tickets values (45, 31, 27, 5, 10781);
INSERT INTO tickets values (46, 2, 31, 12, 19829);
INSERT INTO tickets values (47, 3, 32, 11, 2879);
INSERT INTO tickets values (48, 4, 33, 10, 19964);
INSERT INTO tickets values (49, 5, 34, 9, 1117);
INSERT INTO tickets values (50, 6, 35, 7, 11185);
INSERT INTO tickets values (51, 7, 36, 8, 1105);
INSERT INTO tickets values (52, 8, 37, 15, 2000);
INSERT INTO tickets values (53, 9, 38, 14, 2590);
INSERT INTO tickets values (54, 10, 39, 13, 19877);
INSERT INTO tickets values (55, 11, 40, 3, 972);
INSERT INTO tickets values (56, 12, 41, 2, 18820);
INSERT INTO tickets values (57, 13, 42, 1, 2866);
INSERT INTO tickets values (58, 14, 43, 6, 1077);
INSERT INTO tickets values (59, 15, 44, 4, 3198);
INSERT INTO tickets values (60, 1, 45, 5, 11183);
INSERT INTO tickets values (61, 30, 30, 12, 7760); 
INSERT INTO tickets values (62, 29, 16, 11, 19771);
INSERT INTO tickets values (63, 28, 17, 10, 18520);
INSERT INTO tickets values (64, 27, 18, 9, 1089);
INSERT INTO tickets values (65, 26, 19, 7, 2940);
INSERT INTO tickets values (66, 25, 20, 8, 11176);
INSERT INTO tickets values (67, 24, 21, 15, 19833);
INSERT INTO tickets values (68, 22, 22, 14, 988);
INSERT INTO tickets values (69, 23, 23, 13, 2110);
INSERT INTO tickets values (70, 21, 24, 3, 2980);
INSERT INTO tickets values (71, 20, 25, 2, 10985);
INSERT INTO tickets values (72, 19, 26, 1, 2700);
INSERT INTO tickets values (73, 18, 27, 6, 10781);
INSERT INTO tickets values (74, 17, 28, 4, 3200);
INSERT INTO tickets values (75, 16, 29, 5, 11189);
INSERT INTO tickets values (76, 32, 15, 12, 7760);
INSERT INTO tickets values (77, 33, 1, 11, 1164); 
INSERT INTO tickets values (78, 34, 40, 10, 972);  
INSERT INTO tickets values (79, 35, 39, 9, 19877); 
INSERT INTO tickets values (80, 36, 38, 7, 2590); 
INSERT INTO tickets values (81, 37, 45, 8, 11183);
INSERT INTO tickets values (82, 38, 42, 15, 2866);
INSERT INTO tickets values (83, 39, 41, 14, 18820);
INSERT INTO tickets values (84, 40, 37, 13, 2000);
INSERT INTO tickets values (85, 41, 36, 3, 1105); 
INSERT INTO tickets values (86, 42, 35, 2, 11185);
INSERT INTO tickets values (87, 43, 34, 1, 1117);
INSERT INTO tickets values (88, 44, 33, 6, 19964);
INSERT INTO tickets values (89, 45, 32, 4, 2879);
INSERT INTO tickets values (90, 31, 31, 5, 19829);

/*verkoop_producten insert*/
INSERT INTO Verkoop_producten (verkoop_id, naam, prijs, aantal) 
VALUES 
(2020412, 'Waterflesje', 2.50, 19342), 
(2020537, 'Hamburger', 5.50, 4754), 
(2020451, 'Tosti', 2.50, 4232), 
(2020531, 'Patat', 3.00, 10113), 
(2020936, 'Salade', 4.00, 2100), 
(2020533, 'Pizza', 10.00, 8000), 
(2020584, 'Wijn', 3.00, 3329), 
(2020145, 'Bier', 2.50, 25114), 
(2020960, 'Energy', 3.50, 2000), 
(2020555, 'Frikandel', 2, 4013), 
(2020549, 'Frisdrank', 2.50, 9915), 
(2020324, 'Wrap', 5.50, 2411), 
(2020009, 'Turkse pizza', 6.00, 3454), 
(2020563, 'Vega burger', 4.00, 1100), 
(2020299, 'Pasta', 5.00, 4403),
(2024229, 'Saus', 0.50 , 19624),
(2022284, 'Smirnoff ice', 3.50 , 3334);

/* verkoop_producten_festival insert*/
/*2021*/
INSERT INTO verkoop_producten_festival VALUES(1,2020412);
INSERT INTO verkoop_producten_festival VALUES(2,2020537);
INSERT INTO verkoop_producten_festival VALUES(3,2020451);
INSERT INTO verkoop_producten_festival VALUES(4,2020531);
INSERT INTO verkoop_producten_festival VALUES(5,2020936);
INSERT INTO verkoop_producten_festival VALUES(6,2020533);
INSERT INTO verkoop_producten_festival VALUES(7,2020584);
INSERT INTO verkoop_producten_festival VALUES(8,2020145);
INSERT INTO verkoop_producten_festival VALUES(9,2020960);
INSERT INTO verkoop_producten_festival VALUES(10,2020555);
INSERT INTO verkoop_producten_festival VALUES(11,2020549);
INSERT INTO verkoop_producten_festival VALUES(12,2020324);
INSERT INTO verkoop_producten_festival VALUES(13,2020009);
INSERT INTO verkoop_producten_festival VALUES(14,2020563);
INSERT INTO verkoop_producten_festival VALUES(15,2020299);

/*2019*/
INSERT INTO verkoop_producten_festival VALUES(16,2024229);
INSERT INTO verkoop_producten_festival VALUES(17,2022284);
INSERT INTO verkoop_producten_festival VALUES(18,2024229);
INSERT INTO verkoop_producten_festival VALUES(19,2020299);
INSERT INTO verkoop_producten_festival VALUES(20,2020563);
INSERT INTO verkoop_producten_festival VALUES(21,2020009);
INSERT INTO verkoop_producten_festival VALUES(22,2020324);
INSERT INTO verkoop_producten_festival VALUES(23,2020549);
INSERT INTO verkoop_producten_festival VALUES(24,2020555);
INSERT INTO verkoop_producten_festival VALUES(25,2020960);
INSERT INTO verkoop_producten_festival VALUES(26,2020145);
INSERT INTO verkoop_producten_festival VALUES(27,2020584);
INSERT INTO verkoop_producten_festival VALUES(28,2020936);
INSERT INTO verkoop_producten_festival VALUES(29,2020531);
INSERT INTO verkoop_producten_festival VALUES(30,2020451);

/*2018*/
INSERT INTO verkoop_producten_festival VALUES(31,2020537);
INSERT INTO verkoop_producten_festival VALUES(32,2020412);
INSERT INTO verkoop_producten_festival VALUES(33,2020537);
INSERT INTO verkoop_producten_festival VALUES(34,2020451);
INSERT INTO verkoop_producten_festival VALUES(35,2020531);
INSERT INTO verkoop_producten_festival VALUES(36,2020936);
INSERT INTO verkoop_producten_festival VALUES(37,2020533);
INSERT INTO verkoop_producten_festival VALUES(38,2020584);
INSERT INTO verkoop_producten_festival VALUES(39,2020145);
INSERT INTO verkoop_producten_festival VALUES(40,2020960);
INSERT INTO verkoop_producten_festival VALUES(41,2020555);
INSERT INTO verkoop_producten_festival VALUES(42,2020549);
INSERT INTO verkoop_producten_festival VALUES(43,2020324);
INSERT INTO verkoop_producten_festival VALUES(44,2020009);
INSERT INTO verkoop_producten_festival VALUES(45,2020563);



/* aanmeldingen insert*/
INSERT INTO aanmeldingen VALUES(1,2);
INSERT INTO aanmeldingen VALUES(2,3);
INSERT INTO aanmeldingen VALUES(3,4);
INSERT INTO aanmeldingen VALUES(4,5);
INSERT INTO aanmeldingen VALUES(5,6);
INSERT INTO aanmeldingen VALUES(6,7);
INSERT INTO aanmeldingen VALUES(7,8);
INSERT INTO aanmeldingen VALUES(8,9);
INSERT INTO aanmeldingen VALUES(9,10);
INSERT INTO aanmeldingen VALUES(10,11);
INSERT INTO aanmeldingen VALUES(11,12);
INSERT INTO aanmeldingen VALUES(12,13);
INSERT INTO aanmeldingen VALUES(13,14);
INSERT INTO aanmeldingen VALUES(14,15);
INSERT INTO aanmeldingen VALUES(15,1);
INSERT INTO aanmeldingen VALUES(16,1);
INSERT INTO aanmeldingen VALUES(17,2);
INSERT INTO aanmeldingen VALUES(18,3);
INSERT INTO aanmeldingen VALUES(19,4);
INSERT INTO aanmeldingen VALUES(20,5);
INSERT INTO aanmeldingen VALUES(21,6);
INSERT INTO aanmeldingen VALUES(22,7);
INSERT INTO aanmeldingen VALUES(23,8);
INSERT INTO aanmeldingen VALUES(24,9);
INSERT INTO aanmeldingen VALUES(25,10);
INSERT INTO aanmeldingen VALUES(26,11);
INSERT INTO aanmeldingen VALUES(27,12);
INSERT INTO aanmeldingen VALUES(28,13);
INSERT INTO aanmeldingen VALUES(29,14);
INSERT INTO aanmeldingen VALUES(30,15);
INSERT INTO aanmeldingen VALUES(1,16);
INSERT INTO aanmeldingen VALUES(2,17);
INSERT INTO aanmeldingen VALUES(3,18);
INSERT INTO aanmeldingen VALUES(4,19);
INSERT INTO aanmeldingen VALUES(5,20);
INSERT INTO aanmeldingen VALUES(6,21);
INSERT INTO aanmeldingen VALUES(7,22);
INSERT INTO aanmeldingen VALUES(8,23);
INSERT INTO aanmeldingen VALUES(9,24);
INSERT INTO aanmeldingen VALUES(10,25);
INSERT INTO aanmeldingen VALUES(11,26);
INSERT INTO aanmeldingen VALUES(12,27);
INSERT INTO aanmeldingen VALUES(13,28);
INSERT INTO aanmeldingen VALUES(14,29);
INSERT INTO aanmeldingen VALUES(15,30);
INSERT INTO aanmeldingen VALUES(16,31);
INSERT INTO aanmeldingen VALUES(17,32);
INSERT INTO aanmeldingen VALUES(18,33);
INSERT INTO aanmeldingen VALUES(19,34);
INSERT INTO aanmeldingen VALUES(20,35);
INSERT INTO aanmeldingen VALUES(21,36);
INSERT INTO aanmeldingen VALUES(22,37);
INSERT INTO aanmeldingen VALUES(23,38);
INSERT INTO aanmeldingen VALUES(24,39);
INSERT INTO aanmeldingen VALUES(25,40);
INSERT INTO aanmeldingen VALUES(26,41);
INSERT INTO aanmeldingen VALUES(27,42);
INSERT INTO aanmeldingen VALUES(28,43);
INSERT INTO aanmeldingen VALUES(29,44);
INSERT INTO aanmeldingen VALUES(30,45);
INSERT INTO aanmeldingen VALUES(1,20);
INSERT INTO aanmeldingen VALUES(2,21);
INSERT INTO aanmeldingen VALUES(3,22);
INSERT INTO aanmeldingen VALUES(4,23);
INSERT INTO aanmeldingen VALUES(5,24);
INSERT INTO aanmeldingen VALUES(6,25);
INSERT INTO aanmeldingen VALUES(7,26);
INSERT INTO aanmeldingen VALUES(8,27);
INSERT INTO aanmeldingen VALUES(9,28);
INSERT INTO aanmeldingen VALUES(10,29);
INSERT INTO aanmeldingen VALUES(11,30);
INSERT INTO aanmeldingen VALUES(12,31);
INSERT INTO aanmeldingen VALUES(13,32);
INSERT INTO aanmeldingen VALUES(14,33);
INSERT INTO aanmeldingen VALUES(15,34);
INSERT INTO aanmeldingen VALUES(16,35);
INSERT INTO aanmeldingen VALUES(17,36);
INSERT INTO aanmeldingen VALUES(18,37);
INSERT INTO aanmeldingen VALUES(19,38);
INSERT INTO aanmeldingen VALUES(20,39);
INSERT INTO aanmeldingen VALUES(21,40);
INSERT INTO aanmeldingen VALUES(22,41);
INSERT INTO aanmeldingen VALUES(23,42);
INSERT INTO aanmeldingen VALUES(24,43);
INSERT INTO aanmeldingen VALUES(25,44);
INSERT INTO aanmeldingen VALUES(26,45);
INSERT INTO aanmeldingen VALUES(27,16);
INSERT INTO aanmeldingen VALUES(28,17);
INSERT INTO aanmeldingen VALUES(29,18);
INSERT INTO aanmeldingen VALUES(30,19);


/*inkoop insert*/
INSERT INTO inkoop values (1, 'Polsbandjes', 0.068, 22000, 'eventtrading');
INSERT INTO inkoop values (2, 'Breekmuntjes', 0.0175, 400000, 'b-token');
INSERT INTO inkoop values (3, 'Water flesjes', 0.29, 20000, 'watercoolergigant');
INSERT INTO inkoop values (4, 'Tosti', 0.975, 500, 'makro');
INSERT INTO inkoop values (5, 'Bier bekers', 0.053, 300000, 'goedkoopdrank');
INSERT INTO inkoop values (6, 'Patat', 0.9788, 12500, 'makro');
INSERT INTO inkoop values (7, 'Frikandellen', 0.211775, 4000, 'makro');
INSERT INTO inkoop values (8, 'Pizza', 1.088, 15000, 'makro');
INSERT INTO inkoop values (9, 'Hamburgers', 0.29, 12000, 'hanos');
INSERT INTO inkoop values (10, 'Vegaburgers', 2.35, 500, 'plus');
INSERT INTO inkoop values (11, 'Frisdrank', 7.99, 1000, 'makro');
INSERT INTO inkoop values (12, 'Wijn', 4.99, 1000, 'wijnvoordeel');
INSERT INTO inkoop values (13, 'Energy drank', 27.57, 400, 'makro');
INSERT INTO inkoop values (14, 'Captain Morgain blik', 22.62, 600, 'horecabier');
INSERT INTO inkoop values (15, 'Smirnoff ice', 35.33, 300, 'goedkoopdrank');
INSERT INTO inkoop values (16, 'Bier', 141.71, 300000, 'goedkoopdrank');
INSERT INTO inkoop values (17, 'Wraps', 3.98, 4000, 'makro');
INSERT INTO inkoop values (18, 'Shoarma', 6.67, 2000, 'makro');
INSERT INTO inkoop values (19, 'Knoflooksaus', 10.50, 8000, 'makro');
INSERT INTO inkoop values (20, 'Mayonaise', 10.50, 8000, 'sligro');
INSERT INTO inkoop values (21, 'Ketchup', 8.50, 8000, 'sligro');
INSERT INTO inkoop values (22, 'Curry', 8.50, 8000, 'sligro');
INSERT INTO inkoop values (23, 'Broodjes', 0.25, 130000, 'makro');
INSERT INTO inkoop values (24, 'Servetjes', 3.21, 20000, 'treb');
INSERT INTO inkoop values (25, 'Turkse pizza', 0.90, 8000, 'sligro');
INSERT INTO inkoop values (26, 'Sla', 0.90, 2500, 'sligro');
INSERT INTO inkoop values (27, 'Pasta Penne', 0.90, 4000, 'sligro');
INSERT INTO inkoop values (28, 'Bolognese saus', 2.40, 1500, 'hanos');
INSERT INTO inkoop values (29, 'Wegwerp vorkjes', 0.80, 1200, 'hanos');
INSERT INTO inkoop values (30, 'Wegwerp messen', 0.80, 1200, 'hanos');

/*inkoop_festival insert*/
INSERT INTO inkoop_festival VALUES(1,14);
INSERT INTO inkoop_festival VALUES(2,13);
INSERT INTO inkoop_festival VALUES(3,10);
INSERT INTO inkoop_festival VALUES(4,8);
INSERT INTO inkoop_festival VALUES(5,15);
INSERT INTO inkoop_festival VALUES(6,12);
INSERT INTO inkoop_festival VALUES(7,9);
INSERT INTO inkoop_festival VALUES(8,7);
INSERT INTO inkoop_festival VALUES(9,6);
INSERT INTO inkoop_festival VALUES(10,5);
INSERT INTO inkoop_festival VALUES(11,2);
INSERT INTO inkoop_festival VALUES(12,1);
INSERT INTO inkoop_festival VALUES(13,11);
INSERT INTO inkoop_festival VALUES(14,3);
INSERT INTO inkoop_festival VALUES(15,4);
INSERT INTO inkoop_festival VALUES(16,1);
INSERT INTO inkoop_festival VALUES(17,2);
INSERT INTO inkoop_festival VALUES(18,3);
INSERT INTO inkoop_festival VALUES(19,4);
INSERT INTO inkoop_festival VALUES(20,5);
INSERT INTO inkoop_festival VALUES(21,6);
INSERT INTO inkoop_festival VALUES(22,7);
INSERT INTO inkoop_festival VALUES(23,8);
INSERT INTO inkoop_festival VALUES(24,9);
INSERT INTO inkoop_festival VALUES(25,10);
INSERT INTO inkoop_festival VALUES(26,11);
INSERT INTO inkoop_festival VALUES(27,12);
INSERT INTO inkoop_festival VALUES(28,13);
INSERT INTO inkoop_festival VALUES(29,14);
INSERT INTO inkoop_festival VALUES(30,15);
INSERT INTO inkoop_festival VALUES(31,16);
INSERT INTO inkoop_festival VALUES(32,17);
INSERT INTO inkoop_festival VALUES(33,18);
INSERT INTO inkoop_festival VALUES(34,19);
INSERT INTO inkoop_festival VALUES(35,20);
INSERT INTO inkoop_festival VALUES(36,21);
INSERT INTO inkoop_festival VALUES(37,22);
INSERT INTO inkoop_festival VALUES(38,23);
INSERT INTO inkoop_festival VALUES(39,24);
INSERT INTO inkoop_festival VALUES(40,25);
INSERT INTO inkoop_festival VALUES(41,26);
INSERT INTO inkoop_festival VALUES(42,27);
INSERT INTO inkoop_festival VALUES(43,28);
INSERT INTO inkoop_festival VALUES(44,29);
INSERT INTO inkoop_festival VALUES(45,30);


/*locatie insert*/
INSERT INTO locatie values (1, 'Haarlemmermeer', 'Paviljoenlaan 1', 'Hoofddorp', 5, 25000);
INSERT INTO locatie values (2, 'Berendonck', 'Weg door de Berendonck ', 'Wijchen', 17, 10000);
INSERT INTO locatie values (3, 'Sportpark dn Donk', 'Sportlaan 10', 'Oisterwijk', 1, 15000);
INSERT INTO locatie values (4, 'De Heikampen', 'De Heikampen 5', 'Schijndel', 10, 50000);
INSERT INTO locatie values (5, 'Biddinghuizen', 'Spijkweg 20', 'Biddinghuizen', 10, 20000);
INSERT INTO locatie values (6, 'Middelwaard', 'Westelijke Parallelweg 1', 'Vianen', 6, 2000);
INSERT INTO locatie values (7, 'Hellendoorn', 'Luttenbergerweg 31', 'Haarle', 3, 5000);
INSERT INTO locatie values (8, 'Stadskanaal', 'Hoveniersweg 1', 'Groningen', 11, 7000);
INSERT INTO locatie values (9, 'De Achtertuin', 'Winselingseweg 41', 'Nijmegen', 6, 5000);
INSERT INTO locatie values (10, 'Grasweide Strijkviertel', 'Strijkviertel', 'Utrecht', 5, 5000);
INSERT INTO locatie values (11, 'De Weerd', 'De Weerd 1', 'Roermond', 15, 3000);
INSERT INTO locatie values (12, 'Zeezout', 'Doctor Jan van Breemenstraat 1', 'Amsterdam', 1, 2500);
INSERT INTO locatie values (13, 'MOB-complex', 'IJpelareweg 55', 'Tilburg', 6, 1500);
INSERT INTO locatie values (14, 'Beekse Bergen', 'Beekse Bergen 5081', 'Hilvarenbeek', 12, 8000);
INSERT INTO locatie values (15, 'Pinkpop-Plein', 'Pinkpop-Plein', 'Landgraaf', 2, 2000);

/*locatie_festival*/
INSERT INTO locatie_festival VALUES (1, 1, '2021-08-27');
INSERT INTO locatie_festival VALUES (2, 2, '2021-05-29');
INSERT INTO locatie_festival VALUES (3, 3, '2021-06-04');
INSERT INTO locatie_festival VALUES (4, 4, '2021-04-02');
INSERT INTO locatie_festival VALUES (5, 5, '2021-06-25');
INSERT INTO locatie_festival VALUES (6, 6, '2021-05-08');
INSERT INTO locatie_festival VALUES (7, 7, '2021-05-29');
INSERT INTO locatie_festival VALUES (8, 8, '2021-05-29');
INSERT INTO locatie_festival VALUES (9, 9, '2021-06-10');
INSERT INTO locatie_festival VALUES (10, 10, '2021-06-12');
INSERT INTO locatie_festival VALUES (11, 11, '2021-07-29');
INSERT INTO locatie_festival VALUES (12, 12, '2021-08-27');
INSERT INTO locatie_festival VALUES (13, 13, '2021-05-12');
INSERT INTO locatie_festival VALUES (14, 14, '2021-07-09');
INSERT INTO locatie_festival VALUES (15, 15, '2021-06-18');
INSERT INTO locatie_festival VALUES (1, 16, '2019-08-23');
INSERT INTO locatie_festival VALUES (2, 17, '2019-05-25');
INSERT INTO locatie_festival VALUES (3, 18, '2019-05-31');
INSERT INTO locatie_festival VALUES (4, 19, '2019-04-19');
INSERT INTO locatie_festival VALUES (5, 20, '2019-06-28');
INSERT INTO locatie_festival VALUES (6, 21, '2019-05-18');
INSERT INTO locatie_festival VALUES (7, 22, '2019-05-30');
INSERT INTO locatie_festival VALUES (8, 23, '2019-05-25');
INSERT INTO locatie_festival VALUES (9, 24, '2019-06-08');
INSERT INTO locatie_festival VALUES (10, 25, '2019-06-22');
INSERT INTO locatie_festival VALUES (11, 26, '2019-08-01');
INSERT INTO locatie_festival VALUES (12, 27, '2019-09-07');
INSERT INTO locatie_festival VALUES (13, 28, '2019-09-14');
INSERT INTO locatie_festival VALUES (14, 29, '2019-07-12');
INSERT INTO locatie_festival VALUES (15, 30, '2019-06-08');
INSERT INTO locatie_festival VALUES (1, 31, '2018-08-25');
INSERT INTO locatie_festival VALUES (2, 32, '2018-05-26');
INSERT INTO locatie_festival VALUES (3, 33, '2018-06-01');
INSERT INTO locatie_festival VALUES (4, 34, '2018-03-30');
INSERT INTO locatie_festival VALUES (5, 35, '2018-06-22');
INSERT INTO locatie_festival VALUES (6, 36, '2018-05-18');
INSERT INTO locatie_festival VALUES (7, 37, '2018-05-26');
INSERT INTO locatie_festival VALUES (8, 38, '2018-05-25');
INSERT INTO locatie_festival VALUES (9, 39, '2018-06-09');
INSERT INTO locatie_festival VALUES (10, 40, '2018-07-28');
INSERT INTO locatie_festival VALUES (11, 41, '2018-08-02');
INSERT INTO locatie_festival VALUES (12, 42, '2018-09-07');
INSERT INTO locatie_festival VALUES (13, 43, '2018-09-09');
INSERT INTO locatie_festival VALUES (14, 44, '2018-07-13');
INSERT INTO locatie_festival VALUES (15, 45, '2018-06-15');
/*campagne insert*/
INSERT INTO campagne (campagne_id, campagne_categorie, naam, beschrijving, startdatum, einddatum, kosten) 
VALUES 
(2020101, 'Advertentie', 'Advertentie Facebook', 'Advertentie op Facebook met video en bijbehorend bericht', '2020-04-10', '2020-06-28', 3000), 
(2020102, 'Poster', 'A1 posters', 'A1 poster met festival line-up om in steden op te hangen', '2020-04-01', '2020-06-30', 1000), 
(2020103, 'Advertentie', 'Google Adword', 'Een advertentie in Google om beter gevonden te worden op Google', '2020-01-01', '2020-06-28', 500), 
(2020104, 'Video', 'Video marketing', 'Een video om op online platformen te plaatsen', '', '', 3000), 
(2020105, 'Flyers', 'Flyers', 'Flyers om uit te delen in steden', '', '', 500), 
(2020106, 'Advertentie', 'Billboard advertentie', 'Een advertentie om naast de wegen te hangen', '2020-05-28', '2020-06-28', 5000), 
(2020107, 'Advertentie', 'Instagram advertentie', 'Instagram advertenties om informatie te verstrekken', '2020-04-10', '2020-06-28', 2000);

/* Campagne_festival insert*/
INSERT INTO campagne_festival VALUES(1,2020102);
INSERT INTO campagne_festival VALUES(2,2020101);
INSERT INTO campagne_festival VALUES(3,2020104);
INSERT INTO campagne_festival VALUES(4,2020102);
INSERT INTO campagne_festival VALUES(5,2020107);
INSERT INTO campagne_festival VALUES(6,2020103);
INSERT INTO campagne_festival VALUES(7,2020101);
INSERT INTO campagne_festival VALUES(8,2020104);
INSERT INTO campagne_festival VALUES(9,2020102);
INSERT INTO campagne_festival VALUES(10,2020103);
INSERT INTO campagne_festival VALUES(11,2020107);
INSERT INTO campagne_festival VALUES(12,2020106);
INSERT INTO campagne_festival VALUES(13,2020105);
INSERT INTO campagne_festival VALUES(14,2020102);
INSERT INTO campagne_festival VALUES(15,2020105);
INSERT INTO campagne_festival VALUES(16,2020102);
INSERT INTO campagne_festival VALUES(17,2020101);
INSERT INTO campagne_festival VALUES(18,2020104);
INSERT INTO campagne_festival VALUES(19,2020102);
INSERT INTO campagne_festival VALUES(20,2020107);
INSERT INTO campagne_festival VALUES(21,2020103);
INSERT INTO campagne_festival VALUES(22,2020101);
INSERT INTO campagne_festival VALUES(23,2020104);
INSERT INTO campagne_festival VALUES(24,2020102);
INSERT INTO campagne_festival VALUES(25,2020103);
INSERT INTO campagne_festival VALUES(26,2020107);
INSERT INTO campagne_festival VALUES(27,2020106);
INSERT INTO campagne_festival VALUES(28,2020105);
INSERT INTO campagne_festival VALUES(29,2020102);
INSERT INTO campagne_festival VALUES(30,2020105);
INSERT INTO campagne_festival VALUES(31,2020102);
INSERT INTO campagne_festival VALUES(32,2020101);
INSERT INTO campagne_festival VALUES(33,2020104);
INSERT INTO campagne_festival VALUES(34,2020102);
INSERT INTO campagne_festival VALUES(35,2020107);
INSERT INTO campagne_festival VALUES(36,2020103);
INSERT INTO campagne_festival VALUES(37,2020101);
INSERT INTO campagne_festival VALUES(38,2020104);
INSERT INTO campagne_festival VALUES(39,2020102);
INSERT INTO campagne_festival VALUES(40,2020103);
INSERT INTO campagne_festival VALUES(41,2020107);
INSERT INTO campagne_festival VALUES(42,2020106);
INSERT INTO campagne_festival VALUES(43,2020105);
INSERT INTO campagne_festival VALUES(44,2020102);
INSERT INTO campagne_festival VALUES(45,2020105);

/*werknemers insert*/
insert into werknemers values(1, 'Hans', 'van Halteren', '1964-04-21', 'Directeur', 'Eindhoven', 'hansvanhalteren@gmail.com', 0658065127, 'Man');
insert into werknemers values(2, 'Klaas', 'de Vries', '1994-03-23', 'IT', 'Eindhoven', 'klaasvries@gmail.com', 0642529165, 'Man');
insert into werknemers values(3, 'Iris', 'Meijer', '1983-01-11', 'Inkoop', 'Helmond', 'irisMeijer@upcmail.nl', 0651751037, 'Vrouw');
insert into werknemers values(4, 'Marjon', 'van der Malen', '1974-08-06', 'HR-manager', 'Oss', 'marjondegroot@live.nl', 0690568877, 'Vrouw');
insert into werknemers values(5, 'Frank', 'Sandifort', '1992-07-17', 'Logistiek', 'Best', 'frankSandi@gmail.com', 0645874574, 'Man');
insert into werknemers values(6, 'Toy', 'Pels', '1977-12-21', 'Verkoop', 'Oss', 'toypels@gmail.com', 0641359249, 'Man');
insert into werknemers values(7, 'Robert', 'de Jong', '1979-03-19', 'Locatie', 'Eindhoven', 'dejongR@live.nl', 0615564196, 'Man');
insert into werknemers values(8, 'Lotte', 'Bosch', '1991-09-02', 'MarketingSales', 'Nuenen', 'lottebosch@gmail.com', 0690142299, 'Vrouw');
insert into werknemers values(9, 'Emmelie', 'Noordermeer', '1984-03-22', 'Logistiek', 'Boxtel', 'noordermeerem@live.nl', 0678264928, 'Vrouw');
insert into werknemers values(10, 'Ties', 'Boer', '1986-12-03', 'Verkoop', 'Boxtel', 'tiesboer@gmail.com', 0649218302, 'Man');
insert into werknemers values(11, 'Leroy', 'Geelen', '1993-07-31', 'IT', 'Liempde', 'leroygeelen@gmail.com', 0692102956, 'Man');
insert into werknemers values(12, 'Chantal', 'Besel', '1990-11-07', 'Productie', 'Eindhoven', 'chantbesel@live.nl', 0653968121, 'Vrouw');
insert into werknemers values(13, 'Bastiaan', 'Roes', '1987-10-02', 'Productie', 'Eindhoven', 'sebastiaanroes@gmail.com', 0620481925, 'Man');
insert into werknemers values(14, 'Mike', 'Willems', '1966-08-04', 'FinancieelAdviseur', 'Best', 'willemsmike@live.nl', 0687190285, 'Man');
insert into werknemers values(15, 'Roos', 'Bloks', '1974-10-12', 'Accountant', 'Oss', 'roosbloks@hotmail.com', 0610258201, 'Vrouw');
insert into werknemers values(16, 'David', 'de Wit', '1991-06-25', 'Verkoop', 'Tilburg', 'daviddewit@gmail.com', 0649218354, 'Man');

/*werkzaamheden insert*/
INSERT INTO werkzaamheden VALUES (101, 'Controle', 'Laatste controle op festival of alles goed is', '2021-08-25 09:00:00', '2021-08-31 17:00:00'); 
INSERT INTO werkzaamheden VALUES (102, 'Verlichting', 'De verlichtingen van bij de podia aansluiten', '2021-08-20 09:00:00', '2021-08-31 17:00:00'); 
INSERT INTO werkzaamheden VALUES (103, 'Drinken inkopen', 'Frisdrank an alcoholische dranken inkopen voor de verkoop', '2021-08-15 09:00:00', '2021-08-20 17:00:00'); 
INSERT INTO werkzaamheden VALUES (104, 'Planning personeel', 'Een planning maken voor de werkzaamheden van het festival', '2021-08-15 09:00:00', '2021-08-17 17:00:00'); 
INSERT INTO werkzaamheden VALUES (105, 'Wcs schoonmaken', 'Verantwoordelijk voor het schoonmaken van de wcs tijdens het festival', '2021-08-27 10:00:00', '2021-08-31 17:00:00'); 
INSERT INTO werkzaamheden VALUES (106, 'Beveiligen', 'Locatie controleren op beveiling', '2021-08-25 08:00:00', '2021-08-31 17:00:00'); 
INSERT INTO werkzaamheden VALUES (107, 'Ticketverkoop', 'Tickets verkopen via online kanalen', '2021-02-10 11:00:00', '2021-08-29 13:00:00'); 
INSERT INTO werkzaamheden VALUES (108, 'Geluid testen', 'Geluid testen op aantal decibellen', '2021-08-25 09:00:00', '2021-08-30 17:00:00'); 
INSERT INTO werkzaamheden VALUES (109, 'Kassa controle', 'Kassa gereed maken voor opening', '2021-08-25 09:00:00', '2021-08-30 17:00:00'); 
INSERT INTO werkzaamheden VALUES (110, 'Campagne', 'Posters in de buurt ophangen als campagne voor het festival', '2021-07-05 09:00:00', '2021-08-31 17:00:00');
INSERT INTO werkzaamheden VALUES (111, 'Podium opbouwen', 'Opbouwen van de podia op het festivalterrein', '2021-08-20 09:00:00', '2021-08-31 17:00:00');
INSERT INTO werkzaamheden VALUES (112, 'Toiletten', 'Opbouwen van de toiletares en plaatsen toiletten', '2021-08-20 09:00:00', '2021-08-31 17:00:00');
INSERT INTO werkzaamheden VALUES (113, 'Boekhouden', 'Finaciele controle uitvoeren', '2021-08-03 09:00:00', '2021-08-05 17:00:00'); 
INSERT INTO werkzaamheden VALUES (114, 'Stroomvoorziening', 'Het aansluiten en voorbereiden van de stroomvoorzieningen', '2021-08-20 09:00:00', '2021-08-31 17:00:00'); 
INSERT INTO werkzaamheden VALUES (115, 'Ticketcontrole', 'Controleren van de tickets bij de ingang', '2021-08-27 10:00:00', '2021-08-30 21:00:00');
INSERT INTO werkzaamheden VALUES (116, 'Beeldschermen testen', 'Beeldschermen testen voor videos', '2021-08-25 09:00:00', '2021-08-30 17:00:00'); 
INSERT INTO werkzaamheden VALUES (117, 'Controle uitgaven', 'Finaciele controle uitvoeren', '2021-08-03 09:00:00', '2021-08-05 17:00:00'); 
INSERT INTO werkzaamheden VALUES (118, 'Controle', 'Laatste controle op festival of alles goed is', '2019-08-23 09:00:00', '2019-08-26 17:00:00'); 
INSERT INTO werkzaamheden VALUES (119, 'Verlichting', 'De verlichtingen van bij de podia aansluiten', '2019-05-25 09:00:00', '2019-05-27 17:00:00'); 
INSERT INTO werkzaamheden VALUES (120, 'Drinken inkopen', 'Frisdrank an alcoholische dranken inkopen voor de verkoop', '2019-05-24 09:00:00', '2019-05-31 17:00:00'); 
INSERT INTO werkzaamheden VALUES (130, 'Planning personeel', 'Een planning maken voor de werkzaamheden van het festival', '2019-04-10 09:00:00', '2019-04-19 17:00:00'); 
INSERT INTO werkzaamheden VALUES (131, 'Wcs schoonmaken', 'Verantwoordelijk voor het schoonmaken van de wcs tijdens het festival', '2019-06-28 10:00:00', '2019-06-30 17:00:00'); 
INSERT INTO werkzaamheden VALUES (132, 'Beveiligen', 'Locatie controleren op beveiling', '2019-05-17 08:00:00', '2019-05-19 17:00:00'); 
INSERT INTO werkzaamheden VALUES (133, 'Ticketverkoop', 'Tickets verkopen via online kanalen', '2019-02-10 11:00:00', '2019-05-30 13:00:00'); 
INSERT INTO werkzaamheden VALUES (134, 'Geluid testen', 'Geluid testen op aantal decibellen', '2019-06-06 09:00:00', '2019-06-10 17:00:00'); 
INSERT INTO werkzaamheden VALUES (135, 'Kassa controle', 'Kassa gereed maken voor opening', '2019-05-25 09:00:00', '2019-05-27 17:00:00'); 
INSERT INTO werkzaamheden VALUES (136, 'Campagne', 'Posters in de buurt ophangen als campagne voor het festival', '2019-06-10 09:00:00', '2019-06-23 17:00:00');
INSERT INTO werkzaamheden VALUES (137, 'Podium opbouwen', 'Opbouwen van de podia op het festivalterrein', '2019-07-29 09:00:00', '2019-08-02 17:00:00');
INSERT INTO werkzaamheden VALUES (138, 'Toiletten', 'Opbouwen van de toiletares en plaatsen toiletten', '2019-09-05 09:00:00', '2019-09-09 17:00:00');
INSERT INTO werkzaamheden VALUES (139, 'Boekhouden', 'Finaciele controle uitvoeren', '2019-09-05 09:00:00', '2019-09-17 17:00:00'); 
INSERT INTO werkzaamheden VALUES (140, 'Stroomvoorziening', 'Het aansluiten en voorbereiden van de stroomvoorzieningen', '2019-07-09 09:00:00', '2019-07-15 17:00:00'); 
INSERT INTO werkzaamheden VALUES (141, 'Ticketcontrole', 'Controleren van de tickets bij de ingang', '2019-06-08 10:00:00', '2019-06-11 21:00:00');
INSERT INTO werkzaamheden VALUES (150, 'Controle', 'Laatste controle op festival of alles goed is', '2018-06-15 09:00:00', '2018-06-18 17:00:00'); 
INSERT INTO werkzaamheden VALUES (151, 'Verlichting', 'De verlichtingen van bij de podia aansluiten', '2018-07-12 09:00:00', '2018-07-16 17:00:00'); 
INSERT INTO werkzaamheden VALUES (152, 'Drinken inkopen', 'Frisdrank an alcoholische dranken inkopen voor de verkoop', '2018-08-27 09:00:00', '2018-09-07 17:00:00'); 
INSERT INTO werkzaamheden VALUES (153, 'Planning personeel', 'Een planning maken voor de werkzaamheden van het festival', '2018-08-10 09:00:00', '2018-09-07 17:00:00'); 
INSERT INTO werkzaamheden VALUES (154, 'Wcs schoonmaken', 'Verantwoordelijk voor het schoonmaken van de wcs tijdens het festival', '2018-08-02 10:00:00', '2018-08-05 17:00:00'); 
INSERT INTO werkzaamheden VALUES (155, 'Beveiligen', 'Locatie controleren op beveiling', '2018-07-26 08:00:00', '2018-07-29 17:00:00'); 
INSERT INTO werkzaamheden VALUES (156, 'Ticketverkoop', 'Tickets verkopen via online kanalen', '2018-02-10 11:00:00', '2018-06-09 13:00:00'); 
INSERT INTO werkzaamheden VALUES (157, 'Geluid testen', 'Geluid testen op aantal decibellen', '2018-05-24 09:00:00', '2018-05-27 17:00:00'); 
INSERT INTO werkzaamheden VALUES (158, 'Kassa controle', 'Kassa gereed maken voor opening', '2018-05-18 09:00:00', '2018-05-19 17:00:00'); 
INSERT INTO werkzaamheden VALUES (159, 'Campagne', 'Posters in de buurt ophangen als campagne voor het festival', '2018-06-10 09:00:00', '2018-06-24 17:00:00');
INSERT INTO werkzaamheden VALUES (160, 'Podium opbouwen', 'Opbouwen van de podia op het festivalterrein', '2018-07-29 09:00:00', '2018-08-02 17:00:00');
INSERT INTO werkzaamheden VALUES (161, 'Toiletten', 'Opbouwen van de toiletares en plaatsen toiletten', '2018-03-28 09:00:00', '2018-04-02 17:00:00');
INSERT INTO werkzaamheden VALUES (162, 'Boekhouden', 'Finaciele controle uitvoeren', '2018-05-25 09:00:00', '2018-06-04 17:00:00'); 
INSERT INTO werkzaamheden VALUES (163, 'Stroomvoorziening', 'Het aansluiten en voorbereiden van de stroomvoorzieningen', '2018-05-22 09:00:00', '2018-05-28 17:00:00'); 
INSERT INTO werkzaamheden VALUES (164, 'Ticketcontrole', 'Controleren van de tickets bij de ingang', '2018-08-25 10:00:00', '2018-08-26 21:00:00');



/*Werknemers_werkzaamheden insert */
INSERT INTO werknemers_werkzaamheden VALUES(101,1);
INSERT INTO werknemers_werkzaamheden VALUES(116,2);
INSERT INTO werknemers_werkzaamheden VALUES(103,3);
INSERT INTO werknemers_werkzaamheden VALUES(104,4);
INSERT INTO werknemers_werkzaamheden VALUES(102,5);
INSERT INTO werknemers_werkzaamheden VALUES(107,6);
INSERT INTO werknemers_werkzaamheden VALUES(106,7);
INSERT INTO werknemers_werkzaamheden VALUES(110,8);
INSERT INTO werknemers_werkzaamheden VALUES(112,9);
INSERT INTO werknemers_werkzaamheden VALUES(115,10);
INSERT INTO werknemers_werkzaamheden VALUES(114,11);
INSERT INTO werknemers_werkzaamheden VALUES(108,12);
INSERT INTO werknemers_werkzaamheden VALUES(109,13);
INSERT INTO werknemers_werkzaamheden VALUES(117,14);
INSERT INTO werknemers_werkzaamheden VALUES(113,15);

INSERT INTO werknemers_werkzaamheden VALUES(118,1);
INSERT INTO werknemers_werkzaamheden VALUES(140,2);
INSERT INTO werknemers_werkzaamheden VALUES(120,3);
INSERT INTO werknemers_werkzaamheden VALUES(130,4);
INSERT INTO werknemers_werkzaamheden VALUES(138,5);
INSERT INTO werknemers_werkzaamheden VALUES(139,6);
INSERT INTO werknemers_werkzaamheden VALUES(133,7);
INSERT INTO werknemers_werkzaamheden VALUES(136,8);
INSERT INTO werknemers_werkzaamheden VALUES(161,9);
INSERT INTO werknemers_werkzaamheden VALUES(141,10);
INSERT INTO werknemers_werkzaamheden VALUES(163,11);
INSERT INTO werknemers_werkzaamheden VALUES(134,12);
INSERT INTO werknemers_werkzaamheden VALUES(135,13);
INSERT INTO werknemers_werkzaamheden VALUES(162,14);
INSERT INTO werknemers_werkzaamheden VALUES(133,15);

INSERT INTO werknemers_werkzaamheden VALUES(150,1);
INSERT INTO werknemers_werkzaamheden VALUES(116,2);
INSERT INTO werknemers_werkzaamheden VALUES(152,3);
INSERT INTO werknemers_werkzaamheden VALUES(153,4);
INSERT INTO werknemers_werkzaamheden VALUES(151,5);
INSERT INTO werknemers_werkzaamheden VALUES(133,6);
INSERT INTO werknemers_werkzaamheden VALUES(156,7);
INSERT INTO werknemers_werkzaamheden VALUES(159,8);
INSERT INTO werknemers_werkzaamheden VALUES(151,9);
INSERT INTO werknemers_werkzaamheden VALUES(162,10);
INSERT INTO werknemers_werkzaamheden VALUES(116,11);
INSERT INTO werknemers_werkzaamheden VALUES(157,12);
INSERT INTO werknemers_werkzaamheden VALUES(158,13);
INSERT INTO werknemers_werkzaamheden VALUES(139,14);
INSERT INTO werknemers_werkzaamheden VALUES(156,15);


/* Werkzaamheden_festival insert*/
INSERT INTO werkzaamheden_festival VALUES(1,115);
INSERT INTO werkzaamheden_festival VALUES(2,110);
INSERT INTO werkzaamheden_festival VALUES(3,114);
INSERT INTO werkzaamheden_festival VALUES(4,113);
INSERT INTO werkzaamheden_festival VALUES(5,112);
INSERT INTO werkzaamheden_festival VALUES(6,111);
INSERT INTO werkzaamheden_festival VALUES(7,109);
INSERT INTO werkzaamheden_festival VALUES(8,108);
INSERT INTO werkzaamheden_festival VALUES(9,107);
INSERT INTO werkzaamheden_festival VALUES(10,106);
INSERT INTO werkzaamheden_festival VALUES(11,105);
INSERT INTO werkzaamheden_festival VALUES(12,104);
INSERT INTO werkzaamheden_festival VALUES(13,103);
INSERT INTO werkzaamheden_festival VALUES(14,102);
INSERT INTO werkzaamheden_festival VALUES(15,101);
INSERT INTO werkzaamheden_festival VALUES(16,118);
INSERT INTO werkzaamheden_festival VALUES(17,119);
INSERT INTO werkzaamheden_festival VALUES(18,120);
INSERT INTO werkzaamheden_festival VALUES(19,130);
INSERT INTO werkzaamheden_festival VALUES(20,131);
INSERT INTO werkzaamheden_festival VALUES(21,132);
INSERT INTO werkzaamheden_festival VALUES(22,133);
INSERT INTO werkzaamheden_festival VALUES(23,134);
INSERT INTO werkzaamheden_festival VALUES(24,135);
INSERT INTO werkzaamheden_festival VALUES(25,136);
INSERT INTO werkzaamheden_festival VALUES(26,137);
INSERT INTO werkzaamheden_festival VALUES(27,138);
INSERT INTO werkzaamheden_festival VALUES(28,139);
INSERT INTO werkzaamheden_festival VALUES(29,140);
INSERT INTO werkzaamheden_festival VALUES(30,141);
INSERT INTO werkzaamheden_festival VALUES(31,164);
INSERT INTO werkzaamheden_festival VALUES(32,163);
INSERT INTO werkzaamheden_festival VALUES(33,162);
INSERT INTO werkzaamheden_festival VALUES(34,161);
INSERT INTO werkzaamheden_festival VALUES(35,160);
INSERT INTO werkzaamheden_festival VALUES(36,159);
INSERT INTO werkzaamheden_festival VALUES(37,158);
INSERT INTO werkzaamheden_festival VALUES(38,157);
INSERT INTO werkzaamheden_festival VALUES(39,156);
INSERT INTO werkzaamheden_festival VALUES(40,155);
INSERT INTO werkzaamheden_festival VALUES(41,154);
INSERT INTO werkzaamheden_festival VALUES(42,153);
INSERT INTO werkzaamheden_festival VALUES(43,152);
INSERT INTO werkzaamheden_festival VALUES(44,151);
INSERT INTO werkzaamheden_festival VALUES(45,150);



