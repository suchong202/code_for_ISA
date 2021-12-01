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
theta=[0.1,0.2,0.3,0.5,0.7,0.9,1.0];
% derm=[0.142744,0.09,0.18,0.18];
A=zeros(7,3);
A(1,:)=[0.599,-0.147,0.305];
B=[0.3,-0.2,0.4];
ObjV=zeros(8,1);


% Main loop
while l<=Max_iter
    for m=1:2
        if m==1
        Flag4ub=Positions(:,m)>=2;
        Flag4lb=Positions(:,m)<=0;
        Positions(:,m)=(Positions(:,m).*(~(Flag4ub+Flag4lb)))+1.*Flag4ub;
        end
        if m==2
        Flag4ub=Positions(:,m)>=2;
        Flag4lb=Positions(:,m)<=0;
        Positions(:,m)=(Positions(:,m).*(~(Flag4ub+Flag4lb)))+1.*Flag4ub;
        end 
    end
    for i=1:size(Positions,1)  
        
       % Return back the search agents that go beyond the boundaries of the search space
        for w=2:5
        A(w,:)=0.5*Positions(i,1)*A((w-1),:)+0.5*B*Positions(i,2);
        end
        for w=1:5
        ObjV(i)=(((A(w,1)*A(w,1)+A(w,2)*A(w,2)+A(w,3)*A(w,3))^(1/2))/(3^(1/2))-theta(w))^2;%Sum of error squared
        end              
        fitness=ObjV(i);
        
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



