%function out = get_wedgeLoctions_01(cfg)


out = [];
if 1
%cfg.wedge_width_deg = 90; % in degree the wedge width
cfg.wedge_width_deg = 360; % in degree the wedge width
cfg.nIntersections  = 36; %

%cfg.eccLinesInDeg   = [1.6:diff([1.6,4])/5:4];
cfg.eccLinesInDeg   = [2:3:20];
%cfg.eccLinesInDeg   = [1.6:diff([1.6,4])/5:4];
%cfg.stimDiamPerLine = [0.8:diff([0.8,1.2])/5:1.2]; % not used
cfg.stimDiamPerLine = zeros(size(cfg.eccLinesInDeg))+2; % not used



cfg.centerDeg = 0;
%cfg.centerDeg = 90;
cfg.getDirs=1;
end

wedge_width_deg = cfg.wedge_width_deg;
nIntersections = cfg.nIntersections;
stimDiamPerLine = cfg.stimDiamPerLine;
eccLinesInDeg = cfg.eccLinesInDeg;
centerDeg = cfg.centerDeg;

W = (wedge_width_deg/180)*pi;
h = (W / nIntersections);
P = (h .* [1:nIntersections]) - (h*0.5);

x = []; y = [];xyinfo=[];
xydistPerEcc = [];
cnt = 0;
for k=1:length(eccLinesInDeg)
    cEcc = eccLinesInDeg(k);
    for p=1:length(P)
        cnt = cnt+1;
        [x(cnt),y(cnt)] = pol2cart(P(p),eccLinesInDeg(k));
        % --- note the stimOrientation needs to be stored, too.
        xyinfo(cnt,:) = [P(p)*180/pi, eccLinesInDeg(k), stimDiamPerLine(k), P(p)*180/pi]
    end

    cDist   = abs(complex(x(cnt-1),y(cnt-1))-complex(x(cnt),y(cnt)));
    cDistH  = sqrt(  (x(cnt)-x(cnt-1))^2 - (y(cnt)-y(cnt-1))^2   );
    xydistPerEcc(k,1:3) = [cEcc cDist cDistH];    
end

% --- rotate
orient2zero   = ((wedge_width_deg/2)/180)*pi;
orient2Center = (centerDeg/180)*pi;
rotateRad = orient2zero + orient2Center;
% angle(complex(x*pi/180,y*pi/180))*180/pi;

[T, R] = cart2pol(x,y);
[x,y] = pol2cart(T-rotateRad,R);


if cfg.getDirs
    cori = xyinfo(:,1);
    cori= cori ./ 180 .* pi;
    % [a,b]=pol2cart(cori - rotateRad - (pi/2),1); cortex to the right
    % [a,b]=pol2cart(cori - rotateRad + pi ,1); cortex also to the right
    [a,b]=pol2cart(cori - rotateRad + (pi/2) ,1);
    [T,r]=cart2pol(a,b)    
    xyinfo(:,1) = T * 180 / pi;
    % coricomplex = exp(i*(cori));
    % new = coricomplex + (exp(i*(rotateRad))) + exp(i*(pi));
    % xyinfo(:,1) = angle(new) * 180 /pi;
end




%out.x       = x;
%out.y       = y;
out.xy      = [x y];
out.xyinfo  = xyinfo;
out.cfg     = cfg;
out.xydistPerEcc = xydistPerEcc

doPlot = 1

if doPlot ==1
figure('Color','w') 
plot(x,y,'r.','Markersize',10), hold on, 
for k=1:length(x)
r = out.xyinfo(k,3)*0.5
xy = [x(k), y(k)]
plot(sin(0:pi/50:2*pi)*r+xy(1),cos(0:pi/50:2*pi)*r+xy(2),'k-'), hold on, 
end
plot([-0.5 0.5],[0 0],'k-','Linewidth',4), hold on, 
plot([0 0],[0.5 -0.5],'k-','Linewidth',4), hold on, 
xlabel('deg vis angle'),ylabel('deg vis angle')
axis equal;
grid on

end

