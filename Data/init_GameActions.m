% initialize a new GameActions Table variable

clear GameActions

% % 10 table fields
% i = 0; 
% varNames = {};  
% varTypes = {};
% i=i+1; varNames{i} = 'Team';    varTypes{i} = 'string';
% i=i+1; varNames{i} = 'Player';  varTypes{i} = 'string';
% i=i+1; varNames{i} = 'Action';  varTypes{i} = 'string';
% i=i+1; varNames{i} = 'Shoot';   varTypes{i} = 'string';
% i=i+1; varNames{i} = 'Result';  varTypes{i} = 'string';
% i=i+1; varNames{i} = 'Pass';    varTypes{i} = 'string';
% i=i+1; varNames{i} = 'Rebound'; varTypes{i} = 'string';
% i=i+1; varNames{i} = 'Defense'; varTypes{i} = 'string';
% i=i+1; varNames{i} = 'Other';   varTypes{i} = 'string';
% i=i+1; varNames{i} = 'Notes';   varTypes{i} = 'string';
% sz = [0 i];
% % new empty table
% GameActions = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

% 6 table fields
i = 0; 
varNames = {};  
varTypes = {};
i=i+1; varNames{i} = 'Team';    varTypes{i} = 'string';
i=i+1; varNames{i} = 'Player';  varTypes{i} = 'string';
i=i+1; varNames{i} = 'Action';  varTypes{i} = 'string';
i=i+1; varNames{i} = 'Detail1'; varTypes{i} = 'string';
i=i+1; varNames{i} = 'Detail2'; varTypes{i} = 'string';
i=i+1; varNames{i} = 'Notes';   varTypes{i} = 'string';
sz = [0 i];
% new empty table
GameActions = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);