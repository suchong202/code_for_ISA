% This function initialize the first population of search agents
function Positions=initialization(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries 

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
    Positions=zeros(SearchAgents_no,dim);
    a1=rand(1,8).*(1.95-1.8)+1.8;
    a2=rand(1,8).*(1.5-1.45)+1.45;
    a3=rand(1,8).*(1.3-1.25)+1.25;
    a4=rand(1,8).*(1.2-1.14)+1.14;
    a5=rand(1,8).*(1.15-1.1)+1.1;
    a6=rand(1,8).*(1.1-1.05)+1.05;
    a7=rand(1,8).*(1-0.7)+0.7;
    for i=1:8
        Positions(i,1)=a1(1,i);
        Positions(i,2)=a2(1,i);
        Positions(i,3)=a3(1,i);
        Positions(i,4)=a4(1,i);
        Positions(i,5)=a5(1,i);
        Positions(i,6)=a6(1,i);
        Positions(i,7)=a7(1,i);
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