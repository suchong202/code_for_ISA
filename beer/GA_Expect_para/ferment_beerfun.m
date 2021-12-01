function [sys,x0,str,ts] = beerfun(t,x,u,flag)
%BEERFUN
% S-Function of the Beer fermenter model
%

% (c) Balazs Balasko, 2003
% University of Veszprem, Hungary


global x0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% S-Function of the Beer fermenter model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch flag,
   
case 0,                                                
   [sys,x0,str,ts] = mdlInitializeSizes;
   
case 1,                
   sys = mdlDerivatives(t,x,u);

case 3,
    sys = mdlOutputs(t,x,u);

otherwise
     sys = []; % do nothing
end

%
%===================================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%===================================================================================
%
function [sys, x0,str,ts] = mdlInitializeSizes
global x0
sizes = simsizes;
sizes.NumContStates  = 7;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 7;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);

x0  = [1.92 0.08 2 130 0 0 0]'; %initial concentrations
str = [];
ts  = [0 0];  % continuous sample time: [period, offset]

% end mdlInitializeSizes

%
%===================================================================================
% mdlDerivatives
%
%===================================================================================
%
function sys = mdlDerivatives(t,x,u)

x0  = [1.92 0.08 2 130 0 0 0]'; %initial concentrations
T=u+273.15;
%xlag=x(1) suspended latent biomass
%xact=x(2) suspended active biomass
%xbottom=x(3) suspended dead biomass
%s=x(4) concenctration of sugar
%e=x(5) ethanol concentration
%acet=x(6) ethyl acetate concentration
%diac=x(7) diacetyl concentration


%parameters
ux0=exp(108.31-31934.09/T);
ueas=exp(89.92-26589/T);
us0=exp(-41.92+11654.64/T);
ulag=exp(30.72-9501.54/T);
ud0=exp(33.82-10033.28/T);
ua0=exp(3.27-1267.24/T);
km=exp(130.16-38313/T);  %yeast growth inhibition parameter
ks=exp(-119.63+34203.95/T);    %sugar inhibition parameter
udy=0.000127672;   %diacetyl appearance rate 
uab=0.00113864;     %diacetyl disappearance or reduction rate

ux=ux0*x(4)/(0.5*x0(4)+x(5)); %specific yeast growth rate
ud=0.5*x0(4)*ud0/(0.5*x0(4)+x(5)); %specific yeast settling down rate
us=us0*x(4)/(ks+x(5)); %substrate consumption rate
ua=ua0*x(4)/(ks+x(5)); %ethanol production rate
f=1-x(5)/(0.5*x0(4)); %fermentation inhibitor factor


sys(1)=-ulag*x(1);              %xlag derivalt
sys(2)=ux*x(2)-km*x(2)+ulag*x(1);          %xact derivalt
sys(3)=km*x(2)-ud*x(3);    %xbottom derivalt
sys(4)=-us*x(2);            %s derivalt
sys(5)=ua*f*x(2);            %e derivalt
sys(6)=ueas*us*x(2);                %acet derivalt
sys(7)=udy*x(4)*x(2)-uab*x(7)*x(5);       %diac derivalt

function sys = mdlOutputs(t,x,u)

sys = x;