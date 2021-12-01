clear all;
close all;
Max_iteration=20; % Maximum numbef of iterations  
dim=7;    %  Optimize 7 parameters 
SearchAgents_no=8;  %  8 species, can be modified 
ub=1.9; %max
lb=0.8; %min
v=zeros(Max_iteration,dim);

% Load details of the selected benchmark function 

[Best_score,Best_pos,GWO_cg_curve,Parameters]=GWO(Max_iteration,SearchAgents_no,lb,ub,dim);
for i=2:Max_iteration+1
    v(i-1,:)=Parameters(:,:,i);
end
hold on;
plot(v(:,1),'-.');grid on;
plot(v(:,2),'r-.');grid on;
plot(v(:,3),'*');grid on;
plot(v(:,4),'r*');grid on;
plot(v(:,5),'y-.');grid on;
plot(v(:,6),'g-.');grid on;
plot(v(:,7),'b-.');grid on;
a=0;






    
    
