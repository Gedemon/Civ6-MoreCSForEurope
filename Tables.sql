/*

	YnAMP
	City States creation file
	by Gedemon (2016)	

*/


-----------------------------------------------
-- Create Start Positions Table if needed
-----------------------------------------------

CREATE TABLE IF NOT EXISTS StartPosition
	(	MapName TEXT,
		Civilization TEXT,
		Leader TEXT,
		X INT default 0,
		Y INT default 0);
