function erro1=xuexi2_duo_7_9(a)

m=20;
n=4;
x1(1:m,1:n,6)=0;

u(1:m,1:n,6)=0;
y(1:m,1:n,6)=0;
e(1:m,1:n,6)=0;
err(1:m,1:n,6)=0;

% b=beronulli(1,1000,1);
% w=randn(m,n)/5;
%for n=1:100  
%    y_d(n) = sin(8*n/50); 
%end
y_d=[0,0.1,0.0001,1.6,0.1,0;
       0,0.1,0.0001,1.0,0.1,0;
       0,0.1,0.0001,0.1,0.001,0;
       0,0.1,0.0001,0.8,0.001,0;
       0,0.1,0.0001,1.2,0.01,0;
       0,0.3,0.0001,1.0,0.01,0];
the=[0.397255165689090,0.45,0.54,0.63,0.81,0.99];
for k=1:m
    
    for t=2:n   
      for i=1:6
        x1(k,t,i)=(-0.8*x1(k,t-1,i))-0.22*x1(k,t-1,i)+0.5*u(k,t-1,i);
        %x1(k,t,i)=-0.22*x1(k,t-1,i)+0.5*u(k,t-1,i);
      end
      %y(k,t-1)=(x1(k,t-1)+0.5*x2(k,t-1));
      for j=1:6
        e(k,t-1,j)=y_d(t-1,j)-x1(k,t-1,j);%The difference between the reference trajectory and the actual control trajectory
      end
      %err(k,t-1)=abs(e(k,t-1,1)).^2;
      for m=2:6
         err(k,t-1,m)=err(k,t-1,m)+abs(e(k,t-1,m)).^2;
      end
    end
    for t=2:n 
        for j=2:5
            u(k+1,t-1,j)=u(k,t-1,j)+a(j-1)*the(t)*e(k,t,j)+0.3*e(k,t-1,j);  %Variation in the quantity of manipulation  
            %uii=0.01;
            %u(k+1,t-1,j)=u(k,t-1,j)+v(j)*2*e0(k,t-1,j);
        end
    end
end
erro1=0;%Copy back
for k=1:m
    for i=1:4
       for j=1:6
           erro1=erro1+err(k,i,j)^2;
       end
    end
    
end
   
end  