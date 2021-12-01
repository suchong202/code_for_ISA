% Grey Wolf Optimizer
function [Alpha_score,Alpha_pos,Convergence_curve,Parameters]=GWO(Max_iter,SearchAgents_no,lb,ub,dim)

% initialize alpha, beta, and delta_pos  
Alpha_pos=zeros(1,dim);  
Alpha_score=inf; %change this to -inf for maximization problems 

Beta_pos=zeros(1,dim);
Beta_score=inf; %change this to -inf for maximization problems  

Delta_pos=zeros(1,dim);
Delta_score=inf; %change this to -inf for maximization problems

%Initialize the positions of search agents 
Positions=initialization(SearchAgents_no,dim,ub,lb);



Convergence_curve=zeros(1,Max_iter);
Parameters = zeros(1,dim,Max_iter);
l=1;% Loop counter 


% Main loop
while l<=Max_iter
    
     % Return back the search agents that go beyond the boundaries of the search space
    for m=1:7
        if m==1
        Flag4ub=Positions(:,m)>=1.95;
        Flag4lb=Positions(:,m)<=1.8;
        Positions(:,m)=(Positions(:,m).*(~(Flag4ub+Flag4lb)))+1.95.*Flag4ub+1.8.*Flag4lb;
        end
        if m==2
        Flag4ub=Positions(:,m)>=1.5;
        Flag4lb=Positions(:,m)<=1.45;
        Positions(:,m)=(Positions(:,m).*(~(Flag4ub+Flag4lb)))+1.5.*Flag4ub+1.45.*Flag4lb;
        end
        if m==3
        Flag4ub=Positions(:,m)>=1.3;
        Flag4lb=Positions(:,m)<=1.25;
        Positions(:,m)=(Positions(:,m).*(~(Flag4ub+Flag4lb)))+1.3.*Flag4ub+1.25.*Flag4lb;
        end
        if m==4
        Flag4ub=Positions(:,m)>=1.2;
        Flag4lb=Positions(:,m)<=1.14;
        Positions(:,m)=(Positions(:,m).*(~(Flag4ub+Flag4lb)))+1.2.*Flag4ub+1.14.*Flag4lb;
        end
        if m==5
        Flag4ub=Positions(:,m)>=1.15;
        Flag4lb=Positions(:,m)<=1.1;
        Positions(:,m)=(Positions(:,m).*(~(Flag4ub+Flag4lb)))+1.15.*Flag4ub+1.1.*Flag4lb;
        end
        if m==6
        Flag4ub=Positions(:,m)>=1.1;
        Flag4lb=Positions(:,m)<=1.05;
        Positions(:,m)=(Positions(:,m).*(~(Flag4ub+Flag4lb)))+1.1.*Flag4ub+1.05.*Flag4lb;
        end
        if m==7
        Flag4ub=Positions(:,m)>=1;
        Flag4lb=Positions(:,m)<=0.7;
        Positions(:,m)=(Positions(:,m).*(~(Flag4ub+Flag4lb)))+1.*Flag4ub+0.7.*Flag4lb;
        end     
    end
    for i=1:size(Positions,1)              
        fitness=xuexi2_duo_7_9(Positions(i,:));  % deviation 
        
        % Update Alpha, Beta, and Delta
        if fitness<Alpha_score 
            Alpha_score=fitness; % Update alpha
            Alpha_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness<Beta_score 
            Beta_score=fitness; % Update beta
            Beta_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness>Beta_score && fitness<Delta_score 
            Delta_score=fitness; % Update delta
            Delta_pos=Positions(i,:);
        end
    end
    
    
    a=2-l*((2)/Max_iter); % a decreases linearly fron 2 to 0 
    
    % Update the Position of search agents including omegas 
    for i=1:size(Positions,1)
        for j=1:size(Positions,2)     
                       
            r1=rand(); % r1 is a random number in [0,1]
            r2=rand(); % r2 is a random number in [0,1] 
            
            A1=2*a*r1-a; % Equation (3.3)
            C1=2*r2; % Equation (3.4)
            
            D_alpha=abs(C1*Alpha_pos(j)-Positions(i,j)); % Equation (3.5)-part 1
            X1=Alpha_pos(j)-A1*D_alpha; % Equation (3.6)-part 1
                       
            r1=rand();
            r2=rand();
            
            A2=2*a*r1-a; % Equation (3.3)
            C2=2*r2; % Equation (3.4)
            
            D_beta=abs(C2*Beta_pos(j)-Positions(i,j)); % Equation (3.5)-part 2
            X2=Beta_pos(j)-A2*D_beta; % Equation (3.6)-part 2       
            
            r1=rand();
            r2=rand(); 
            
            A3=2*a*r1-a; % Equation (3.3)
            C3=2*r2; % Equation (3.4)
            
            D_delta=abs(C3*Delta_pos(j)-Positions(i,j)); % Equation (3.5)-part 3
            X3=Delta_pos(j)-A3*D_delta; % Equation (3.5)-part 3             
            
            Positions(i,j)=(X1+X2+X3)/3;
        end
    end
    l=l+1;  
    Convergence_curve(l)=Alpha_score;
    Parameters(1,:,l) = Alpha_pos ;
end



