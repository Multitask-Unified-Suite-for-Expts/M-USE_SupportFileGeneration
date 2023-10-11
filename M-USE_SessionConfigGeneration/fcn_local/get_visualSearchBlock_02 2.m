function [trl] = get_visualSearchBlock_02(cfg_VS)

if isempty(cfg_VS.nFeaturesPerDim)
cfg_VS.nFeaturesPerDim = 8;
end
if ~isfield(cfg_VS, 'nTrials')     
cfg_VS.nTrials  = 200;
end

% --- fcn get search block: 10 target failiarization trials, 100 3/6/9/12 distractor trials
%dimensionsNum = [zeros(1,8)+1 zeros(1,8)+2 zeros(1,8)+3 zeros(1,8)+4];
%dimensionFeatureMapping = [1:8 1:8 1:8 1:8];

if isempty(cfg_VS.setSizeConditions)
    cfg_VS.setSizeConditions = [3 6 9 12];
end
% --- get the features for each dimension for this block

% --- which 3 feature dimenisons are used ?
iDims = zeros(4,1); tmp = randperm(4); iDims(tmp(1:3)) = 1;
% --- choose randomly features values for each dimenion
featD1 = randperm(cfg_VS.nFeaturesPerDim);
featD2 = randperm(cfg_VS.nFeaturesPerDim);
featD3 = randperm(cfg_VS.nFeaturesPerDim);

dimIdx = find(iDims);

% --- determine target object
targObject = zeros(1,4);
targObject(dimIdx) = [featD1(1) featD2(1) featD3(1)];

% --- determine pool of distractor objects
% --- sharing zero, one or two features with the target:
dObjects_ShareZero = zeros(3*3*3,4); iCnt0=0;
dObjects_ShareOne = zeros((3*3)+3,4); iCnt1=0;
dObjects_ShareTwo = zeros((3+3),4); iCnt2=0;
for h=2:4
    for i=2:4
        for j=2:4

            iCnt0=iCnt0+1;
            % --- share zero features with target
            dObjects_ShareZero(iCnt0,dimIdx) = [featD1(h) featD2(i) featD3(j)];

            % --- share one feature with target
            if h==2
                iCnt1=iCnt1+1;
                dObjects_ShareOne(iCnt1,dimIdx) = [featD1(1) featD2(i) featD3(j)];
            end
            if i==2
                iCnt1=iCnt1+1;
                dObjects_ShareOne(iCnt1,dimIdx) = [featD1(h) featD2(1) featD3(j)];
            end
            if j==2
                iCnt1=iCnt1+1;
                dObjects_ShareOne(iCnt1,dimIdx) = [featD1(h) featD2(i) featD3(1)];
            end

            % --- share two feature with target
            if h==2 & i==2
                iCnt2=iCnt2+1;
                dObjects_ShareTwo(iCnt2,dimIdx) = [featD1(1) featD2(1) featD3(j)];
            end
            if h==2 & j==2
                iCnt2=iCnt2+1;
                dObjects_ShareTwo(iCnt2,dimIdx) = [featD1(1) featD2(i) featD3(1)];
            end
            if i==2 & j==2
                iCnt2=iCnt2+1;
                dObjects_ShareTwo(iCnt2,dimIdx) = [featD1(h) featD2(1) featD3(1)];
            end

        end
    end
end

% 
% % --- specify possible object locations on screen
% spatial_scale = 0.05;
% y_default = 0.4;
% x_spacing = 4;%also exlucde within 2 units of center, arms make us need more spacing on x-axis
% z_spacing = 3;%also exlucde within 1.5 units of center
% x_max = 8;%magnitude
% z_max = 4.5;%magnitude
% xzlocs = [];
% count = 0;
% for x = -x_max:x_spacing:x_max
%     for z = -z_max:z_spacing:z_max
%         if x == 0 && z == 0,
%             continue
%         else
%             count = count+1;
%             xzlocs(count,1:3) = [x 0.4 z];
%         end
%     end
% end

%y_default = 0.4;
%x_spacing = 4.5;%also exlucde within 2 units of center, arms make us need more spacing on x-axis
%z_spacing = 3.5;%also exlucde within 1.5 units of center
%x_max = 20;%magnitude
%z_max = 6;%magnitude
xzlocs = [];
count = 0;
%xRange = [0:3.8:20]; xRange = [fliplr(-xRange(2:end)) xRange]
%xRange = [0:4:20]; xRange = [fliplr(-xRange(2:end)) xRange];% length(xRange)
xRange = [0:5:20]; xRange = [fliplr(-xRange(2:end)) xRange];% length(xRange)
%zRange = [0:2.5:8]; zRange = [fliplr(-zRange(2:end)) zRange]
%zRange = [0:3.2:9.6]; zRange = [fliplr(-zRange(2:end)) zRange]; length(zRange)
%zRange = [0:3.2:9.6]; zRange = [fliplr(-zRange(2:end)) zRange]; length(zRange)
zRange = [0:3.8:(3.8*3)]; zRange = [fliplr(-zRange(2:end)) zRange]; length(zRange)
% 9.6 *with 3.2 vs 11.4 with 3.8

for x = xRange
    for z = zRange
        if x == 0 && z == 0,
            continue
        else
            count = count+1;
            xzlocs(count,1:3) = [x 0.4 z];
        end
    end
end

%figure, plot(xzlocs(:,[1]),xzlocs(:,[3]),'b+')



%[TH R]=cart2pol(iPos,allLocationPossibilities{1}(:,3));
% 	TH= TH - (60*180/pi);
% 	[cX,cY]=pol2cart(TH,R);
%allLocationPossibilities{3} = [cX cZ cY];

%keyboard



trl = [];
trl.objectVector = [];
trl.objectXYZ = [];
trl.setSize = [];
trl.TrialID = {};
trl.stimCode = {};
trl.ContextName = {};
trl.objectVectorAll = [];


%  determine random trial sequence across setsizes
%  10 trials only target
nObject = cfg_VS.setSizeConditions;
nPrimingTrials = 10;
for iT=1:nPrimingTrials
    idx = randi(size(xzlocs,1));
    trl.targetObject = targObject;
    trl.objectVector{iT} = targObject;
    trl.objectXYZ{iT} =  xzlocs(idx,:);
    trl.TrialID{iT} =  sprintf('VSn0.TDSIM0' );

    trl.objectVectorAll = cat(1,targObject, trl.objectVector{iT});
    trl.ContextName{iT} = cfg_VS.contextName;

end


% 100 trials randomly
trlPerSetSize = ceil(cfg_VS.nTrials / length(cfg_VS.setSizeConditions));
tmp = repmat(cfg_VS.setSizeConditions,1,trlPerSetSize);
trl.setSize(1:nPrimingTrials) = 1;
trl.setSize(nPrimingTrials+1:nPrimingTrials+cfg_VS.nTrials) = tmp(randperm(length(tmp)));

% low and high t-d similarity
trlPerTDSIM = ceil(cfg_VS.nTrials / 2);
tmp = repmat([1 2],1,trlPerTDSIM);
trl.targDistrSimilarity(1:nPrimingTrials) = 0;
trl.targDistrSimilarity(nPrimingTrials+1:nPrimingTrials+cfg_VS.nTrials) = tmp(randperm(length(tmp)));

%for iT=1:length(trl.setSize)
for iT=(nPrimingTrials+1):(nPrimingTrials+cfg_VS.nTrials)

    nDistractors = trl.setSize(iT);
    iTDSIM = trl.targDistrSimilarity(iT);

    % get either 0 or 1 shared OR 1 or 2 shared
    if randi(2)==1
        nHalf = ceil(nDistractors/2);
    else
        nHalf = floor(nDistractors/2);
    end
    if iTDSIM == 1
        tmp0 = randperm(size(dObjects_ShareZero,1));
        tmp1 = randperm(size(dObjects_ShareOne,1));
        iObjects = cat(1,dObjects_ShareZero(tmp0(1:length(1:nHalf)),:) , ...
            dObjects_ShareOne(tmp1(1:length(nHalf+1:nDistractors)),:));
    elseif iTDSIM == 2
        tmp0 = randperm(size(dObjects_ShareOne,1));
        tmp1 = randperm(size(dObjects_ShareTwo,1));
        iObjects = cat(1,dObjects_ShareOne(tmp0(1:length(1:nHalf)),:) , ...
            dObjects_ShareTwo(tmp1(1:length(nHalf+1:nDistractors)),:));
    end
    % get rand locations for all
    tmp = randperm(size(xzlocs,1));
    iLocations =  xzlocs( tmp(1:nDistractors + 1) , :);

    trl.objectVector{iT} = cat(1,targObject, iObjects);
    trl.objectXYZ{iT} =  iLocations;
    trl.TrialID{iT} =  sprintf('VSn%.2d.TDSIM%d',nDistractors,iTDSIM);
    % for later tracking of oibject ID's
    trl.objectVectorAll = cat(1,trl.objectVectorAll, trl.objectVector{iT});
end

sprintf('...done\n')