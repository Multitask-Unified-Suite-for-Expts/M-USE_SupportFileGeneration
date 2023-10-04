function [iTYPENUM] = get_sessionConfigTypes_01(iTaskCombination)

iTYPENUM = [];
ST = [];
ST.TYPE = {};
ST.TYPENUM = [];


% --- --- --- --- --- --- --- --- --- 
% --- all tasks for demo and WEBGL_default 
iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'VS_FL_EC_WWW_MZ_WM_CR';
ST.TYPENUM(iS) = [1 ];  

% --- --- --- --- --- --- --- --- --- 
% --- VS added   ....10....
iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'VS';
ST.TYPENUM(iS) = [10];  


% --- --- --- --- --- --- --- --- --- 
% --- FL added   ....20....
iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'FL';
ST.TYPENUM(iS) = [20 ];  

iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'VS_FL_VS';
ST.TYPENUM(iS) = [21 ];  

% --- --- --- --- --- --- --- --- --- 
% --- EC added   ....30....
iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'EC';
ST.TYPENUM(iS) = [30 ];  

iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'VS_EC_FL';
ST.TYPENUM(iS) = [31 ];  



% --- --- --- --- --- --- --- --- --- 
% --- MZ added   ... 40....

iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'MZ';
%ST.TYPE{iS} = 'MRT_VS_MZ_VS_MZR';
ST.TYPENUM(iS) = [40 ]; 

iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'MZ_MZR';
ST.TYPENUM(iS) = [41 ]; 


iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'VS_EC_FL_MRT';
ST.TYPENUM(iS) = [42 ];



iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'MRT_FL_EC_VS';
ST.TYPENUM(iS) = [43 ];



%iS = length(ST.TYPE)+1;
%ST.TYPE{iS} = 'VS_MZ_VS_MZR';
%ST.TYPENUM(iS) = [42 ];




% --- --- --- --- --- --- --- --- --- 
% --- WWW added   ... 50....
iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'WWW';
ST.TYPENUM(iS) = [50 ];  

iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'WWW_EC';
ST.TYPENUM(iS) = [51 ];  

iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'WWW_EC_VS';
ST.TYPENUM(iS) = [52 ];  




% --- --- --- --- --- --- --- --- --- 
% --- WM added   ....60....
iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'WM';
ST.TYPENUM(iS) = [60 ];  

iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'WM_EC_FL_MRT';
ST.TYPENUM(iS) = [61 ];  





% --- --- --- --- --- --- --- --- --- 
% --- CR added   ....70....
iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'CR';
ST.TYPENUM(iS) = [70];  

iS = length(ST.TYPE)+1;
ST.TYPE{iS} = 'VS_CR_FL';
ST.TYPENUM(iS) = [71 ];  




%[iTYPENUM] = get_sessionConfigTypes_01(iTaskComnbination)
[a,b,iSel]=intersect(iTaskCombination,ST.TYPE);
iTYPENUM = ST.TYPENUM(iSel);

