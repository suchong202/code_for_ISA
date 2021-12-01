function erro1=xuexi2_duo_7_9(a)

m=20;
n=5;
x1(1:m,1:n,9)=0;

u(1:m,1:n,9)=0;
y(1:m,1:n,9)=0;
e(1:m,1:n,9)=0;
err(1:m,1:n,9)=0;

% b=beronulli(1,1000,1);
% w=randn(m,n)/5;
%for n=1:100  
%    y_d(n) = sin(8*n/50); 
%end
y_d=[0,9.83,11.04,13.84,15.05,13.67,5.10,2.92,0;	
    0,9.60,13.27,10.94,16.82,9.42,9.37,2.47,0;	
    0,12.29,13.84,12.87,12.59,11.51,14.74,2.53,0;	
    0,11.87,14.70,11.61,14.11,10.35,8.87,2.07,0;	
    0,12.78,14.89,12.43,13.18,11.55,11.59,2.74,0];
the=[0.397255165689090,0.54,0.63,0.81,0.99];
for k=1:m
    
    for t=2:n   
      for i=1:9
        x1(k,t,i)=(-0.8*x1(k,t-1,i))-0.22*x1(k,t-1,i)+0.5*u(k,t-1,i);
        %x1(k,t,i)=-0.22*x1(k,t-1,i)+0.5*u(k,t-1,i);
      end
      %y(k,t-1)=(x1(k,t-1)+0.5*x2(k,t-1));
      for j=1:9
        e(k,t-1,j)=y_d(t-1,j)-x1(k,t-1,j);%The difference between the reference trajectory and the actual control trajectory
        %e0(k,t-1,j)= the(t)-the(t-1);%Emotional intensity difference
      end
      %err(k,t-1)=abs(e(k,t-1,1)).^2;
      for m=2:9
         err(k,t-1,m)=err(k,t-1,m)+abs(e(k,t-1,m)).^2;
      end
    end
    for t=2:n 
        for j=2:8
            u(k+1,t-1,j)=u(k,t-1,j)+a(j-1)*the(t)*e(k,t,j)+0.3*e(k,t-1,j);  %Variation in the quantity of manipulation  
            %uii=0.01;
            %u(k+1,t-1,j)=u(k,t-1,j)+v(j)*2*e0(k,t-1,j);
        end
    end
end
erro1=0;%Copy back
for k=1:m
    for i=1:5
       for j=1:9
           erro1=erro1+err(k,i,j)^2;
       end
    end
    
end
   
end  