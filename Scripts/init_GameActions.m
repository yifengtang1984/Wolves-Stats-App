% initialize a new GameActions Table variable

clear GameActions

i = 0; 
varNames = {};  
varTypes = {};
i=i+1; varNames{i} = 'id';      varTypes{i} = 'double';
i=i+1; varNames{i} = 'Player';  varTypes{i} = 'string';
i=i+1; varNames{i} = 'Action';  varTypes{i} = 'string';
i=i+1; varNames{i} = 'Detail1'; varTypes{i} = 'string';
i=i+1; varNames{i} = 'Detail2'; varTypes{i} = 'string';
i=i+1; varNames{i} = 'Notes';   varTypes{i} = 'string';
i=i+1; varNames{i} = 'Team';    varTypes{i} = 'string';
i=i+1; varNames{i} = 'Teammate1';   varTypes{i} = 'string';
i=i+1; varNames{i} = 'Teammate2';   varTypes{i} = 'string';
i=i+1; varNames{i} = 'Teammate3';   varTypes{i} = 'string';
i=i+1; varNames{i} = 'Teammate4';   varTypes{i} = 'string';
i=i+1; varNames{i} = 'Teammate5';   varTypes{i} = 'string';
i=i+1; varNames{i} = 'Opponent1';   varTypes{i} = 'string';
i=i+1; varNames{i} = 'Opponent2';   varTypes{i} = 'string';
i=i+1; varNames{i} = 'Opponent3';   varTypes{i} = 'string';
i=i+1; varNames{i} = 'Opponent4';   varTypes{i} = 'string';
i=i+1; varNames{i} = 'Opponent5';   varTypes{i} = 'string';
sz = [0 i];
% new empty table
GameActions = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

clear sz i var*