%% Set up stuff

clear;

newTable = 0;    % create new table?
addEntry = 100;  % randomly add # of entries, for testing
filename = "TestTable.mat";  % data file name

%% Load or create game action table

if newTable
  varNames = {'Action','Player','Result'};
  varTypes = {'string','string','double'};
  sz = [0 length(varNames)];
  GameActions =  table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);
else
  load(filename)
end

%% Add random entries

listPlayer = ["Adam","Ben","Cole","Dan","Eddy","Frank","Gary","Henry"];
listAction = ["Pass","2pt","3pt","Layup","FT"];
% listResult = [0.00, 0.25, 0.50, 0.75, 1.00];
listResult = [0.00, 1.00];

idx = size(GameActions,1); % number of existing rows
for i = 1:addEntry
  tmpAction = listAction(randperm(length(listAction),1));
  tmpPlayer = listPlayer(randperm(length(listPlayer),1));
  tmpResult = listResult(randperm(length(listResult),1));
  idx = idx + 1;
  GameActions(idx,:) = table([tmpAction],[tmpPlayer],[tmpResult]);
end
save(filename,"GameActions")