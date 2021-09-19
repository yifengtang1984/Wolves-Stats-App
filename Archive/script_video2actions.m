%% Set up stuff

clear;

newTable = 1;    % create new table?  
% 0: no, load existing one
% 1: yes, create an empty one
filename = "AppTestTable.mat";  % data file name

%% Load or create game action table

if newTable
  % generate a new table
  init_GameActions;
else
  % load existing table, to continue working
  load(filename);
end

%% Open data entry App

% openmlapp('POC_DataEntry');  % edit the App
% POC_DataEntry;  % run the App

% openmlapp('DataEntryV1');  % edit the App
% DataEntryV1;  % run the App

% openmlapp('DataEntryV2');  % edit the App
% DataEntryV2;  % run the App

% openmlapp('DataEntryV3');  % edit the App
% DataEntryV3;  % run the App

% openmlapp('DataEntryV4');  % edit the App
DataEntryV4;  % run the App

%% clean up
clear newTable filename