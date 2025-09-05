DROP DATABASE IF EXISTS MLBstats_DB;
CREATE DATABASE MLBstats_DB;
USE MLBstats_DB;

CREATE TABLE hitters_src (
`Name` text,
`Team` text,
`G` text,
`PA` text,
`HR` text,
`R` text,
`RBI` text,
`SB` text,
`BB%` text,
`K%` text,
`ISO` text,
`BABIP` text,
`AVG` text,
`OBP` text,
`SLG` text,
`wOBA` text,
`xwOBA` text,
`wRC+` text,
`BsR` text,
`Off` text,
`Def` text,
`WAR` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/Users/evanadinolfe/Desktop/fangraphshitters.csv'
INTO TABLE hitters_src
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(`Name`,`Team`,`G`,`PA`,`HR`,`R`,`RBI`,`SB`,`BB%`,`K%`,`ISO`,`BABIP`,`AVG`,`OBP`,`SLG`,`wOBA`,`xwOBA`,`wRC+`,`BsR`,`Off`,`Def`,`WAR`);

SELECT * FROM hitters_src;

CREATE TABLE hitters_statcast_src (
`Name` text,
`Team` text,
`PA` text,
`Events` text,
`EV` text,
`EV90` text,
`maxEV` text,
`LA` text,
`Barrels` text,
`Barrel%` text,
`HardHit` text,
`HardHit%` text,
`AVG` text,
`xBA` text,
`SLG` text,
`xSLG` text,
`wOBA` text,
`xwOBA` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/Users/evanadinolfe/Desktop/fangraphshittersstatcast.csv'
INTO TABLE hitters_statcast_src
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`Name`, `Team`, `PA`, `Events`, `EV`, `EV90`, `maxEV`, `LA`, `Barrels`, `Barrel%`, `HardHit`, `HardHit%`, `AVG`, `xBA`, `SLG`, `xSLG`, `wOBA`, `xwOBA`);

SELECT * FROM hitters_statcast_src;

UPDATE hitters_statcast_src
SET `Barrel%` = REPLACE(`Barrel%`, '%', '');

UPDATE hitters_statcast_src
SET `HardHit%` = REPLACE(`HardHit%`, '%', '');

SELECT * FROM hitters_src;

UPDATE hitters_src
SET `BB%` = REPLACE(`BB%`, '%', '');

UPDATE hitters_src
SET `K%` = REPLACE(`K%`, '%', '');

UPDATE hitters_src
SET `xwOBA` = NULL
WHERE `xwOBA` = '';

UPDATE hitters_statcast_src
SET `xwOBA` = NULL
WHERE `xwOBA` = 0;

UPDATE hitters_statcast_src
SET `xSLG` = NULL
WHERE `xSLG` = '';

UPDATE hitters_statcast_src
SET `xBA` = NULL
WHERE `xBA` = '';


UPDATE hitters_statcast_src
SET `Name` = NULL
WHERE `Name` = '';

UPDATE hitters_statcast_src
SET `Team` = NULL
WHERE `Team` = '';

UPDATE hitters_statcast_src
SET `PA` = NULL
WHERE `PA` = '' OR `PA` = 0;


UPDATE hitters_statcast_src
SET `Events` = NULL
WHERE `Events` = '' OR `Events` = 0;


UPDATE hitters_statcast_src
SET `EV90` = NULL
WHERE `EV90` = '' OR `EV90` = 0;

UPDATE hitters_statcast_src
SET `EV` = NULL
WHERE `EV` = '' OR `EV` = 0;

UPDATE hitters_statcast_src
SET `maxEV` = NULL
WHERE `maxEV` = '' OR `maxEV` = 0;

UPDATE hitters_statcast_src
SET `LA` = NULL
WHERE `LA` = '' OR `LA` = 0;

UPDATE hitters_statcast_src
SET `Barrels` = NULL
WHERE `Barrels` = '' OR `Barrels` = 0;

UPDATE hitters_statcast_src
SET `Barrel%` = NULL
WHERE `Barrel%` = '' OR `Barrel%` = 0;

UPDATE hitters_statcast_src
SET `HardHit` = NULL
WHERE `HardHit` = '' OR `HardHit` = 0;

UPDATE hitters_statcast_src
SET `HardHit%` = NULL
WHERE `HardHit%` = '' OR `HardHit%` = 0;

UPDATE hitters_statcast_src
SET `AVG` = NULL
WHERE `AVG` = '' OR `AVG` = 0;

UPDATE hitters_statcast_src
SET `SLG` = NULL
WHERE `SLG` = '' OR `SLG` = 0;

UPDATE hitters_statcast_src
SET `wOBA` = NULL
WHERE `wOBA` = '' OR `wOBA` = 0;

SELECT * FROM hitters_src;

CREATE TABLE Hitters (
Name VARCHAR(100) NOT NULL,
Team VARCHAR(5) NOT NULL,
G INT UNSIGNED,
PA INT UNSIGNED,
HR INT UNSIGNED,
R INT UNSIGNED,
RBI INT UNSIGNED,
SB INT UNSIGNED,
BB_pct FLOAT,
K_pct FLOAT,
ISO FLOAT,
BABIP FLOAT,
AVG FLOAT,
OBP FLOAT,
SLG FLOAT,
wOBA FLOAT,
xwOBA FLOAT,
wRC_plus FLOAT,
BsR FLOAT,
Off FLOAT,	
Def FLOAT,
WAR FLOAT
);

INSERT INTO Hitters (Name, Team, G, PA, HR, R, RBI, SB, BB_pct, K_pct, ISO, BABIP, AVG, OBP, SLG, wOBA, xwOBA, wRC_plus, BsR, Off, Def, WAR)
SELECT DISTINCT
`Name`,
`Team`,
`G`,
`PA`,
`HR`,
`R`,
`RBI`,
`SB`,
`BB%`,
`K%`,
`ISO`,
`BABIP`,
`AVG`,
`OBP`,
`SLG`,
`wOBA`,
`xwOBA`,
`wRC+`,
`BsR`,
`Off`,
`Def`,
`WAR`
FROM hitters_src;

SELECT * FROM hitters;

SELECT * FROM hitters_statcast_src;

CREATE TABLE Hitters_Statcast (
Name VARCHAR(100),
Team VARCHAR(5),
PA SMALLINT UNSIGNED,
Events SMALLINT UNSIGNED,
EV FLOAT,
EV90 FLOAT,
maxEV FLOAT,
LA FLOAT,
Barrels SMALLINT UNSIGNED,
Barrel_pct FLOAT,
HardHit SMALLINT UNSIGNED,
HardHit_pct FLOAT,
AVG FLOAT,
xBA FLOAT,
SLG FLOAT,
xSLG FLOAT,
wOBA FLOAT,
xwOBA FLOAT
);

INSERT INTO Hitters_Statcast (Name, Team, PA, Events, EV, EV90, maxEV, LA, Barrels, Barrel_pct, HardHit, HardHit_pct, 
AVG, xBA, SLG, xSLG, wOBA, xwOBA)
SELECT DISTINCT
`Name`,
`Team`,
`PA`,
`Events`,
`EV`,
`EV90`,
`maxEV`,
`LA`,
`Barrels`,
`Barrel%`,
`HardHit`,
`HardHit%`,
`AVG`,
`xBA`,
`SLG`,
`xSLG`,
`wOBA`,
`xwOBA`
FROM hitters_statcast_src;

SELECT * FROM Hitters_Statcast;

DELETE FROM Hitters_Statcast
WHERE Name IS NULL OR Team IS NULL;

ALTER TABLE Hitters
ADD PRIMARY KEY (Name, Team);

ALTER TABLE Hitters_Statcast
ADD PRIMARY KEY (Name, Team);

ALTER TABLE Hitters_Statcast
ADD FOREIGN KEY (Name, Team) 
REFERENCES Hitters(Name, Team)
ON UPDATE CASCADE
ON DELETE CASCADE;

CREATE TABLE Teams (
Team VARCHAR(5) PRIMARY KEY,
League CHAR(2)
);

INSERT INTO Teams (Team) VALUES
('BAL'), ('BOS'), ('CHW'), ('CLE'), ('DET'), ('HOU'), ('KCR'), ('LAA'), ('MIN'), ('NYY'), ('ATH'), ('SEA'), ('TBR'), ('TEX'),
('TOR'), ('ARI'), ('ATL'), ('CHC'), ('CIN'), ('COL'), ('LAD'), ('MIA'), ('MIL'), ('NYM'), ('PHI'), ('PIT'), ('SDP'), ('SFG'), 
('STL'), ('WSN'), ('2 Tms'), ('3 Tms');

Update Teams
SET League =
CASE
WHEN Team IN ('BAL', 'BOS', 'CHW', 'CLE', 'DET', 'HOU', 'KCR', 'LAA', 'MIN', 'NYY', 'ATH', 'SEA', 'TBR', 'TEX', 'TOR') THEN 'AL'
WHEN Team IN ('ARI', 'ATL', 'CHC', 'CIN', 'COL', 'LAD', 'MIA', 'MIL', 'NYM', 'PHI', 'PIT', 'SDP', 'SFG', 'STL', 'WSN') THEN 'NL'
ELSE NULL
END;

ALTER TABLE Hitters
ADD FOREIGN KEY (Team) REFERENCES Teams (Team);

SELECT * FROM Hitters_Statcast hs
JOIN Hitters h ON h.Name = hs.Name AND h.Team = hs.Team;

#Best Power Hitters
SELECT h.Name, h.Team, Barrel_pct AS 'Barrel%', LA, HardHit_pct AS 'HardHit%', EV, h.SLG, xSLG, ROUND(xSLG - h.SLG,3) AS SLG_diff, HR FROM Hitters_Statcast hs
JOIN Hitters h ON h.Name = hs.Name AND h.Team = hs.Team
WHERE HR > 20
ORDER BY EV DESC;

#Stats by team
WITH Team_Stats AS (
    SELECT
        RANK() OVER (ORDER BY ROUND(ROUND(AVG(xSLG), 3) - ROUND(AVG(st.SLG), 3),3) DESC) AS Ranking,
        h.Team,
        SUM(st.PA) AS Total_PA,
        ROUND(AVG(st.AVG), 3) AS Team_AVG,
        ROUND(AVG(xBA), 3) AS Team_xBA,
        ROUND(AVG(OBP), 3) AS Avg_OBP,
        ROUND(AVG(st.SLG), 3) AS Team_SLG,
        ROUND(AVG(xSLG), 3) AS Team_xSLG,
        ROUND(ROUND(AVG(xSLG), 3) - ROUND(AVG(st.SLG), 3),3) AS SLG_diff,
        SUM(HR) AS Total_HR,
        ROUND(AVG(st.wOBA), 3) AS Team_wOBA,
        ROUND(AVG(st.xwOBA), 3) AS Team_xwOBA,
        ROUND(AVG(K_pct), 2) AS Avg_K_pct,
        ROUND(AVG(BB_pct), 2) AS Avg_BB_pct,
        ROUND(AVG(EV), 2) AS Avg_EV,
        ROUND(AVG(Barrel_pct), 2) AS Avg_Barrel_pct,
        ROUND(AVG(HardHit_pct), 2) AS Avg_HardHit_pct
    FROM Hitters_Statcast st
    JOIN Hitters h ON h.Name = st.Name AND h.Team = st.Team
    WHERE h.Team NOT LIKE '%tms%'
    GROUP BY h.Team
)

SELECT *
FROM Team_Stats
ORDER BY Ranking ASC;

#Home runs per Strikeout
SELECT h.Name, h.Team, h.PA, HR, ROUND((K_pct * h.PA) / 100,0) AS K, ROUND(HR / ((K_pct * h.PA) / 100),2) AS HR_per_K
FROM Hitters_Statcast st
JOIN Hitters h ON h.Name = st.Name AND h.Team = st.Team
WHERE h.PA > 200 AND HR > 15
ORDER BY HR_per_K DESC
LIMIT 10;

#MVP candidates ranked by WAR
SELECT RANK() OVER (ORDER BY h.WAR DESC) AS Ranking, h.Name, h.Team, League, ROUND(OBP + h.SLG,3) AS OPS , h.wOBA, wRC_plus, WAR
FROM Hitters_Statcast st
JOIN Hitters h ON h.Name = st.Name AND h.Team = st.Team
JOIN Teams t ON t.Team = h.Team
WHERE h.PA > 200
ORDER BY WAR DESC;

#MVP candidates ranked by wRC+
SELECT RANK() OVER (ORDER BY h.wRC_plus DESC) AS Ranking, h.Name, h.Team, League, ROUND(OBP + h.SLG,3) AS OPS , h.wOBA, wRC_plus, WAR
FROM Hitters_Statcast st
JOIN Hitters h ON h.Name = st.Name AND h.Team = st.Team
JOIN Teams T ON t.Team = h.Team
WHERE h.PA > 200
ORDER BY wRC_plus DESC;

#AL MVP candidates ranked by WAR
SELECT RANK() OVER (ORDER BY h.WAR DESC) AS Ranking, h.Name, h.Team, League, ROUND(OBP + h.SLG,3) AS OPS , h.wOBA, wRC_plus, WAR
FROM Hitters_Statcast st
JOIN Hitters h ON h.Name = st.Name AND h.Team = st.Team
JOIN Teams t ON t.Team = h.Team
WHERE h.PA > 200 AND League = 'AL'
ORDER BY WAR DESC;

#NL MVP candidates ranked by WAR
SELECT RANK() OVER (ORDER BY h.wRC_plus DESC) AS Ranking, h.Name, h.Team, League, ROUND(OBP + h.SLG,3) AS OPS , h.wOBA, wRC_plus, WAR
FROM Hitters_Statcast st
JOIN Hitters h ON h.Name = st.Name AND h.Team = st.Team
JOIN Teams t ON t.Team = h.Team
WHERE h.PA > 200 AND League = 'NL'
ORDER BY wRC_plus DESC;

#The difference between Judge and Raleigh's wRC+ is the same as the difference between Raleigh and the following players.
SELECT h.Name, h.Team, ROUND(OBP + h.SLG,3) AS OPS , h.wOBA, wRC_plus, WAR
FROM Hitters_Statcast st
JOIN Hitters h ON h.Name = st.Name AND h.Team = st.Team
WHERE h.PA > 200 AND wRC_plus =
(SELECT wRC_plus FROM Hitters WHERE Name = 'Cal Raleigh') - 
((SELECT wRC_plus FROM Hitters WHERE Name = 'Aaron Judge') - (SELECT wRC_plus FROM Hitters WHERE Name = 'Cal Raleigh'))
ORDER BY wRC_plus DESC;

#WAR per PA
SELECT h.Name, h.Team, h.PA, WAR, ROUND(WAR / h.PA * 100, 3) AS WAR_per_100PA
FROM Hitters_Statcast st
JOIN Hitters h ON h.Name = st.Name AND h.Team = st.Team
JOIN Teams t ON t.Team = h.Team
WHERE h.PA > 200 AND League = 'NL'
ORDER BY WAR_per_100PA DESC;

#PCA BB%
SELECT h.Name, h.Team, h.BB_pct
FROM Hitters h
WHERE Name = 'Pete Crow-Armstrong';

#League AVG BB%
SELECT AVG(BB_pct) AS LeagueAvg_BBpct
FROM Hitters h;

#League Leaders in Strikeouts
SELECT RANK() OVER (ORDER BY SLG DESC) AS Ranking, h.Name, h.Team, h.PA, Barrel_pct, h.SLG
FROM Hitters_Statcast st
JOIN Hitters h ON h.Name = st.Name AND h.Team = st.Team
WHERE h.PA > 200
ORDER BY h.SLG DESC;

#Most Unlucky Players
SELECT RANK() OVER (ORDER BY  ROUND(h.xwOBA - h.wOBA, 3) ASC) AS Ranking, h.Name, h.Team, h.PA, EV, Barrel_pct, HardHit_pct, h.wOBA, h.xwOBA, ROUND(h.xwOBA - h.wOBA, 3) AS wOBA_diff
FROM Hitters_Statcast st
JOIN Hitters h ON h.Name = st.Name AND h.Team = st.Team
WHERE h.PA > 200 AND h.wOBA > .300
ORDER BY wOBA_diff ASC;

#Worst Barrel Rates
SELECT h.name, t.team, h.pa, h.AVG, barrel_pct
FROM Hitters_Statcast st
JOIN Hitters h ON h.Name = st.Name AND h.Team = st.Team
JOIN Teams t ON t.Team = h.Team
WHERE h.PA > 200
ORDER BY barrel_pct asc;







