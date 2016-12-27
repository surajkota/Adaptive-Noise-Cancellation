load('project1.mat');
SplusN=transpose(reference);
Noise=transpose(primary);
num=0;
kk=0;
wtrow=1;
wtcol=1;
for m=[6, 10, 15, 20, 25, 30,35, 40,45 ,50]
    ntest=size(SplusN,1);
    Y=SplusN(m:ntest,:);
    X = zeros(ntest-m,m);
    for i=1:m
        X(:,m-i+1) = Noise(i:ntest+i-m-1,:); %X(:,m-(i-1)
    end
    
    for i=0.1
        kk=kk+1;
        wtcol=0;
        stepsizes(kk,:)=i;
        sumerr=0;
        for j=1:m
                w(wtrow+j-1,1)=0;
        end
        
        for k=1:floor(70000-m)
           num=num+1;
           %wtcol=wtcol+1;
           err(k,kk)=Y(k,:)-X(k,:)*w(wtrow:wtrow+m-1,k); %w(1:m,num)
           %errorfi(k)=abs(err(k)^2);
           sumerr=sumerr+(err(k,kk).*err(k,kk));
           msecurr=(1/k)*(sumerr);
           mseerrorfi(k,kk)=msecurr;
           w(wtrow:wtrow+m-1,k+1)=w(wtrow:wtrow+m-1,k)+((i/(0.001+(X(k,:)*transpose(X(k,:)))))*err(k,kk)*transpose(X(k,:)));
        end
        wtrow=wtrow+m;
        mseplot(kk,:)=(sumerr/(70000-m));
        %mm(num,:)=m;
    end
end
%{
plot(mseerrorfi(:,(1:5)));
figure
plot(w(40,:));
hold on
for j=41:50
plot(w(j,:));
end
xlabel('Data Points');
ylabel('Magnitude');
title('10 Weight Tracks for filter order 10 and step size 0.1');
hold off

figure
plot([0.001, 0.01, 0.05, 0.1],mseplot(1:4))
hold on
plot([0.001, 0.01, 0.05, 0.1],mseplot(5:8))
plot([0.001, 0.01, 0.05, 0.1],mseplot(9:12))
xlabel('Step sizes');
ylabel('MSE');
legend('Filter order 10', 'Filter order 20', 'Filter order 50');
title('MSE for different filter orders vs step size');
hold off
%}
%{
figure
plot(w(1,:));
hold on
plot(w(2,:));
xlabel('Data Points');
ylabel('Magnitude');
legend('w0','w1');
title('Weight Tracks for step size 0.001');
hold off

figure
p=plot(mseerrorfi);
xlabel('Iterations');
ylabel('Mean Square Error');
title('Learning curve for filter order 2 and 5 different step sizes using NLMS');
legend('Learning curve for Step size 0.001','Learning curve for Step size 0.01','Learning curve for Step size 0.05','Learning curve for Step size 0.5','Learning curve for Step size 0.1');
%p(1).LineWidth = 2;
%p(1).Marker = '*';

figure
plot([0.001,0.01,0.05,0.1],msepplot)
xlabel('Step size')
ylabel('MSE')
title('MSE vs Step size for filter order 2')
title('MSE vs step size for filter order 2')

figure
p=plot(mseerrorfi(:,(1:3)));
hold on
plot(mseerrorfi(:,5));
xlabel('Iterations');
ylabel('Mean Square Error');
title('Learning curve for filter order 2 and 5 different step sizes using NLMS');
legend('Learning curve for Step size 0.001','Learning curve for Step size 0.01','Learning curve for Step size 0.05','Learning curve for Step size 0.1');
p(2).LineWidth = 2;
%}
% 
% figure
% hold on
% plot(w(7,:));
% plot(w(8,:));
% xlabel('');
% ylabel('');
% hold off
%tri=delaunay(w(7,2:69999),w(8,2:69999));
%trisurf(tri,w(7,2:69999),w(8,2:69999),mseerrorfi(:,4));

%{
for m=[15, 18, 20, 25, 30, 35, 40]
    ntest=size(SplusN,1);
    Y=SplusN(m:ntest,:);
    X = zeros(ntest-m,m);
    for i=1:m
        X(:,m-i+1) = Noise(i:ntest+i-m-1,:); %X(:,m-(i-1)
    end
    %{
    %X=flipud(X) R=transpose(X)*X; [V,D]=eig(R); %disp(D); A=max(D);
    lmax=max(A'); umax=1/lmax; sz=umax/10; i=0;
    %}
    for itr=[0.001, 0.01, 0.03, 0.05, 0.1, 0.5, 1]
        i=itr;
        
        num=num+1;
        kk=kk+1;
        for j=1:m
            w(j,num)=0;
        end
        stepsizes(num,:)=i;
        sumerr=0;
        for k=1:floor(70000-m-1)
           err(k,num)=Y(k,:)-X(k,:)*w(:,num); %w(1:m,num)
           %errorfi(k)=abs(err(k)^2);
           sumerr=sumerr+(err(k)*err(k));
           msecurr=(1/k)*(sumerr);
           mseerrorfi(k,num)=msecurr;
           w(:,num)=w(:,num)+(2*i*err(k,num)*transpose(X(k,:))/(X(k,:)*transpose(X(k,:))));
        end
        mseplot(num,:)=(sumerr/(70000-m));
        mm(num,:)=m;
    end
end

[po,pos]=min(mseplot);
%}

%sound(err,fs)
%{
tri=delaunay(mm,stepsizes);
trisurf(tri,mm,stepsizes,mseplot);
xlabel('Filter order: M');
ylabel('Step size: ita');
zlabel('Mean Square Error')
%}