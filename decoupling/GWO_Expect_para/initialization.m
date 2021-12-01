% This function initialize the first population of search agents
function Positions=initialization(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries 

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
    Positions=zeros(SearchAgents_no,dim);
    a1=rand(1,8).*(2.5-2)+2;
    a2=rand(1,8).*(0.002-0.0001)+0.0001;
    a3=rand(1,8).*(8-6)+6;
    a4=rand(1,8).*(0.15-0.006)+0.006;

    
    for i=1:8
        Positions(i,1)=a1(1,i);
        Positions(i,2)=a2(1,i);
        Positions(i,3)=a3(1,i);
        Positions(i,4)=a4(1,i);
        
    end      
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        Positions(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
    end
end