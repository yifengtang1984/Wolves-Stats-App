function out = func_GenerateShotMap(GameActions,Players,outfile)
% generates stats files from actions data
%   filelist: list of game action files
%   outfile : name of output stats file

  proj = matlab.project.currentProject;  % get proj info

  %% assign Players
  allActions = GameActions;
  n = length(Players);

  %% Gather stats and plot
  
  for i = 1:n

    Player = Players{i};
    if Player == "All"
      GameActions = allActions(allActions.Player~="Nobody",:);
    else
      GameActions = allActions(allActions.Player==Player,:);
    end
    
    % count shots
    Make3T = sum(GameActions.Detail1 == "3 Top" & GameActions.Action == "Make Shot");
    Miss3T = sum(GameActions.Detail1 == "3 Top" & GameActions.Action == "Miss Shot");
    Make3LW = sum(GameActions.Detail1 == "3 Left Wing"    & GameActions.Action == "Make Shot");
    Miss3LW = sum(GameActions.Detail1 == "3 Left Wing"    & GameActions.Action == "Miss Shot");
    Make3LC = sum(GameActions.Detail1 == "3 Left Corner"  & GameActions.Action == "Make Shot");
    Miss3LC = sum(GameActions.Detail1 == "3 Left Corner"  & GameActions.Action == "Miss Shot");
    Make3RW = sum(GameActions.Detail1 == "3 Right Wing"   & GameActions.Action == "Make Shot");
    Miss3RW = sum(GameActions.Detail1 == "3 Right Wing"   & GameActions.Action == "Miss Shot");
    Make3RC = sum(GameActions.Detail1 == "3 Right Corner" & GameActions.Action == "Make Shot");
    Miss3RC = sum(GameActions.Detail1 == "3 Right Corner" & GameActions.Action == "Miss Shot");
    Make2LE = sum(GameActions.Detail1 == "2 Left Elbow"   & GameActions.Action == "Make Shot");
    Miss2LE = sum(GameActions.Detail1 == "2 Left Elbow"   & GameActions.Action == "Miss Shot");
    Make2LC = sum(GameActions.Detail1 == "2 Left Corner"  & GameActions.Action == "Make Shot");
    Miss2LC = sum(GameActions.Detail1 == "2 Left Corner"  & GameActions.Action == "Miss Shot");
    Make2RE = sum(GameActions.Detail1 == "2 Right Elbow"  & GameActions.Action == "Make Shot");
    Miss2RE = sum(GameActions.Detail1 == "2 Right Elbow"  & GameActions.Action == "Miss Shot");
    Make2RC = sum(GameActions.Detail1 == "2 Right Corner" & GameActions.Action == "Make Shot");
    Miss2RC = sum(GameActions.Detail1 == "2 Right Corner" & GameActions.Action == "Miss Shot");
    Make2LU = sum((GameActions.Detail1=="Close"|GameActions.Detail1=="Layup") & GameActions.Action == "Make Shot");
    Miss2LU = sum((GameActions.Detail1=="Close"|GameActions.Detail1=="Layup") & GameActions.Action == "Miss Shot");

    % draw court & shot zones
    figure(100+i); clf;

    % court
    h = drawCourt(100+i);
    text(700,100,Player,'Interpreter','none','FontSize',20,'HorizontalAlignment','right')

    % 3pt top
    Zone3T  = [0 500]; 
    h = plotShotT(Zone3T,Make3T,Miss3T);

    % 3pt left wing
    Zone3LW  = [-500 700]; 
    h = plotShotW(Zone3LW,Make3LW,Miss3LW);

    % 3pt left corner
    Zone3LC  = [-700 1200]; 
    h = plotShotC(Zone3LC,Make3LC,Miss3LC);

    % 3pt right wing
    Zone3RW  = [500 700]; 
    h = plotShotW(Zone3RW,Make3RW,Miss3RW);

    % 3pt right corner
    Zone3RC  = [ 700 1200]; 
    h = plotShotC(Zone3RC,Make3RC,Miss3RC);

    % 2pt left elbow
    Zone2LE = [-250 800]; 
    h = plotShotT(Zone2LE,Make2LE,Miss2LE);

    % 2pt left corner
    Zone2LC  = [-450 1200]; 
    h = plotShotC(Zone2LC,Make2LC,Miss2LC);

    % 2pt right elbow
    Zone2RE = [250 800]; 
    h = plotShotT(Zone2RE,Make2RE,Miss2RE);

    % 2pt right corner
    Zone2RC  = [450 1200]; 
    h = plotShotC(Zone2RC,Make2RC,Miss2RC);

    % 2pt close center
    Zone2LU = [0 1150]; 
    h = plotShotT(Zone2LU,Make2LU,Miss2LU);

    %% save file
    saveas(gcf,strcat(proj.RootFolder,"/Stats/",outfile,"Shots_",Player),'png')
    
  end
  
end

function h = drawCourt(figNum)

  % Draw a basketball court
  % [0 0] is at mid court

  % define sidelines
  pointsSidelines = [0 0; 750 0; 750 1400; -750 1400; -750 0; 0 0];

  % mid-court circle
  pointsMidCircle = [cosd([1:180]') sind([1:180]')]*180;

  % lane circle
  ptsCircle = 1400-579;
  pointsKeyCircle1 = [cosd([001:180]') sind([001:180]')]*180;
  pointsKeyCircle2 = [cosd([180:360]') sind([180:360]')]*180;
  pointsKeyCircle1(:,2) = pointsKeyCircle1(:,2) + ptsCircle;
  pointsKeyCircle2(:,2) = pointsKeyCircle2(:,2) + ptsCircle;

  % basket
  ptsBasket =1400-158;
  pointsBasket = [cosd([1:360]') sind([1:360]')]*23;
  pointsBasket(:,2) = pointsBasket(:,2) + ptsBasket;
  ptsBoard =1400-120;
  pointsBoard = [0 -(38-23); 0 0; -90 0; 90 0;];
  pointsBoard(:,2) = pointsBoard(:,2) + ptsBoard;

  % 3pt line
  points3pline = [cosd([180:360]') sind([180:360]')]*640;
  points3pline(:,2) = points3pline(:,2) + ptsBasket;
  points3pline = [-640 1400; points3pline; 640 1400];

  % lane
  pointsLane1 = [220 1400; -220 1400; -220 1400-579; 220 1400-579; 220 1400;];
  pointsLane2 = [180 1400; -180 1400; -180 1400-579; 180 1400-579; 180 1400;];

  % lane marks
  pointsLeft  = [-220 0; -250 0];
  pointsRight = [ 220 0;  250 0];
  pointsShift = [ 0 100;  0 100];
  pointsCenter = [0 1400-158; 0 1400-158];
  pointsMark1L = pointsCenter + pointsLeft - [0 80; 0 80];
  pointsMark2L = pointsMark1L - pointsShift*1;
  pointsMark3L = pointsMark1L - pointsShift*2;
  pointsMark4L = pointsMark1L - pointsShift*3;
  pointsMark0L = pointsMark1L + pointsShift*1/2;
  pointsMark1L = [pointsMark1L; flip(pointsMark0L)];
  pointsMark1R = pointsCenter + pointsRight - [0 80; 0 80];
  pointsMark2R = pointsMark1R - pointsShift*1;
  pointsMark3R = pointsMark1R - pointsShift*2;
  pointsMark4R = pointsMark1R - pointsShift*3;
  pointsMark0R = pointsMark1R + pointsShift*1/2;
  pointsMark1R = [pointsMark1R; flip(pointsMark0R)];

  % plot the court
  figure(figNum);
  hold on
  box off
  plot(pointsSidelines(:,1),pointsSidelines(:,2),'k-','LineWidth',3)
  plot(pointsMidCircle(:,1),pointsMidCircle(:,2),'k-','LineWidth',3)
  plot(pointsKeyCircle1(:,1),pointsKeyCircle1(:,2),'k--','LineWidth',2)
  plot(pointsKeyCircle2(:,1),pointsKeyCircle2(:,2),'k-','LineWidth',2)
  plot(pointsBasket(:,1),pointsBasket(:,2),'k-','LineWidth',2)
  plot(pointsBoard(:,1),pointsBoard(:,2),'k-','LineWidth',4)
  plot(points3pline(:,1),points3pline(:,2),'k-','LineWidth',2)
  plot(pointsLane1(:,1),pointsLane1(:,2),'k-','LineWidth',2)
  plot(pointsLane2(:,1),pointsLane2(:,2),'k-','LineWidth',2)
  plot(pointsMark1L(:,1),pointsMark1L(:,2),'k-','LineWidth',1)
  plot(pointsMark2L(:,1),pointsMark2L(:,2),'k-','LineWidth',1)
  plot(pointsMark3L(:,1),pointsMark3L(:,2),'k-','LineWidth',1)
  plot(pointsMark4L(:,1),pointsMark4L(:,2),'k-','LineWidth',1)
  plot(pointsMark1R(:,1),pointsMark1R(:,2),'k-','LineWidth',1)
  plot(pointsMark2R(:,1),pointsMark2R(:,2),'k-','LineWidth',1)
  plot(pointsMark3R(:,1),pointsMark3R(:,2),'k-','LineWidth',1)
  plot(pointsMark4R(:,1),pointsMark4R(:,2),'k-','LineWidth',1)
  hold off

  % format figure
  axes = gca;
  axes.XAxis.Visible = 'off';
  axes.YAxis.Visible = 'off';
  axes.InnerPosition = [0.05 0.05 0.9 0.9];
  h = gcf;
  set(gcf,'position',[100,100,900,765])

  % clear junk
  clear axes pts* points*

end

function h = plotShotT(pos,make,miss)
  % plot shot center
  n = make;
  h = gcf;
  for i = 1:n
    x = pos(1)+(-(n+1)/2+i)*30;
    y = pos(2)+20;
    h = text(x,y,'O');
    h.HorizontalAlignment = 'center';
    h.FontSize = 14;
    h.FontName = 'Courier New';
    h.FontWeight = 'bold';
    h.Color = 'r';
  end
  n = miss;
  for i = 1:n
    x = pos(1)+(-(n+1)/2+i)*30;
    y = pos(2)-20;
    h = text(x,y,'X');
    h.HorizontalAlignment = 'center';
    h.FontSize = 14;
    h.FontName = 'Courier New';
    h.FontWeight = 'bold';
    h.Color = 'r';
  end
end

function h = plotShotC(pos,make,miss)
  % plot shot corner
  n = make;
  h = gcf;
  for i = 1:n
    x = pos(1)-sign(pos(1))*20;
    y = pos(2)+(-(n+1)/2+i)*30;
    h = text(x,y,'O');
    h.HorizontalAlignment = 'center';
    h.FontSize = 14;
    h.FontName = 'Courier New';
    h.FontWeight = 'bold';
    h.Color = 'r';
  end
  n = miss;
  for i = 1:n
    x = pos(1)+sign(pos(1))*20;
    y = pos(2)+(-(n+1)/2+i)*30;
    h = text(x,y,'X');
    h.HorizontalAlignment = 'center';
    h.FontSize = 14;
    h.FontName = 'Courier New';
    h.FontWeight = 'bold';
    h.Color = 'r';
  end
end

function h = plotShotW(pos,make,miss)
  % plot shot Wing
  n = make;
  h = gcf;
  for i = 1:n
    x = pos(1)+sign(pos(1))*(-(n+1)/2+i)*22-sign(pos(1))*15;
    y = pos(2)+(-(n+1)/2+i)*22+15;
    h = text(x,y,'O');
    h.HorizontalAlignment = 'center';
    h.FontSize = 14;
    h.FontName = 'Courier New';
    h.FontWeight = 'bold';
    h.Color = 'r';
  end
  n = miss;
  for i = 1:n
    x = pos(1)+sign(pos(1))*(-(n+1)/2+i)*22+sign(pos(1))*15;
    y = pos(2)+(-(n+1)/2+i)*22-15;
    h = text(x,y,'X');
    h.HorizontalAlignment = 'center';
    h.FontSize = 14;
    h.FontName = 'Courier New';
    h.FontWeight = 'bold';
    h.Color = 'r';
  end
end
