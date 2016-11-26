/*

	YnAMP
	City States creation file
	by Gedemon (2016)
	
	Category : 	SCIENTIFIC | INDUSTRIAL | MILITARISTIC | CULTURAL | RELIGIOUS | TRADE
	Ethnicity : MEDIT | EURO | SOUTHAM | ASIAN | AFRICAN
	
	Traits :
		Scientific:		GENEVA | HATTUSA | SEOUL | STOCKHOLM
		Industrial:		BRUSSELS | BUENOS_AIRES | HONG_KONG | TORONTO
		Militaristic:	CARTHAGE | KABUL | PRESLAV | VALLETTA
		Cultural:		KUMASI | MOHENJO_DARO | MADOL | VILNIUS
		Religious:		JERUSALEM | KANDY | LA_VENTA | YEREVAN
		Trade:			AMSTERDAM | JAKARTA | LISBON | ZANZIBAR
*/

	
-----------------------------------------------
-- Temporary Tables for initialization
-----------------------------------------------

DROP TABLE IF EXISTS CityStatesConfiguration;
		
CREATE TABLE CityStatesConfiguration
	(	Name TEXT,
		Category TEXT,
		Ethnicity TEXT,
		Trait TEXT
	);

-----------------------------------------------
-- Fill the initialization table
-----------------------------------------------
INSERT INTO CityStatesConfiguration
	(		Name,			Category,		Ethnicity,	Trait )
SELECT	'DUBLIN',			'INDUSTRIAL',	'EURO'	,	'TORONTO' UNION ALL
SELECT	'GARAMANTES',		'INDUSTRIAL',	'MEDIT'	,	'HONG_KONG' UNION ALL
SELECT	'KIEV',				'CULTURAL',		'EURO'	,	'MOHENJO_DARO' UNION ALL
SELECT	'RABAT',			'TRADE',		'MEDIT'	,	'ZANZIBAR' UNION ALL
SELECT	'REYKJAVIK',		'SCIENTIFIC',	'EURO'	,	'SEOUL' UNION ALL
SELECT	'WARSAW',			'INDUSTRIAL',	'EURO'	,	'BUENOS_AIRES' UNION ALL
SELECT	'END_OF_INSERT',	NULL,			NULL,		NULL;	
-----------------------------------------------

-- Remove "END_OF_INSERT" entry 
DELETE from CityStatesConfiguration WHERE Name ='END_OF_INSERT';

-----------------------------------------------
-- Update Gameplay Database
-----------------------------------------------

-- <Types> 
INSERT OR REPLACE INTO Types (Type, Kind)
	SELECT	'CIVILIZATION_' || Name, 'KIND_CIVILIZATION'
	FROM CityStatesConfiguration;
INSERT OR REPLACE INTO Types (Type, Kind)
	SELECT	'LEADER_MINOR_CIV_' || Name, 'KIND_LEADER'
	FROM CityStatesConfiguration;	

-- <TypeProperties>
INSERT OR REPLACE INTO TypeProperties (Type, Name, Value)
	SELECT	'CIVILIZATION_' || Name, 'CityStateCategory', Category
	FROM CityStatesConfiguration;
	
-- <Civilizations>
INSERT OR REPLACE INTO Civilizations (CivilizationType, Name, Description, Adjective, StartingCivilizationLevelType, RandomCityNameDepth, Ethnicity)
	SELECT	'CIVILIZATION_' || Name, 'LOC_CIVILIZATION_' || Name || '_NAME', 'LOC_CIVILIZATION_' || Name || '_DESCRIPTION', 'LOC_CIVILIZATION_' || Name || '_ADJECTIVE', 'CIVILIZATION_LEVEL_CITY_STATE', 1, 'ETHNICITY_' || Ethnicity
	FROM CityStatesConfiguration;
	
-- <CivilizationLeaders>
INSERT OR REPLACE INTO CivilizationLeaders (CivilizationType, LeaderType, CapitalName)
	SELECT	'CIVILIZATION_' || Name, 'LEADER_MINOR_CIV_' || Name, 'LOC_CITY_NAME_' || Name || '_1'
	FROM CityStatesConfiguration;
	
-- <CityNames>
INSERT OR REPLACE INTO CityNames (CivilizationType, CityName)
	SELECT	'CIVILIZATION_' || Name, 'LOC_CITY_NAME_' || Name || '_1'
	FROM CityStatesConfiguration;
INSERT OR REPLACE INTO CityNames (CivilizationType, CityName)
	SELECT	'CIVILIZATION_' || Name, 'LOC_CITY_NAME_' || Name || '_2'
	FROM CityStatesConfiguration;
INSERT OR REPLACE INTO CityNames (CivilizationType, CityName)
	SELECT	'CIVILIZATION_' || Name, 'LOC_CITY_NAME_' || Name || '_3'
	FROM CityStatesConfiguration;
INSERT OR REPLACE INTO CityNames (CivilizationType, CityName)
	SELECT	'CIVILIZATION_' || Name, 'LOC_CITY_NAME_' || Name || '_4'
	FROM CityStatesConfiguration;
INSERT OR REPLACE INTO CityNames (CivilizationType, CityName)
	SELECT	'CIVILIZATION_' || Name, 'LOC_CITY_NAME_' || Name || '_5'
	FROM CityStatesConfiguration;

-- <PlayerColors>
INSERT OR REPLACE INTO Colors VALUES ('COLOR_PLAYER_CITY_STATE_SCIENTIFIC_SECONDARY','0.13','0.75','0.97','1'); -- they've used "SCIENCE" instead of "SCIENTIFIC" in that table, adding correct entry here
INSERT OR REPLACE INTO PlayerColors (Type, Usage, PrimaryColor, SecondaryColor, TextColor)
	SELECT	'CIVILIZATION_' || Name, 'Minor', 'COLOR_PLAYER_CITY_STATE_PRIMARY', 'COLOR_PLAYER_CITY_STATE_' || Category || '_SECONDARY', 'COLOR_PLAYER_CITY_STATE_' || Category || '_SECONDARY'
	FROM CityStatesConfiguration;
	
-- <Leaders>
INSERT OR REPLACE INTO Leaders (LeaderType, Name, InheritFrom)
	SELECT	'LEADER_MINOR_CIV_' || Name, 'LOC_CIVILIZATION_' || Name || '_NAME', 'LEADER_MINOR_CIV_' || Category
	FROM CityStatesConfiguration;
	
-- <LeaderTraits>
INSERT OR REPLACE INTO LeaderTraits (LeaderType, TraitType)
	SELECT	'LEADER_MINOR_CIV_' || Name, 'MINOR_CIV_' || Trait || '_TRAIT'
	FROM CityStatesConfiguration;

	
-----------------------------------------------
-- Delete temporary table
-----------------------------------------------

DROP TABLE CityStatesConfiguration;

