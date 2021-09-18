clear;

% datafile = "Data0909.mat";    % game play data file
% outfile  = "StatsTable0909";   % output file name for stats
datafile = "Practice0913Game22.mat";    % game play data file
outfile  = "StatsTable0913G22";   % output file name for stats
proj = matlab.project.currentProject;  % get proj info
%% Load data

load(datafile)

varPlayer = unique(GameActions.Player);
varAction = unique(GameActions.Action);

openvar('GameActions');   % show game action table

%% Initialize stats table

statsEntries = ["2pt","3pt","Layup","FT", ...
                "Regular Pass", "Threat Pass", "Missed Pass", ...
                "shot allowed", "shot contested", ...
                "Def Reb", "Off Reb", ...
                "Assist", "Turnover", ...
                "Steal", "Block", ...
                "Off-Ball Screen", "Screen Assist"];

sz = [length(varPlayer) length(statsEntries)+1];
varTypes = ["string",repmat("string",1,4),repmat("double",1,length(statsEntries)-4)];
statsTable = table('Size',sz,'VariableTypes',varTypes,'VariableNames',["Player" statsEntries]);
statsTable.Player = varPlayer;

%% Get stats for each player

numPlayer = length(varPlayer);

% pull stats on each action type
for i = 1:numPlayer
  currPlayer = statsTable.Player(i);
  currTable  = GameActions(GameActions.Player==currPlayer,:);
  curr2ptA   = sum(currTable.Action=="Shoot" & (contains(currTable.Detail1,"2") | contains(currTable.Detail1,"Close")));
  curr2ptM   = sum(currTable.Action=="Shoot" & (contains(currTable.Detail1,"2") | contains(currTable.Detail1,"Close")) & currTable.Detail2=='made');
  curr3ptA   = sum(currTable.Action=="Shoot" & contains(currTable.Detail1,"3"));
  curr3ptM   = sum(currTable.Action=="Shoot" & contains(currTable.Detail1,"3") & currTable.Detail2=='made');
  currLayA   = sum(currTable.Action=="Shoot" & currTable.Detail1=="Layup");
  currLayM   = sum(currTable.Action=="Shoot" & currTable.Detail1=="Layup" & currTable.Detail2=='made');
  currFTA   = sum(currTable.Action=="Shoot" & currTable.Detail1=="FreeThrow");
  currFTM   = sum(currTable.Action=="Shoot" & currTable.Detail1=="FreeThrow" & currTable.Detail2=='made');
  currPassR  = sum(currTable.Action=="Pass" & currTable.Detail1=="Regular");
  currPassT  = sum(currTable.Action=="Pass" & currTable.Detail1=="Threat");
  currPassM  = sum(currTable.Action=="Pass" & currTable.Detail1=="Missed");
  currAssist = sum(currTable.Action=="Pass" & currTable.Detail1=="Assist");
  currShotA  = sum(currTable.Action=="Defense" & currTable.Detail1=="Shot Allowed");
  currShotC  = sum(currTable.Action=="Defense" & currTable.Detail1=="Shot Contest");
  currSteal  = sum(currTable.Action=="Defense" & currTable.Detail1=="Steal");
  currBlock  = sum(currTable.Action=="Defense" & currTable.Detail1=="Block");
  currDefReb = sum(currTable.Action=="Rebound" & currTable.Detail1=="Defensive");
  currOffReb = sum(currTable.Action=="Rebound" & currTable.Detail1=="Offensive");
  currTO     = sum(currTable.Action=="Turnover");
  currOBScr  = sum(currTable.Action=="Other" & currTable.Detail1=="Off-ball screen");
  currScrAss = sum(currTable.Action=="Other" & currTable.Detail1=="Screen assist");
  currEntry  = statsTable(statsTable.Player == currPlayer,:);
  currEntry(1,2)  = { strcat(num2str(curr2ptM),"/",num2str(curr2ptA)) };
  currEntry(1,3)  = { strcat(num2str(curr3ptM),"/",num2str(curr3ptA)) };
  currEntry(1,4)  = { strcat(num2str(currLayM),"/",num2str(currLayA)) };
  currEntry(1,5)  = { strcat(num2str(currFTM) ,"/",num2str(currFTA))  };
  currEntry(1,6)  = { currPassR };
  currEntry(1,7)  = { currPassT };
  currEntry(1,8)  = { currPassM };
  currEntry(1,9)  = { currShotA };
  currEntry(1,10) = { currShotC };
  currEntry(1,11) = { currDefReb };
  currEntry(1,12) = { currOffReb };
  currEntry(1,13) = { currAssist };
  currEntry(1,14) = { currTO };
  currEntry(1,15) = { currSteal };
  currEntry(1,16) = { currBlock };
  currEntry(1,17) = { currOBScr };
  currEntry(1,18) = { currScrAss };
  statsTable(i,:) = currEntry;
end

% show stats table
openvar('statsTable');

%% Save stats Table

% as a .mat file
save(strcat(proj.RootFolder,"\Stats\",outfile),"statsTable")

% stats as excel file
writetable(statsTable,strcat(proj.RootFolder,"\Stats\",outfile,'.xlsx'),'Sheet','Stats','WriteMode','overwritesheet');

% actions as excel file
writetable(GameActions,strcat(proj.RootFolder,"\Stats\",outfile,'.xlsx'),'Sheet','Actions','WriteMode','overwritesheet');

%% clean up
clear curr* i numPlayer var* sz statsEntries