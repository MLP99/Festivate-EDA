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
    partner_id INT NOT NULL UNIQUE,
    festival_id INT NOT NULL UNIQUE,
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
    festival_id INT NOT NULL UNIQUE,
    sponsor_id INT NOT NULL UNIQUE,
    item VARCHAR(60),
    omschrijving VARCHAR(200),
    waarde DECIMAL,

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
    festival_id INT NOT NULL UNIQUE,
    categorie_id INT NOT NULL UNIQUE,

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
    prijs DECIMAL,
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
    ticket_id INT NOT NULL UNIQUE,
    bezoeker_id INT NOT NULL UNIQUE,
    festival_id INT NOT NULL UNIQUE,
    ticket_categorie INT NOT NULL UNIQUE,
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
    bezoeker_id INT NOT NULL UNIQUE,
    naam VARCHAR(60),
    prijs DECIMAL,
    aantal INT,

    CONSTRAINT PK_verkoop_producten
    PRIMARY KEY(verkoop_id),

    CONSTRAINT FK_verkoop_producten_bezoeker
    FOREIGN KEY(bezoeker_id)
        REFERENCES bezoeker(bezoeker_id)
)

CREATE TABLE verkoop_producten_festival
(
    festival_id INT NOT NULL UNIQUE,
    verkoop_id INT NOT NULL UNIQUE,

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
    festival_id INT NOT NULL UNIQUE,
    bezoeker_id INT NOT NULL UNIQUE,

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
    prijs DECIMAL,
    aantal INT,
    leverancier VARCHAR(60),

    CONSTRAINT PK_inkoop
    PRIMARY KEY(inkoop_id)
)

CREATE TABLE inkoop_festival
(
    festival_id INT NOT NULL UNIQUE,
    inkoop_id INT NOT NULL UNIQUE,

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
    locatie_id INT NOT NULL UNIQUE,
    festival_id INT NOT NULL UNIQUE,
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
    kosten DECIMAL,

    CONSTRAINT PK_campagne
    PRIMARY KEY(campagne_id)
)

CREATE TABLE campagne_festival
(
    festival_id INT NOT NULL UNIQUE,
    campagne_id INT NOT NULL UNIQUE,

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
    werkzaamheden_id INT NOT NULL UNIQUE,
    titel VARCHAR(20),
    omschrijving VARCHAR(200),
    startdatum DATE,
    einddatum DATE,
    tijdsduur INT,

    CONSTRAINT PK_werkzaamheden
    PRIMARY KEY(werkzaamheden_id)
)

CREATE TABLE werknemers_werkzaamheden
(
    werkzaamheden_id INT NOT NULL UNIQUE,
    werknemer_id INT NOT NULL UNIQUE,

    CONSTRAINT FK_werknemers_werkzaamheden_werkzaamheden
    FOREIGN KEY(werkzaamheden_id)
        REFERENCES werkzaamheden(werkzaamheden_id),

    CONSTRAINT FK_werknemers_werkzaamheden_werknemers
    FOREIGN KEY(werknemer_id)
        REFERENCES werknemers(werknemer_id)
)

CREATE TABLE werkzaamheden_festival
(
    festival_id INT NOT NULL UNIQUE,
    werkzaamheden_id INT NOT NULL UNIQUE,

    CONSTRAINT FK_werkzaamheden_festival_festival
    FOREIGN KEY(festival_id)
        REFERENCES festival(festival_id),
    
    CONSTRAINT FK_werkzaamheden_festival_werknemers_werkzaamheden
    FOREIGN KEY(werkzaamheden_id)
        REFERENCES werkzaamheden(werkzaamheden_id)
)
