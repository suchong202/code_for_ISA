clc;
clear all;
close all;

v=[1.95000000000000,1.49918064610852,1.30000000000000,1.20000000000000,1.15000000000000,1.10000000000000,0.874445149308630];
theta=[0.397255165689090,0.54,0.63,0.81,0.99];
y_d=zeros(5,7);
y_d(1,:) = [9.83,11.04,13.84,15.05,13.67,5.10,2.92];
for i=2:5
    y_d(i,:)=y_d(i-1,:)+2.7*(theta(i)-theta(i-1))*v;
    T=zeros(1,7);
    for w=1:7
        T(1,w)=y_d(i,w);
    end
   tT=[0,44,90,120,150,180,200];
   temperature = [tT' T']; 
   tsim = sim('ferment',[0 200]); 
   figure((i-1));
   subplot(1,4,1);
   plot(tT,T,'r-'); %plot-edit
   axis([0 tsim(end) 0 20]);
   grid on
 
   subplot(1,4,2);
   plot(tsim,etac,'r-',tsim,diacetyl,'g*');
   axis([0 tsim(end) 0 7]);
   grid on
   subplot(1,4,3);
   plot(tsim,sugar,'k-',tsim,ethanol,'b*');
   axis([0 tsim(end) 0 150]);
   grid on
 
   subplot(1,4,4);axis off
   % OAI
   % mm=0.2*mean(diacetyl(:))+0.3*mean(etac(:))+0.3*mean(sugar(:))+0.4*mean(ethanol(:))+0.3*max(diacetyl(:))+0.2*min(etac(:))+0.2*min(sugar(:))+0.5*max(ethanol(:));
   mm=0.28*mean(diacetyl(:))+0.25*mean(etac(:))+0.09*mean(sugar(:))+0.09*mean(ethanol(:))+0.08*max(diacetyl(:))+0.07*min(etac(:))+0.07*min(sugar(:))+0.07*max(ethanol(:));
   text(0.1,0.5,sprintf('OAI:%.2f',mm));
   drawnow;
    
end