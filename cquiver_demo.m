%CQUIVER_DEMO Demonstration of the cquiver class and its color modes
%
% Just start this script to get an idea of the CQUIVER features and it's
% performance. Read it to understand how to use the CQUIVER class. 

% -------------------------------------------------------------------------
% This simply creates some demo vector field
[dXX, dYY] = meshgrid(-4.1:0.2:4.1, -4.1:0.2:4.1);
dAlpha = -2;
dNorm = 1 - (1./(sqrt(dXX.^2 + dYY.^2)));
dU =   dYY - dAlpha.*dXX.*dNorm;
dV = - dXX - dAlpha.*dYY.*dNorm;

% -------------------------------------------------------------------------
% Create the initial cquiver plot (magnitude mode)
hQ = plotting.cquiver(dXX, dYY, dU, dV, 'mag', 1, 'LineWidth', 0.5);

% Change some values of the parent figure and axes
set(gcf, 'Name', 'Magnitude Mode', 'NumberTitle', 'off', 'Position', [100 100 600 600], 'MenuBar', 'none');
drawnow expose % Needed to freeze the axes' XLim and YLim correctly
hA = gca;
set(hA, 'XLimMode', 'manual', 'YLimMode', 'manual', 'Color', [0.2 0.2 0.2], 'Position', [0 0 1 1]);
% -------------------------------------------------------------------------

% First loop: Demonstrate the magnitude coloring mode
tic
iCnt = 0;
for dAlpha = -30:0.3:30;
%     dU =   dYY - dAlpha.*dXX.*dNorm;
%     dV = - dXX - dAlpha.*dYY.*dNorm;
    dU = cos(dXX + 0.2*dAlpha).*dYY;
    dV = sin(dXX + 0.2*dAlpha).*dYY;
    
    % Update the vector data
    hQ.UData = dU;
    hQ.VData = dV;
    
    drawnow expose
    
    % Just for measuring fps
    iCnt = iCnt + 1;
    if iCnt == 10
        iCnt = 0;
        dT = toc; tic
        set(gcf, 'Name', sprintf('Magnitude Mode | %f fps', 10/dT));
    end
end

% Second loop: Demonstrate the angle coloring mode
hQ.CDataMode = 'angle'; % Activates the angular mode
set(gcf, 'Name', 'Angle Mode');

iCnt = 0;
for dAlpha = 10:-0.1:-10;
%     dU =   dYY - dAlpha.*dXX.*dNorm;
%     dV = - dXX - dAlpha.*dYY.*dNorm;
    dU = cos(dXX + 0.2*dAlpha).*dYY;
    dV = sin(dXX + 0.2*dAlpha).*dYY;
    
    % Update the vector data
    hQ.UData = dU;
    hQ.VData = dV;
    
    drawnow expose
    
        % Just for measuring fps
    iCnt = iCnt + 1;
    if iCnt == 10
        iCnt = 0;
        dT = toc; tic
        set(gcf, 'Name', sprintf('Angle Mode | %f fps', 10/dT));
    end
end

% Third loop: Demonstrate the direct (manual) coloring mode
dH = 0.55 + 0.05*rand(numel(dU), 1);
dS = 0.3 + 0.1*rand(numel(dU), 1);
dV = 0.5 + 0.25*rand(numel(dU), 1);
dCData = hsv2rgb([dH, dS, dV]);
hQ.CData = dCData; % This assignment automatically changes CDataMode to 'direct'
set(gcf, 'Name', 'Direct Mode');

dBGCol = 0.2;

iCnt = 0;
for dAlpha = -2:0.01:2;
    
    dU =   dYY - dAlpha.*dXX.*dNorm;
    dV = - dXX - dAlpha.*dYY.*dNorm;
    
    % Update the vector data
    hQ.UData = dU;
    hQ.VData = dV;
    
    dV = 0.3 + 0.4*rand(numel(dU), 1);
    dCData = hsv2rgb([dH, dS, dV]);
    
    % Update the color data
    hQ.CData = dCData;
    
    drawnow expose
    
        % Just for measuring fps
    iCnt = iCnt + 1;
    if iCnt == 10
        iCnt = 0;
        dT = toc; tic
        set(gcf, 'Name', sprintf('Direct Mode | %f fps', 10/dT));
    end
end