%% HW#3
%Problem #1
s=tf('s');
G0=exp(-d*s)/(s+a);

% Small value of K gain 
K0=0.1; L0=K0*G0; T0=feedback(L0,1); figure(1);
%checking for instability based on the figure 
nyquist(L0); 
title( 'Nyquist Plot: Small K')

% Large value of K gain 
%checking for instability based on the figure 
figure(2);
K1=20; L1=K1*G0; T1=feedback(L1,1);
nyquist(L1);
title( 'Nyquist Plot: Large K')

%%
%Problem #3
 clear; close all, d=0.1; a=1; G=RR_pade(d,2,2)*RR_tf(1,[1 a]);
 D=16.47; 
 L=G*D;
 figure(3), RR_rlocus(G*D)
%%
%Problem #4 
 clear; close all, d=0.1; a=1; G=RR_pade(d,2,2)*RR_tf(1,[1 a]);
 D=1; 
 L=G*D;
 figure(4),RR_rlocus(G*D);
 omega=16.48
 figure(5), D=1*real(RR_evaluate(-1/L,i*omega)), RR_rlocus(G*D), 

%%
 %Problem #5
 clear; close all, d=0.1; a=1; G=RR_pade(d,16,12)*RR_tf(1,[1 a]);
 D=1;  L=G*D;
figure(6);RR_rlocus(G*D);
omega=16.32;
figure(7), D=1*real(RR_evaluate(-1/L,i*omega)), RR_rlocus(G*D), 

D1=16.4;
figure(8);RR_rlocus(G*D1) ;



%% Problem 6
clear; close all;

d = 0.1;a = 1;
s = tf('s');

[num,den] = pade(d,2);G= tf(num,den)/(s+a);

%K/2
K_half= 16.47/2;

% Kcrit/2
figure(9);
nyquist((K_half)*G);
title('Nyquist Plot: K/2');

% 2K
K_twice=16.48*2;
figure(10);
nyquist((2*K_twice)*G);
title('Nyquist Plot:2K');




