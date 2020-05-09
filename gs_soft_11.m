%% GSC Software

%% Setup for presentation before "Initiate"

% Text overlay
I = imread('white.jpg');
position = [0 0; 0 60; 0 120; 0 180; 0 240; 0 300];
x = imcrop(I, [100 100 300 360]);
text = cell(6, 1);
text{1} = 'Team Soton';
text{2} = 'Mission Time: ';
text{3} = 'Status: ';
text{4} = 'Packet Count: ';
text{5} = 'GPS Time: ';
text{6} = 'GPS Satellites: ';

overlay = insertText(x, position, text, 'Fontsize',20, 'BoxColor',...
    'white', 'TextColor', 'black');

Logo = imread(fullfile('logos','Logo.jpg'));

%% Plots


figure(1), clf

% Size and positioning
set(gcf,'WindowStyle','Normal','Units','Normalized',...
    'Position',[0.025, 0.05, 0.95, 0.85],'Color','w')

pax = polaraxes;
pax.RColor = 'w';
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
subplot(4,4,7,pax), title('Camera Direction')

% Environmental
subplot(4,4,1), title('Altitude'), xlabel('Time [s]'), hold on
ylabel('Altitude [m]') 
subplot(4,4,2), title('Pressure'), xlabel('Time [s]'), hold on
ylabel('Pressure [Pa]')
subplot(4,4,3), title('Temperature'), xlabel('Time [s]'), hold on 
ylabel('Temperature [C^o]')

% Health
subplot(4,4,5), title('Battery Voltage'), xlabel('Time [s]'), hold on
ylabel('Voltage [V]')
subplot(4,4,6), title('Gyro Spin Rate'), xlabel('Time [s]'), hold on
ylabel('Spin Rate [rpm]')

% Attitude
subplot(4,4,9), title('Pitch'), xlabel('Time [s]'), hold on 
ylabel('Degrees')
subplot(4,4,13), title('Roll'), xlabel('Time [s]'), hold on
ylabel('Degrees')

% Position
subplot(4,4,[10 15]), plot3(0,0,0), title('Position'), hold on
xlabel('Longitude'), ylabel('Latitude'), zlabel('Altitude')
fill3([0 1000 1000 0],[0 0 1000 1000],[0 0 0 0], [1 1 0])

% overlay
subplot(4,4,[4,8]),   imshow(overlay)
subplot(4,4,[12 16]), imshow(Logo)

%% controls; only "Initiate" is assigned a function here

% Telecommand
pos         = uipanel('Position', [0.75 0.42 0.16 0.15]);
pos_pos     = get(pos,'Position');
telebutton1 = uicontrol(pos, 'Style', 'pushbutton', 'String', 'Calibrate', ...
    'Units', 'Normalized', 'Position',[0.325 0.1 0.35 0.3],...
    'BackgroundColor', 'c'); 

% Initiation
telebutton2 = uicontrol(pos, 'Style', 'pushbutton', 'String', 'Initiate', ...
     'Units', 'Normalized', 'Position',[0.1 0.6 0.35 .3],...
     'BackgroundColor', 'g', 'Callback', @initiate); 

% Termination
telebutton3 = uicontrol(pos, 'Style', 'pushbutton', 'String', 'Terminate', ...
    'Units', 'Normalized', 'Position',[0.55 0.6 0.35 0.3],...
    'BackgroundColor', 'r'); 

%% Check if any serials ports are open
delete(instrfind);

%%

function initiate(src, event)

%% clears plots when you reinitiate

clf

%% Setup, replots after clear

% Text overlay
I = imread('white.jpg');
position = [0 0; 0 60; 0 120; 0 180; 0 240; 0 300];
x = imcrop(I, [100 100 300 360]);
text = cell(6, 1);
text{1} = 'Team Soton';
text{2} = 'Mission Time: ';
text{3} = 'Status: ';
text{4} = 'Packet Count: ';
text{5} = 'GPS Time: ';
text{6} = 'GPS Satellites: ';

overlay = insertText(x, position, text, 'Fontsize',20, 'BoxColor',...
    'white', 'TextColor', 'black');

Logo = imread(fullfile('logos','Logo.jpg'));

%% Plots

pax = polaraxes;
pax.RColor = 'w';
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
subplot(4,4,7,pax), title('Camera Direction')

% Environmental
subplot(4,4,1), title('Altitude'), xlabel('Time [s]'), hold on
ylabel('Altitude [m]') 
subplot(4,4,2), title('Pressure'), xlabel('Time [s]'), hold on
ylabel('Pressure [Pa]')
subplot(4,4,3), title('Temperature'), xlabel('Time [s]'), hold on 
ylabel('Temperature [C^o]')

% Health
subplot(4,4,5), title('Battery Voltage'), xlabel('Time [s]'), hold on
ylabel('Voltage [V]')
subplot(4,4,6), title('Gyro Spin Rate'), xlabel('Time [s]'), hold on
ylabel('Spin Rate [rpm]')

% Attitude
subplot(4,4,9), title('Pitch'), xlabel('Time [s]'), hold on 
ylabel('Degrees')
subplot(4,4,13), title('Roll'), xlabel('Time [s]'), hold on
ylabel('Degrees')

% Position
gps_pos = subplot(4,4,[10 15]);
plot3(0,0,0), title('Position'), hold on
xlabel('Longitude'), ylabel('Latitude'), zlabel('Altitude')
fill3([0 1000 1000 0],[0 0 1000 1000],[0 0 0 0], [1 1 0])
rotate3d(gps_pos, 'on') % up to you if you want to keep this

% overlay
subplot(4,4,[4,8]),   imshow(overlay)
subplot(4,4,[12 16]), imshow(Logo)

%% controls, all buttons have functions here

% Telecommand
pos         = uipanel('Position', [0.75 0.42 0.16 0.15]);
telebutton1 = uicontrol(pos, 'Style', 'pushbutton', 'String', 'Calibrate', ...
    'Units', 'Normalized', 'Position',[0.325 0.1 0.35 0.3],...
    'BackgroundColor', 'c', 'Callback', @calib); 

% Initiation
telebutton2 = uicontrol(pos, 'Style', 'pushbutton', 'String', 'Initiate', ...
     'Units', 'Normalized', 'Position',[0.1 0.6 0.35 .3],...
     'BackgroundColor', 'g', 'Callback', @initiate); 

% Termination
telebutton3 = uicontrol(pos, 'Style', 'pushbutton', 'String', 'Terminate', ...
    'Units', 'Normalized', 'Position',[0.55 0.6 0.35 0.3],...
    'BackgroundColor', 'r', 'Callback', @terminate); 


%% Live Plotting

    cnt=1;           % to keep track of readouts
    data_plot  = []; % matrix that contains all data points collected after "Initiate"
    
    % new file for each initiation
    BaseName='PayloadData_';
    k = datetime('now');
    k2 = datestr(k);
    k3 = strrep(k2,' ','_');
    k4 = strrep(k3,':','.');

    % to enable termination using a gui control
    term0 = {'111'};
    termText0  = cell2mat(term0);
    fid_in = fopen('terminator.csv', 'w');
    fprintf(fid_in,'%s\n', termText0);
    fclose(fid_in);
 
    % Setting up serial port
    serObj = serial('/dev/tty.usbserial-DN041LTF', 'BaudRate', 9600, ...
            'TimeOut', 10, 'Terminator', 'LF');   % make sure the port is correct
%   serObj = serial('COM4', 'BaudRate', 9600, ...
%           'TimeOut', 10, 'Terminator', 59);     % for Windows.

    fopen(serObj); % DON'T FORGET TO fclose(serObj) IN THE END, OR YOUR PC WILL GO KAPUT, eventually
                   % "terminate" achieves this  
    
    while 1
        % checks the external doc for the terminator value
        fid_check = fopen('terminator.csv', 'r');
        term_val = fgetl(fid_check);
        fclose(fid_check);
        
        FileName=[BaseName,k4,'.csv'];
        
        if term_val == '111' % this will become false when button is pressed ('222')
            
  
                         % can add a conditional to reduce data on plots,
                         % e.g. plot if floor(cnt/3) == ceil(cnt/3) for
                         %      every 3rd point
                         

            % read out the data
            data = fscanf(serObj);
            
            % prepare for processing
            check_data = strsplit(data,',');
            data_plot(cnt,:) = str2double(check_data); % to plot lines
            
            % can probably delete some of these
            t   = check_data{2};
            p   = check_data{3};
            cam = check_data{17};
            
            
            % only appends headers before the first iteration
            if cnt == 1
            
                % csv doc headers
                headers = {'Team ID','Mission Time [s]', 'Packet Count', 'Altitude [m]',  ...
                    'Pressure [Pa]', 'Temperature [C^o]', 'Voltage [V]', 'GPS Time [s]',  ...
                    'GPS Latitude [^o]', 'GPS Longitude [^o]', 'GPS Altitude [m]', 'GPS Satellites', ...
                    'Pitch [^o]', 'Roll [^o]', 'Spin Rate [rpm]', 'Software Status', 'Camera Direction [^o]'};

                % add commas and convert to text
                headersComma = [headers;repmat({','},1,numel(headers))];
                headersComma = headersComma(:)';
                headersText  = cell2mat(headersComma);

                % append header to csv
                fid = fopen(FileName, 'w');
                fprintf(fid,'%s\n', headersText);
                fclose(fid);
                
                % initial values
                t_init = str2double(t);
                p_init = str2double(p);
            
            end    
                
            % append telemetry data to the CSV      
            fid_tele = fopen(FileName, 'a');
            fprintf(fid_tele,'%s', data);
            fclose(fid_tele); 


            % skips first count on plots for my personal convenience
            if cnt > 1
            
                % changing color of the plotted line for different phases of the operation
                % pre- and post-launch color
                col = 'k';
                
                % lift-off (>2 to ignore the noise)
                if data_plot(cnt,4) - data_plot(cnt-1,4) > 2
                    col = 'r';
                end
                
                % payload deployment (auto-gyro rotation)
                if data_plot(cnt,15) > 0 ...
                        && ... 
                   data_plot(cnt-1,4) - data_plot(cnt,4) > 1
               
                    col = 'c';
                end
                
                % parachute deployment (stationary gyro and decreasing altitude)
                if data_plot(cnt,15) == 0 ...
                        && ...
                   data_plot(cnt-1,4) - data_plot(cnt,4) > 2                   
                    col = 'g';
                end

                
                % plotting the data
                
                % Altitude
                subplot(4,4,1)
                plot(data_plot(cnt-1:cnt,2),data_plot(cnt-1:cnt,4),col)
                
                % Pressure
                subplot(4,4,2)
                plot(data_plot(cnt-1:cnt,2),data_plot(cnt-1:cnt,5),col)
                
                % Temperature
                subplot(4,4,3)
                plot(data_plot(cnt-1:cnt,2),data_plot(cnt-1:cnt,6),col)
                
                % Battery Voltage
                subplot(4,4,5)
                plot(data_plot(cnt-1:cnt,2),data_plot(cnt-1:cnt,7),col)
                
                % Gyro Spin Rate
                subplot(4,4,6)
                plot(data_plot(cnt-1:cnt,2),data_plot(cnt-1:cnt,14),col)
                
                % Camera
                subplot(4,4,7,pax)
                polarplot(str2double(cam)*[1; 1] * pi/180, [0;1])
                pax.RColor = 'w';
                pax.ThetaDir = 'clockwise';
                pax.ThetaZeroLocation = 'top';
                subplot(4,4,7,pax), title('Camera Direction')
                
                % Pitch
                subplot(4,4,9)
                plot(data_plot(cnt-1:cnt,2),data_plot(cnt-1:cnt,13),col)
                
                % Roll
                subplot(4,4,13)
                plot(data_plot(cnt-1:cnt,2),data_plot(cnt-1:cnt,14),col)
                
                % Position, still has rotate3d turned on
                subplot(4,4,[10 15])
                plot3(data_plot(cnt-1:cnt,9),data_plot(cnt-1:cnt,10),data_plot(cnt-1:cnt,11),col)
                
                % updating the data (overlay)
                I = imread('white.jpg');
                x = imcrop(I, [100 100 300 360]);
                position = [0 0; 0 60; 0 120; 0 180; 0 240; 0 300];
                text = cell(6, 1);
                
                % time and packet count since the beginning of transmission
                % NOT TESTED
                t_mis = num2str(str2double(t) - t_init);
                p_mis = num2str(str2double(p) - p_init);
                
                text{1} = 'Team Soton';
                text{2} = ['Mission Time: ' t_mis];
                text{3} = ['Status: ' check_data{16}];
                text{4} = ['Packet Count: ' p_mis];
                text{5} = ['GPS Time: ' check_data{8}];
                text{6} = ['GPS Satellites: ' check_data{12}];
                
                overlay = insertText(x, position, text, 'Fontsize', 20, 'BoxColor', 'white', ...
                    'TextColor', 'black');
                
                subplot(4,4,[4 8]), imshow(overlay)
                

                % plots data points at key events on both 3d plot and altitude plot
                % problem here is that you only want one point per event
                if cnt > 2

                    if data_plot(cnt-1,4) - data_plot(cnt,4) > 1  ...           % Parachute deployment, uses peak altitude
                            && ...                                              % NOT SURE ABOUT THIS ONE, can use rapid drop in pressure (lowest at peak), e.g.
                       data_plot(cnt-1,4) > data_plot(cnt-2,4) ...              % if data_plot(cnt,5) - data_plot(cnt-1,5) > 500 && data_plot(cnt-2,5) - data_plot(cnt-1,5) > 500
                            || ...                                              
                       data_plot(cnt,15) > 0 ...
                            && ...                                              % Deployment of the payload, uses gyro rotation
                       data_plot(cnt-1,15) == 0 ...
                            || ...
                       abs(data_plot(cnt-1,4) - data_plot(cnt-2,4)) < 1 ...
                            && ...                                              % Lift-off
                       data_plot(cnt,4) - data_plot(cnt-1,4) > 1 ...
                            || ...
                       abs(data_plot(cnt,4) - data_plot(cnt-1,4)) < 1 ...
                            && ...                                              % Landing
                       data_plot(cnt-2,4) - data_plot(cnt-1,4) > 1         
                        
                        subplot(4,4,1)
                        plot(data_plot(cnt-1,2), data_plot(cnt-1,4), 'ro')
                        
                        subplot(4,4,[10 15])
                        plot3(data_plot(cnt-1,9),...
                            data_plot(cnt-1,10),...
                            data_plot(cnt-1,11), 'ro')
                    end

                end
            end
        else
            break
        end
                % preparing for next iteration
                pause(1);
                cnt=cnt+1;
%                 cnt % for debugging purposes
    end
    
end

%% Telecommand
                                
function calib(src, event)
    
    % have to terminate due to serial read being difficult
    terminate();
    
    % send the telecommand
    serObj = serial('/dev/tty.usbserial-DN041LTF', 'BaudRate', 9600, ...
        'TimeOut', 10, 'Terminator', 'LF');
    fopen(serObj);
    fwrite(serObj, '3967');   % to send data via serial
    
    % close the serial port
    serObj = serial('/dev/tty.usbserial-DN041LTF', 'BaudRate', 9600, ...
        'TimeOut', 10, 'Terminator', 'LF');
    fclose(serObj);
    delete(instrfind);
    
    % starts plotting again
    initiate();

end

%% finish
function terminate(src, event)
    
% to protect against accidental missclicks
txt = questdlg('Are you sure? The plots will be reset and new csv doc will be initiated.');

    if txt == 'Yes'

        term = {'222'};
        termText  = cell2mat(term);

        % append to csv
        fid = fopen('terminator.csv', 'w');
        fprintf(fid,'%s\n', termText);
        fclose(fid);

        % close the serial port
        serObj = serial('/dev/tty.usbserial-DN041LTF', 'BaudRate', 9600, ...
            'TimeOut', 10, 'Terminator', 'LF');
        fclose(serObj);
        delete(instrfind);

        % save the figure (both as static and as .fig)
        % generate new names
        k = datetime('now');
        k2 = datestr(k);
        k3 = strrep(k2,' ','_');
        k4 = strrep(k3,':','.');

        savefig(['plot' k4 '.fig'])
        saveas(gcf, ['plot_' k4 '.bmp'])

    end
end
