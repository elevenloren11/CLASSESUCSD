
clc; clear all; 
%% Problem 1
D_lead= tf([1 2.673], [1 37.417]);
bode( D_lead); 
[mag, phase]=bode(D_lead,10); 
verfiy if the phase is at 5 degrees 
disp(phase); 
bode( D_lead)
grid on; 

%% Problem 2
%2a)
 D_lag= tf([1 0.8838],[1 0.008838]);
 [mag, phase]=bode(D_lag,10); 
 %verfiy if the phase is at 5 degrees 
 disp(phase); 
 figure(1)
 bode( D_lag)
 grid on; 

%2b)
D_double_lag = (tf([1 0.4851], [1  0.04851]))^2;
[mag, phase]=bode(D_double_lag,10); 
%verfiy if the phase is at 5 degrees 
disp(phase);

% Plot Bode Diagrams
 figure(2);
 bode(D_lag, 'b-', D_double_lag, 'r--');
 grid on;
 legend('D_{lag} ', 'D_{double-lag} ', 'Location', 'best');

%% Problem 3
% 3a)
 F1=RR_LPF_butterworth(4,299.5), close all, 
 figure(1);
 RR_bode(F1);
 grid on; 

%3b) 
 F2=RR_LPF_inv_chebyshev(4,0.001,986), close all, 
RR_bode(F2)
figure(3);

% Butterworth Plot 
g1.ls = 'b-';
RR_bode(F1, g1);
hold on;
% Inverse Chebyshev 
g2.ls = 'r--';
RR_bode(F2, g2);

%% Problem 4

% 4b)
%Inputted numerator and denominator from part 4a)
% Lead Compensator 
num_lead = [1, 2.673];den_lead = [1, 37.417];

%Double-Lag
num_lag = conv([1, 0.4851], [1, 0.4851]);
den_lag = conv([1, 0.04851], [1, 0.04851]);

% Inverse Chebyshev Filter 
num_inv_cheb = [0.001, 0, 7777.63, 0, 7.5613e9];
den_inv_cheb = [1e9, 763.5795, 2.9153e5, 6.5507e7, 7.5613e9];

%combined all for better computation 
ys = conv(conv(num_lead, num_lag), num_inv_cheb);
xs = conv(conv(den_lead, den_lag), den_inv_cheb);

h=0.01; omegac=10;    
Ds=RR_tf(ys, xs);[Dz]=RR_C2D_tustin(Ds, h, omegac);

disp('Corresponding Matlab solution:')
opt = c2dOptions('Method', 'tustin', 'PrewarpFrequency', omegac); 
c2d(tf(ys, xs), h, opt)
%% Problem 5

%5a) 
 G=tf([100], [ 1 0 -100]);
%for comparison
%figure(1);
%rlocus(G)

%D_simple (lead compensator) 
K=3.034; %gain
D_simple=tf([1 10], [1 20.34]);
L_simple= D_simple*G; 
figure(2);
rlocus(L_simple)


% 5b)
%used code from problem 4 and edited it 
% Lead Compensator 
num_lead = [1, 2.673];den_lead = [1, 37.417];

%Double-Lag
num_lag = conv([1, 0.4851], [1, 0.4851]);
den_lag = conv([1, 0.04851], [1, 0.04851]);

% Inverse Chebyshev Filter 
num_inv_cheb = [0.001, 0, 7777.63, 0, 7.5613e9];
den_inv_cheb = [1e9, 763.5795, 2.9153e5, 6.5507e7, 7.5613e9];

%combined all for better computation 
ys = conv(conv(num_lead, num_lag), num_inv_cheb);
xs = conv(conv(den_lead, den_lag), den_inv_cheb);
D=tf(ys, xs);
L=D*G;

%tuning overall gain
omegag=10;
mag_omega=abs(freqresp(L, omegag));
K_loop_shaping=1/mag_omega;

D_loop_shaping=K_loop_shaping*D;
L_loop_shaping=D_loop_shaping*G;

figure(3);
subplot(1,2,1); rlocus(L_simple); title('Root Locus: G(s) D_{simple}(s)');
subplot(1,2,2); rlocus(L_loop_shaping); title('Root Locus: G(s) D_{loop-shaping}(s)');

% Bode Plot Comparison
figure(4);
bode(L_simple, L_loop_shaping);
legend('G(s) D_{simple}(s)', 'G(s) D_{loop-shaping}(s)');
grid on;
title('Bode Plot Comparison');

% Closed-Loop Step Response Comparison
T_simple = feedback(L_simple, 1);
T_loop_shaping = feedback(L_loop_shaping, 1);

figure(5);
step(T_simple, T_loop_shaping);
legend('Simple Control', 'Loop-Shaping Control');
grid on;
title('Closed-Loop Step Response Comparison');


