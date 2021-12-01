function m_main()
clear
clc
MAXGEN=20; %Run the algebra 
pop_size=8; % The population size
NVAR=2;        % Two variables to evolve
chromsome=10; % Chromosome length
GGAP=0.9; % Crossover probability

FieldD=[rep([chromsome],[1,NVAR]);[0,0;1,1];rep([1;0;0;0],[1,NVAR])];
 
Chrom=crtbp(pop_size,NVAR*chromsome);         % Initial population

%FieldD=[rep([chromsome],[1,NVAR]);[0.1,0.1,0.1,0.1,0.1,0.8;1.9,1.5,1.6,1.8,2.0,2.0];rep([1;0;0;0],[1,NVAR])];
%FieldD=[rep([PRECI],[1,NVAR]);[2 5 100;10 10 2000];rep([1;0;1;1],[1,NVAR])];
%Chrom=crtbp(pop_size,NVAR*chromsome);         
Chrom=initpop(pop_size,NVAR*chromsome);


gen=0;% Statistical algebra
%ObjV=TotalCost(bs2rv(Chrom,FieldD));                        

v=bs2rv(Chrom,FieldD); 
m=[0.397255165689090,0.45,0.54,0.63,0.81,0.99];
derm=[0.0527,0.09,0.09,0.18,0.18];
ObjV=zeros(8,1);
A=zeros(6,3);
A(1,:)=[0.599,-0.147,0.305];
B=[0.3,-0.2,0.4];
ment=zeros(6,3);
ment(1,:)=[0.599,-0.147,0.305];
Theta=zeros(6,1);

while gen<MAXGEN
   v=bs2rv(Chrom,FieldD); 
for j=1:8
    A(1,:)=[0.599,-0.147,0.305];
    for i=2:6
    A(i,:)=(1-derm(i-1)/sum(derm,2))*v(j,1)*A((i-1),:)+(derm(i-1)/sum(derm,2))*B*v(j,2);
    end
    for i=1:6
    ObjV(j)=ObjV(j)+(((A(i,1)*A(i,1)+A(i,2)*A(i,2)+A(i,3)*A(i,3))^(1/2))/(3^(1/2))-m(i))^2;%Sum of error squared
    end
end
 FitnV=ranking(-ObjV);                                     %Assign fitness values
   SelCh=select('sus',Chrom,FitnV,GGAP);                    %choose
   SelCh=recombin('xovsp',SelCh,0.7);                       %restructuring
   SelCh=mut(SelCh,0.07);                                   %variation
   %ObjVSel=TotalCost(bs2rv(SelCh,FieldD));                  %Calculate the value of the child objective function
   %[Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);        %Heavy insert
   Chrom=reins(Chrom,SelCh);
   gen=gen+1;
   %Output the decimal value of the optimal solution and its corresponding 10 variables
  % [Y,I]=min(ObjVSel);
  % Y,X=bs2rv(Chrom(I,:),FieldD);
   trace(gen,1)=min(v(:,1));
   trace(gen,2)=min(v(:,2));
   p(gen)=ObjV(1);
end
%for x=1:1:10
 %   p(x)=p(x);
%end
%plot(x,p);
hold on;
plot(trace(:,1),'-.');grid on;
plot(trace(:,2),'r-.');grid on;
%plot(trace(:,3),'k-.');grid;
%plot(v(:,1),'-.');grid;
%plot(v(:,2),'r-.');grid;
%plot(v(:,3),'G');grid;
%plot(trace(:,1),'-.');grid;
legend('The evolution of ¦Á','The evolution of ¦Â');
Alpha = trace(20,1);
Beta = trace(20,2);
end
