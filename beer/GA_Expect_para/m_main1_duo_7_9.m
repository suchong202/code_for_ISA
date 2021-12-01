function m_main()
clear
clc

MAXGEN=20;% Run the algebra 
pop_size=8;% The population size 
%NVAR=2;        %Two variables to evolve 
NVAR=7;        %senve variables to evolve 
chromsome=20; % Chromosome length 
GGAP=0.9; % Crossover probability 

FieldD=[rep([chromsome],[1,NVAR]);[1.8,1.45,1.25,1.14,1.1,1.05,0.7;1.95,1.5,1.3,1.2,1.15,1.1,1];rep([1;0;0;0],[1,NVAR])];
%FieldD=[rep([PRECI],[1,NVAR]);[2 5 100;10 10 2000];rep([1;0;1;1],[1,NVAR])];
%Chrom=crtbp(pop_size,NVAR*chromsome);         %Initial population 
Chrom=initpop(pop_size,NVAR*chromsome);

gen=0;%Statistical algebra
%ObjV=TotalCost(bs2rv(Chrom,FieldD));                       

v=bs2rv(Chrom,FieldD);      % The expert decides on preference parameters 

ObjV=zeros(8,1);
for i=1:pop_size
   ObjV(i)=xuexi2_duo_7_9(v(i,:));   %Change the name of the function called 
end




while gen<MAXGEN,
   v=bs2rv(Chrom,FieldD); 
   for i=1:pop_size
      ObjV(i)=xuexi2_duo_7_9(v(i,:));%Change the name of the function called 
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
   trace(gen,3)=min(v(:,3));
   trace(gen,4)=min(v(:,4));
   trace(gen,5)=min(v(:,5));
   trace(gen,6)=min(v(:,6));
   trace(gen,7)=min(v(:,7));
  
   p(gen)=ObjV(1);
end
%for x=1:1:10
 %   p(x)=p(x);
%end
%plot(x,p);
hold on;
plot(trace(:,1),'-.');grid on;
plot(trace(:,2),'r-.');grid on;
plot(trace(:,3),'*');grid on;
plot(trace(:,4),'r*');grid on;
plot(trace(:,5),'y-.');grid on;
plot(trace(:,6),'g-.');grid on;
plot(trace(:,7),'b-.');grid on;

a1=mean(trace(:,1));
a2=mean(trace(:,2));
a3=mean(trace(:,3));
a4=mean(trace(:,4));
a5=mean(trace(:,5));
a6=mean(trace(:,6));
a7=mean(trace(:,7));

%plot(trace(:,3),'k-.');grid;
%plot(v(:,1),'-.');grid;
%plot(v(:,2),'r-.');grid;
%plot(v(:,3),'G');grid;
%plot(trace(:,1),'-.');grid;
legend('The evolution of parameters');
