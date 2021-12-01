clear all;
close all;
Max_iteration=20;   % Maximum numbef of iterations 
dim=2;              % Number of searched variables
SearchAgents_no=8;  % Population size
ub=2;   % max
lb=0;   % min

% Load details of the selected benchmark function

[Best_score,Best_pos,GWO_cg_curve,Parameters]=GWO(Max_iteration,SearchAgents_no,lb,ub,dim);

for i=2:Max_iteration+1
    v(i-1,:)=Parameters(:,:,i);
end
hold on;
plot(v(:,1),'-.');grid on;
plot(v(:,2),'r-.');grid on;
a = mean(v(:,1));
b = mean(v(:,2));
w = a+b;






    
    
