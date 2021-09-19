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
figure(101); clf;
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

% format figure
axes = gca;
axes.XAxis.Visible = 'off';
axes.YAxis.Visible = 'off';
axes.InnerPosition = [0.05 0.05 0.9 0.9];
set(gcf,'position',[100,100,900,765])

% clear junk
clear axes pts* points*

%% shot zones
% 3pt center
Zone3C  = [0 500]; 
h = plotShotT(Zone3C,5,12);

% 3pt left corner
Zone3LC  = [-700 1200]; 
h = plotShotC(Zone3LC,5,12);

% 3pt right corner
Zone3RC  = [ 700 1200]; 
h = plotShotC(Zone3RC,5,12);

% 3pt left wing
Zone3LC  = [-500 700]; 
h = plotShotW(Zone3LC,5,12);

% 3pt right wing
Zone3RC  = [500 700]; 
h = plotShotW(Zone3RC,5,12);

% 2pt long center
Zone2LC = [0 720]; 
h = plotShotT(Zone2LC,6,10);

% 2pt long left corner
Zone2LLC  = [-500 1200]; 
h = plotShotC(Zone2LLC,5,12);

% 2pt long right corner
Zone2LRC  = [ 500 1200]; 
h = plotShotC(Zone2LRC,5,12);

% 2pt long left wing
Zone2LLW  = [-400 900]; 
h = plotShotW(Zone2LLW,5,12);

% 2pt long right wing
Zone2LRW  = [ 400 900]; 
h = plotShotW(Zone2LRW,5,12);


% 2pt short center
Zone2SC = [0 950]; 
h = plotShotT(Zone2SC,6,10);

% 2pt short left corner
Zone2SLC  = [-300 1200]; 
h = plotShotC(Zone2SLC,5,12);

% 2pt short right corner
Zone2SRC  = [ 300 1200]; 
h = plotShotC(Zone2SRC,5,12);

% 2pt close center
Zone2CC = [0 1150]; 
h = plotShotT(Zone2CC,6,10);


function h = plotShotT(pos,make,all)
  % plot shot center
  n = make;
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
  n = all-make;
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


function h = plotShotC(pos,make,all)
  % plot shot corner
  n = make;
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
  n = all-make;
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

function h = plotShotW(pos,make,all)
  % plot shot Wing
  n = make;
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
  n = all-make;
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
