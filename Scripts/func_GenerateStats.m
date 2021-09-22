function out = func_GenerateStats(GameActions,outfile)
% generates stats files from actions data
%   filelist: list of game action files
%   outfile : name of output stats file

  proj = matlab.project.currentProject;  % get proj info
  varPlayer = unique(GameActions.Player);
  
  %% Initialize stats table

  statsEntries = ["PTS", ...
                  "2pt", ...
                  "3pt", ...
                  "Layup", ...
                  "FT", ...
                  "Regular Pass", ...
                  "Threat Pass", ...
                  "Missed Pass", ...
                  "shot allowed", ...
                  "shot contested", ...
                  "Def Reb", ...
                  "Off Reb", ...
                  "Assist", ...
                  "Turnover", ...
                  "Steal", ...
                  "Block", ...
                  "Off-Ball Screen", ...
                  "Screen Assist"];

  sz = [length(varPlayer) length(statsEntries)+1];
  varTypes = ["string","double",repmat("string",1,4),repmat("double",1,length(statsEntries)-5)];
  statsTable = table('Size',sz,'VariableTypes',varTypes,'VariableNames',["Player" statsEntries]);
  statsTable.Player = varPlayer;  
  
  %% Get stats for each player

  numPlayer = length(varPlayer);

  % pull stats on each action type
  for i = 1:numPlayer
    currPlayer = statsTable.Player(i);
    currTable  = GameActions(GameActions.Player==currPlayer,:);
    curr2ptO   = sum(currTable.Action=="Make Shot" & (contains(currTable.Detail1,"2") | contains(currTable.Detail1,"Close")));
    curr2ptX   = sum(currTable.Action=="Miss Shot" & (contains(currTable.Detail1,"2") | contains(currTable.Detail1,"Close")));
    curr3ptO   = sum(currTable.Action=="Make Shot" & contains(currTable.Detail1,"3"));
    curr3ptX   = sum(currTable.Action=="Miss Shot" & contains(currTable.Detail1,"3"));
    currLayO   = sum(currTable.Action=="Make Shot" & currTable.Detail1=="Layup");
    currLayX   = sum(currTable.Action=="Miss Shot" & currTable.Detail1=="Layup");
    currFTO    = sum(currTable.Action=="Make Shot" & currTable.Detail1=="FreeThrow");
    currFTX    = sum(currTable.Action=="Miss Shot" & currTable.Detail1=="FreeThrow");
    currPTS    = curr3ptO*3 + curr2ptO*2 + currLayO*2 + currFTO*1; 
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
    j=1;
    j=j+1; currEntry(1,j)  = { currPTS };
    j=j+1; currEntry(1,j)  = { strcat(num2str(curr2ptO)," / ",num2str(curr2ptO+curr2ptX)) };
    j=j+1; currEntry(1,j)  = { strcat(num2str(curr3ptO)," / ",num2str(curr3ptO+curr3ptX)) };
    j=j+1; currEntry(1,j)  = { strcat(num2str(currLayO)," / ",num2str(currLayO+currLayX)) };
    j=j+1; currEntry(1,j)  = { strcat(num2str(currFTO) ," / ",num2str(currFTO +currFTX )) };
    j=j+1; currEntry(1,j)  = { currPassR };
    j=j+1; currEntry(1,j)  = { currPassT };
    j=j+1; currEntry(1,j)  = { currPassM };
    j=j+1; currEntry(1,j)  = { currShotA };
    j=j+1; currEntry(1,j) = { currShotC };
    j=j+1; currEntry(1,j) = { currDefReb };
    j=j+1; currEntry(1,j) = { currOffReb };
    j=j+1; currEntry(1,j) = { currAssist };
    j=j+1; currEntry(1,j) = { currTO };
    j=j+1; currEntry(1,j) = { currSteal };
    j=j+1; currEntry(1,j) = { currBlock };
    j=j+1; currEntry(1,j) = { currOBScr };
    j=j+1; currEntry(1,j) = { currScrAss };
    statsTable(i,:) = currEntry;
  end
  
  %% Save stats Table

  % as a .mat file
  save(strcat(proj.RootFolder,"/Stats/",outfile),"statsTable")

  % stats as excel file
  writetable(statsTable,strcat(proj.RootFolder,"/Stats/",outfile,'.xlsx'),'Sheet','Stats','WriteMode','overwritesheet');

  % actions as excel file
  writetable(GameActions,strcat(proj.RootFolder,"/Stats/",outfile,'.xlsx'),'Sheet','Actions','WriteMode','overwritesheet');
  winopen(strcat(proj.RootFolder,"/Stats/",outfile,'.xlsx'));


  %% clean up
  clear curr* i numPlayer var* sz statsEntries tmp*
  out = [];

end

