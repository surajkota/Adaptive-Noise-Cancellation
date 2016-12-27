%SNR

num=0;
erledem=zeros(10);
erle1=zeros(10);
for m=[6, 10, 15, 20, 25, 30,35, 40,45 ,50]
sumerr=0;
    for inrt=1:70000-m
        sumerr=sumerr+(SplusN(inrt)*SplusN(inrt));
    end
erlenum=sumerr/(70000-m);
num=num+1;
    sumerr=0;
    for inrt=1:70000-m
        sumerr=sumerr+(err(inrt,num)*err(inrt,num));

    end
    erledem(num)=sumerr/(70000-m);
    erle1(num)=10*log(erlenum/erledem(num));
end

% erit=4
%     sumerr=0;
%     for inrt=1:69998
%         sumerr=sumerr+(err(inrt,erit+1)*err(inrt,erit+1));
% 
%     end
%     erledem(erit)=sumerr/(70000-m);
%     erle1(erit)=erlenum/erledem(erit);

x1=[6, 10, 15, 20, 25, 30,35, 40,45 ,50];
plot(x1,erle1);
xlabel('Filter order');
ylabel('SNR');
title('SNR vs filter order');