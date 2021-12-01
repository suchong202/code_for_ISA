theta=[0.397255165689090,0.45,0.54,0.63,0.81,0.99];
v=[2.09428825923132,0.000238348256732696,7.01421450213003,0.00866019948940326];
y_d=zeros(6,4);
y_d(1,:)=[0.1,0.0001,1.6,0.1];
In1 = 1;
In2 = 1;
for i=2:6
    y_d(i,:)=0.3*y_d(i-1,:)+0.6*(theta(i)-theta(i-1))*v;
    kp1=y_d(i,1);
    ki1=y_d(i,2);
    kd1=0;
    kp2=y_d(i,3);
    ki2=y_d(i,4);
    kd2=0;
    simOut = sim('VL29',[0 100]);
        %time=0:0.01:0.58;
        %for k = 1:1:length(out)
            %time(k) = k * ts;

        %end
    t=out1.Time;
    figure(i-1);

    subplot(1,3,1);
    plot(t,out1.Data);

    xlabel('Time');
    ylabel('y');
    legend('step','y1','y2');
    subplot(1,3,2);
    plot(t,y1,'m');

     xlabel('Time');
    ylabel('y1');
    legend('y1');
    subplot(1,3,3);
    plot(t,y2,'k');

     xlabel('Time');
    ylabel('y2');
    legend('y2');
end
c=0;
for i=1:101
    a=(y1(i,1)+1.8844)/(y1(i,1)-1);
    b=(y2(i,1)-1.0308)/(y2(i,1)-1);
    c=c+a/b;
end
g=c/100;
m = zeros(101,1);
for i=1:101
    a=(y1(i,1)+1.8844)/(y1(i,1)-1);
    b=(y2(i,1)-1.0308)/(y2(i,1)-1);
    m(i,1)=(a/b-g)^2;
end
R2=trapz(t,m);
ISE1=var(y1);
ISE2=var(y2);
T1=100;
T2=100;
% mm=0.4*R2+0.2*ISE1+0.2*ISE2+0.1*T1+0.1*T2; %AHP
mm=0.42*R2+0.2*ISE1+0.18*ISE2+0.1*T1+0.1*T2; %OPA
