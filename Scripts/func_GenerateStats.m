function out = func_GenerateStats(GameActions,outfile)
% generates stats files from actions data
%   filelist: list of game action files
%   outfile : name of output stats file

%% set up stuff
    proj = matlab.project.currentProject;  % get proj info

    numActions = height(GameActions);
    for i = 1:numActions
      if strcmp(GameActions.Teammate1(i),"")
        GameActions.Teammate1(i) = "Nobody";
      end
      if strcmp(GameActions.Teammate2(i),"")
        GameActions.Teammate2(i) = "Nobody";
      end
      if strcmp(GameActions.Teammate3(i),"")
        GameActions.Teammate3(i) = "Nobody";
      end
      if strcmp(GameActions.Teammate4(i),"")
        GameActions.Teammate4(i) = "Nobody";
      end
      if strcmp(GameActions.Teammate5(i),"")
        GameActions.Teammate5(i) = "Nobody";
      end
      if strcmp(GameActions.Opponent1(i),"")
        GameActions.Opponent1(i) = "Nobody";
      end
      if strcmp(GameActions.Opponent2(i),"")
        GameActions.Opponent2(i) = "Nobody";
      end
      if strcmp(GameActions.Opponent3(i),"")
        GameActions.Opponent3(i) = "Nobody";
      end
      if strcmp(GameActions.Opponent4(i),"")
        GameActions.Opponent4(i) = "Nobody";
      end
      if strcmp(GameActions.Opponent5(i),"")
        GameActions.Opponent5(i) = "Nobody";
      end
    end
    
    % player names
    varPlayers = unique([GameActions.Teammate1; GameActions.Teammate2; ...
                         GameActions.Teammate3; GameActions.Teammate4; ...
                         GameActions.Teammate5; ...
                         GameActions.Opponent1; GameActions.Opponent2; ...
                         GameActions.Opponent3; GameActions.Opponent4; ...
                         GameActions.Opponent5;]);
    varPlayers = rmmissing(varPlayers);
    numPlayers = length(varPlayers);

    % stats items & empty stats table
    statsEntries = ["2pt", "3pt", "Layup", "FT", ...
                    "PTS", "+/-", ...
                    "Def Reb", "Off Reb", ...
                    "Assist", "Turnover", ...
                    "Steal", "Block", ...
                    "Threat Pass", "Missed Pass", ...
                    "shot contested", "shot allowed",  ...
                    "Off-Ball Screen", "Screen Assist"];

    sz = [numPlayers length(statsEntries)+1];
    varTypes = ["string",repmat("string",1,4),repmat("double",1,length(statsEntries)-4)];
    statsTable = table('Size',sz,'VariableTypes',varTypes,'VariableNames',["Player" statsEntries]);
    statsTable.Player = varPlayers;

%% initialize player stats
    
    % list of stats items for each player
    StatsEmpty  = struct;
    StatsEmpty.FG2ptO = 0; % 2pt make
    StatsEmpty.FG2ptX = 0; % 2pt miss
    StatsEmpty.FG3ptO = 0; % 3pt make
    StatsEmpty.FG3ptX = 0; % 3pt miss
    StatsEmpty.FGlayO = 0; % layup make
    StatsEmpty.FGlayX = 0; % layup miss
    StatsEmpty.FT1ptO = 0; % FT make 
    StatsEmpty.FT1ptX = 0; % FT miss
    StatsEmpty.PerPTS = 0; % player points
    StatsEmpty.NetPTS = 0; % on-court net +/-
    StatsEmpty.PassRg = 0; % regular pass
    StatsEmpty.PassTh = 0; % threat pass
    StatsEmpty.PassMs = 0; % missed pass
    StatsEmpty.Assist = 0; % assists
    StatsEmpty.Turnvr = 0; % turnover
    StatsEmpty.Contst = 0; % shot contested
    StatsEmpty.Allowd = 0; % shot allowed
    StatsEmpty.Steals = 0; % steals
    StatsEmpty.Blocks = 0; % blocks
    StatsEmpty.RebDef = 0; % defensive rebound
    StatsEmpty.RebOff = 0; % offensive rebound
    StatsEmpty.ScrnOB = 0; % off-ball screen
    StatsEmpty.ScrnAs = 0; % screen assist

    % data struct for each player
    StatsPlayer = struct;
    for i = 1:numPlayers
      currPlayer = varPlayers(i);
      StatsPlayer.(currPlayer) = StatsEmpty;
    end

%% Loop through each action
    
    numActions = height(GameActions);

    for i = 1:numActions
      
      % get current play info
      currPlayer  = GameActions.Player(i);
      currAction  = GameActions.Action(i);
      currDetail1 = GameActions.Detail1(i);
      currDetail2 = GameActions.Detail2(i);
      currNotes   = GameActions.Notes(i);
      currTeam    = GameActions.Team(i);
      currTeammt1 = GameActions.Teammate1(i);
      currTeammt2 = GameActions.Teammate2(i);
      currTeammt3 = GameActions.Teammate3(i);
      currTeammt4 = GameActions.Teammate4(i);
      currTeammt5 = GameActions.Teammate5(i);
      currOppont1 = GameActions.Opponent1(i);
      currOppont2 = GameActions.Opponent2(i);
      currOppont3 = GameActions.Opponent3(i);
      currOppont4 = GameActions.Opponent4(i);
      currOppont5 = GameActions.Opponent5(i);

      % put each action into player's stats
      switch currAction
        case "Pass"
          switch currDetail1
            case "Regular"
              StatsPlayer.(currPlayer).PassRg = StatsPlayer.(currPlayer).PassRg + 1;
            case "Threat"
              StatsPlayer.(currPlayer).PassTh = StatsPlayer.(currPlayer).PassTh + 1;
            case "Missed"
              StatsPlayer.(currPlayer).PassMs = StatsPlayer.(currPlayer).PassMs + 1;          
            case "Assist"
              StatsPlayer.(currPlayer).Assist = StatsPlayer.(currPlayer).Assist + 1;
          end
        case "Make Shot"
          if contains(currDetail1,"Free")
            StatsPlayer.(currPlayer).FT1ptO  = StatsPlayer.(currPlayer).FT1ptO  + 1;
            StatsPlayer.(currPlayer).PerPTS  = StatsPlayer.(currPlayer).PerPTS  + 1;
            StatsPlayer.(currTeammt1).NetPTS = StatsPlayer.(currTeammt1).NetPTS + 1;
            StatsPlayer.(currTeammt2).NetPTS = StatsPlayer.(currTeammt2).NetPTS + 1;
            StatsPlayer.(currTeammt3).NetPTS = StatsPlayer.(currTeammt3).NetPTS + 1;
            StatsPlayer.(currTeammt4).NetPTS = StatsPlayer.(currTeammt4).NetPTS + 1;
            StatsPlayer.(currTeammt5).NetPTS = StatsPlayer.(currTeammt5).NetPTS + 1;
            StatsPlayer.(currOppont1).NetPTS = StatsPlayer.(currOppont1).NetPTS - 1;
            StatsPlayer.(currOppont2).NetPTS = StatsPlayer.(currOppont2).NetPTS - 1;
            StatsPlayer.(currOppont3).NetPTS = StatsPlayer.(currOppont3).NetPTS - 1;
            StatsPlayer.(currOppont4).NetPTS = StatsPlayer.(currOppont4).NetPTS - 1;
            StatsPlayer.(currOppont5).NetPTS = StatsPlayer.(currOppont5).NetPTS - 1;
          end
          if contains(currDetail1,"2") || contains(currDetail1,"Close")
            StatsPlayer.(currPlayer).FG2ptO  = StatsPlayer.(currPlayer).FG2ptO  + 1;
            StatsPlayer.(currPlayer).PerPTS  = StatsPlayer.(currPlayer).PerPTS  + 2;
            StatsPlayer.(currTeammt1).NetPTS = StatsPlayer.(currTeammt1).NetPTS + 2;
            StatsPlayer.(currTeammt2).NetPTS = StatsPlayer.(currTeammt2).NetPTS + 2;
            StatsPlayer.(currTeammt3).NetPTS = StatsPlayer.(currTeammt3).NetPTS + 2;
            StatsPlayer.(currTeammt4).NetPTS = StatsPlayer.(currTeammt4).NetPTS + 2;
            StatsPlayer.(currTeammt5).NetPTS = StatsPlayer.(currTeammt5).NetPTS + 2;
            StatsPlayer.(currOppont1).NetPTS = StatsPlayer.(currOppont1).NetPTS - 2;
            StatsPlayer.(currOppont2).NetPTS = StatsPlayer.(currOppont2).NetPTS - 2;
            StatsPlayer.(currOppont3).NetPTS = StatsPlayer.(currOppont3).NetPTS - 2;
            StatsPlayer.(currOppont4).NetPTS = StatsPlayer.(currOppont4).NetPTS - 2;
            StatsPlayer.(currOppont5).NetPTS = StatsPlayer.(currOppont5).NetPTS - 2;
          end
          if contains(currDetail1,"Layup")
            StatsPlayer.(currPlayer).FGlayO  = StatsPlayer.(currPlayer).FGlayO  + 1;
            StatsPlayer.(currPlayer).PerPTS  = StatsPlayer.(currPlayer).PerPTS  + 2;
            StatsPlayer.(currTeammt1).NetPTS = StatsPlayer.(currTeammt1).NetPTS + 2;
            StatsPlayer.(currTeammt2).NetPTS = StatsPlayer.(currTeammt2).NetPTS + 2;
            StatsPlayer.(currTeammt3).NetPTS = StatsPlayer.(currTeammt3).NetPTS + 2;
            StatsPlayer.(currTeammt4).NetPTS = StatsPlayer.(currTeammt4).NetPTS + 2;
            StatsPlayer.(currTeammt5).NetPTS = StatsPlayer.(currTeammt5).NetPTS + 2;
            StatsPlayer.(currOppont1).NetPTS = StatsPlayer.(currOppont1).NetPTS - 2;
            StatsPlayer.(currOppont2).NetPTS = StatsPlayer.(currOppont2).NetPTS - 2;
            StatsPlayer.(currOppont3).NetPTS = StatsPlayer.(currOppont3).NetPTS - 2;
            StatsPlayer.(currOppont4).NetPTS = StatsPlayer.(currOppont4).NetPTS - 2;
            StatsPlayer.(currOppont5).NetPTS = StatsPlayer.(currOppont5).NetPTS - 2;
          end
          if contains(currDetail1,"3")
            StatsPlayer.(currPlayer).FG3ptO  = StatsPlayer.(currPlayer).FG3ptO  + 1;
            StatsPlayer.(currPlayer).PerPTS  = StatsPlayer.(currPlayer).PerPTS  + 3;
            StatsPlayer.(currTeammt1).NetPTS = StatsPlayer.(currTeammt1).NetPTS + 3;
            StatsPlayer.(currTeammt2).NetPTS = StatsPlayer.(currTeammt2).NetPTS + 3;
            StatsPlayer.(currTeammt3).NetPTS = StatsPlayer.(currTeammt3).NetPTS + 3;
            StatsPlayer.(currTeammt4).NetPTS = StatsPlayer.(currTeammt4).NetPTS + 3;
            StatsPlayer.(currTeammt5).NetPTS = StatsPlayer.(currTeammt5).NetPTS + 3;
            StatsPlayer.(currOppont1).NetPTS = StatsPlayer.(currOppont1).NetPTS - 3;
            StatsPlayer.(currOppont2).NetPTS = StatsPlayer.(currOppont2).NetPTS - 3;
            StatsPlayer.(currOppont3).NetPTS = StatsPlayer.(currOppont3).NetPTS - 3;
            StatsPlayer.(currOppont4).NetPTS = StatsPlayer.(currOppont4).NetPTS - 3;
            StatsPlayer.(currOppont5).NetPTS = StatsPlayer.(currOppont5).NetPTS - 3;
          end      
        case "Miss Shot"
          if contains(currDetail1,"Free")
            StatsPlayer.(currPlayer).FT1ptX  = StatsPlayer.(currPlayer).FT1ptX  + 1;
          end
          if contains(currDetail1,"2") || contains(currDetail1,"Close")
            StatsPlayer.(currPlayer).FG2ptX  = StatsPlayer.(currPlayer).FG2ptX  + 1;
          end
          if contains(currDetail1,"Layup")
            StatsPlayer.(currPlayer).FGlayX  = StatsPlayer.(currPlayer).FGlayX  + 1;
          end
          if contains(currDetail1,"3")
            StatsPlayer.(currPlayer).FG3ptX  = StatsPlayer.(currPlayer).FG3ptX  + 1;
          end
        case "Rebound"
          if contains(currDetail1,"Defen")
            StatsPlayer.(currPlayer).RebDef  = StatsPlayer.(currPlayer).RebDef  + 1;
          end
          if contains(currDetail1,"Offen")
            StatsPlayer.(currPlayer).RebOff  = StatsPlayer.(currPlayer).RebOff  + 1;
          end 
        case "Turnover"
            StatsPlayer.(currPlayer).Turnvr  = StatsPlayer.(currPlayer).Turnvr  + 1;
        case "Defense"
          if contains(currDetail1,"Steal")
            StatsPlayer.(currPlayer).Steals  = StatsPlayer.(currPlayer).Steals  + 1;
          end
          if contains(currDetail1,"Block")
            StatsPlayer.(currPlayer).Blocks  = StatsPlayer.(currPlayer).Blocks  + 1;
          end
          if contains(currDetail1,"Contest")
            StatsPlayer.(currPlayer).Contst  = StatsPlayer.(currPlayer).Contst  + 1;
          end
          if contains(currDetail1,"Allow")
            StatsPlayer.(currPlayer).Allowd  = StatsPlayer.(currPlayer).Allowd  + 1;
          end
        case "Other"
          if contains(currDetail1,"Off-ball screen")
            StatsPlayer.(currPlayer).ScrnOB  = StatsPlayer.(currPlayer).ScrnOB  + 1;
          end
          if contains(currDetail1,"Screen assist")
            StatsPlayer.(currPlayer).ScrnAs  = StatsPlayer.(currPlayer).ScrnAs  + 1;
          end
      end
      clear curr*
    end

%% put personal stats into table

    for i = 1:numPlayers
      currPlayer = statsTable.Player(i);
      currEntry  = statsTable(statsTable.Player == currPlayer,:);
      j=1;
      j=j+1; currEntry(1,j)  = { strcat(num2str(StatsPlayer.(currPlayer).FG2ptO)," / ", ...
                                        num2str(StatsPlayer.(currPlayer).FG2ptO+StatsPlayer.(currPlayer).FG2ptX)) }; 
      j=j+1; currEntry(1,j)  = { strcat(num2str(StatsPlayer.(currPlayer).FG3ptO)," / ", ...
                                        num2str(StatsPlayer.(currPlayer).FG3ptO+StatsPlayer.(currPlayer).FG3ptX)) }; 
      j=j+1; currEntry(1,j)  = { strcat(num2str(StatsPlayer.(currPlayer).FGlayO)," / ", ...
                                        num2str(StatsPlayer.(currPlayer).FGlayO+StatsPlayer.(currPlayer).FGlayX)) }; 
      j=j+1; currEntry(1,j)  = { strcat(num2str(StatsPlayer.(currPlayer).FT1ptO)," / ", ...
                                        num2str(StatsPlayer.(currPlayer).FT1ptO+StatsPlayer.(currPlayer).FT1ptX)) };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).PerPTS };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).NetPTS };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).RebDef };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).RebOff };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).Assist };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).Turnvr };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).Steals };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).Blocks };
      % j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).PassRg };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).PassTh };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).PassMs };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).Contst };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).Allowd };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).ScrnOB };
      j=j+1; currEntry(1,j)  = { StatsPlayer.(currPlayer).ScrnAs };
      statsTable(i,:) = currEntry;
    end

%% Save stats Table

    % as a .mat file
    save(strcat(proj.RootFolder,"/Stats/",outfile),"statsTable")

    % stats as excel file
    writetable(statsTable,strcat(proj.RootFolder,"/Stats/",outfile,'.xlsx'),'Sheet','Stats','WriteMode','overwritesheet');

    % actions in excel file
    writetable(GameActions,strcat(proj.RootFolder,"/Stats/",outfile,'.xlsx'),'Sheet','Actions','WriteMode','overwritesheet');
    winopen(strcat(proj.RootFolder,"/Stats/",outfile,'.xlsx'));

    % clean up
    % clear curr* i j num* var* sz statsEntries tmp* StatsPlayer StatsEmpty

    % write StatsPlayer to workspace
    out = StatsPlayer;

end

